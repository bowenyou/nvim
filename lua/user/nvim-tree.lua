local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

nvim_tree.setup({
	update_cwd = true,
	open_on_setup = true,
	open_on_setup_file = true,
	git = {
		enable = true,
		ignore = false,
	},
})
