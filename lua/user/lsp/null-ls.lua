local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  vim.notify("null-ls not found")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = true,
  sources = {
    diagnostics.checkmake,
    diagnostics.codespell,
    diagnostics.golangci_lint,
    diagnostics.write_good,
    diagnostics.zsh,
    formatting.autopep8,
    formatting.codespell,
    formatting.fixjson,
    formatting.goimports_reviser,
    formatting.golines,
    formatting.isort,
    formatting.lua_format,
    formatting.markdown_toc,
    formatting.mdformat,
    formatting.shformat,
    formatting.yamlfmt,
  },
})
