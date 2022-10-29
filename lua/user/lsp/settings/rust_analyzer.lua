return {
  server = {
    on_attach = require("user.plugins.lsp.handlers").on_attach,
    capabilities = require("user.plugins.lsp.handlers").capabilities,
    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = true,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
