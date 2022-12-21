local status_ok, lightbulb = pcall(require, "nvim-lightbulb")
if not status_ok then
  vim.notify("nvim-lightbulb not found")
  return
end

vim.api.nvim_create_autocmd(
  { "CursorHold", "CursorHoldI" },
  {
    pattern = "*",
    command = "lua require('nvim-lightbulb').update_lightbulb()"
  }
)
