local symbols_status_ok, symbols = pcall(require, "symbols-outline")
if not symbols_status_ok then
  vim.notify("symbols-outline not found")
  return
end

symbols.setup({
  auto_close = false,
  highlight_hovered_item = true,
  position = "right",
  width = 15
})

local bufopts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>st", "<Cmd>SymbolsOutline<CR>", bufopts)
vim.keymap.set("n", "<leader>so", "<Cmd>SymbolsOutlineOpen<CR>", bufopts)
vim.keymap.set("n", "<leader>sc", "<Cmd>SymbolsOutlineClose<CR>", bufopts)
