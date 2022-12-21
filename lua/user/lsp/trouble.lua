local trouble_status_ok, trouble = pcall(require, "trouble")
if not trouble_status_ok then
  vim.notify("trouble not found")
  return
end

trouble.setup()

local bufopts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>tt", "<Cmd>TroubleToggle<CR>", bufopts)
vim.keymap.set("n", "<leader>tc", "<Cmd>TroubleClose<CR>", bufopts)
vim.keymap.set("n", "<leader>tf", "<Cmd>TroubleToggle document_diagnostics<CR>", bufopts)
vim.keymap.set("n", "<leader>td", "<Cmd>TroubleToggle workspace_diagnostics<CR>", bufopts)
