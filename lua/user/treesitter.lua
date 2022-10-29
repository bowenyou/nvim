local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all", 
  ignore_install = { "phpdoc" }, 
  highlight = {
		enable = true, 
    disable = { "css" }, 	
  },
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
})
