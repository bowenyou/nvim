local M = {}

M.on_attach = function(client, bufnr)
  local handler_ok, handler = pcall(require, "user.lsp.handlers")
  if not handler_ok then
    vim.notify("user.lsp.handlers not found")
    return
  end
  handler.on_attach(client, bufnr)
  local inlay_hints_ok, inlay_hints = pcall(require, "lsp-inlayhints")
  if not inlay_hints_ok then
    vim.notify("lsp-inlayhints not found")
    return
  end
  inlay_hints.setup({
    inlay_hints = { type_hints = { prefix = "=> " } }
  })
  inlay_hints.on_attach(client, bufnr)
  local illuminate_ok, illuminate = pcall(require, "illuminate")
  if not illuminate_ok then
    vim.notify("illuminate not found")
    return
  end
  illuminate.on_attach(client)
end

M.settings = {
  gopls = {
    analyses = {
      nilness = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
      fillstruct = true,
    },
    experimentalPostfixCompletions = true,
    gofumpt = true,
    staticcheck = true,
    usePlaceholders = true,
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true
    }
  }
}

return M
