local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  vim.notify("mason not found")
  return
end

local mason_config_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_config_status_ok then
  vim.notify("mason-lspconfig not found")
  return
end

local servers = {
  "sumneko_lua",
  "rust_analyzer",
  "eslint",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "gopls",
  "solang",
  "solc",
  "solidity",
  "marksman",
}

local settings = {
  ui = {
    border = "rounded",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

table.insert(servers, "move_analyzer")
table.insert(servers, "solidity_ls")

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify("lspconfig not found")
  return
end

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "sumneko_lua" then
    local require_ok, conf_opts = pcall(require, "user.lsp.settings.sumneko_lua")
    if require_ok then
      opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end
  end

  if server == "rust_analyzer" then
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      vim.notify("rust-tools not found")
      return
    end
    local rust_tools_config_status_ok, rust_tools_conf = pcall(require, "user.lsp.settings.rust_analyzer")
    if not rust_tools_config_status_ok then
      vim.notify("user.lsp.settings.rust_analyzer not found")
      return
    end

    rust_tools.setup(rust_tools_conf)
    goto continue
  end

  if server == "gopls" then
    local gopls_status_ok, gopls = pcall(require, "user.lsp.settings.gopls")
    if not gopls_status_ok then
      vim.notify("user.lsp.settings.gopls not found")
      return
    end
    opts.on_attach = gopls.on_attach
    opts.settings = gopls.settings
  end

  lspconfig[server].setup(opts)
  ::continue::
end
