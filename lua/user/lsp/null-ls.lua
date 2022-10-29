local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml", "solidity" },
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.shfmt,
		diagnostics.flake8,
		diagnostics.chktex,
		formatting.latexindent,
		formatting.rustfmt.with({
			extra_args = { "--edition=2021" },
		}),
		formatting.gofumpt,
		formatting.goimports,
		formatting.goimports_reviser,
		formatting.golines,
		diagnostics.golangci_lint,
	},
	on_attach = function(client, bufnr)
		if client.name == "tsserver" then
			client.resolved_capabiltiies.document_formatting = false
		end

		if client.name == "sumneko_lua" then
			client.resolved_capabiltiies.document_formatting = false
		end

		if client.name == "rust_analyzer" then
			client.resolved_capabilities.document_formatting = false
		end

		if client.name == "gopls" then
			client.resolved_capabilities.document_formatting = false
		end

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})

vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]])
