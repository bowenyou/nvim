local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local config = {
		virtual_lines = true,
		virtual_text = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minmal",
			border = "rounded",
			source = "if_many",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

M.on_attach = function(client, bufnr)
	lsp_highlight_document(client)
end

return M
