local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("lewis6991/impatient.nvim")
	use("nvim-tree/nvim-web-devicons")
	use({
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		tag = "nightly",
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- color scheme
	use("folke/tokyonight.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/Luasnip")
	use("rafamadriz/friendly-snippets")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
	use("RRethy/vim-illuminate")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		tag = "0.1.0",
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- git
	use("lewis6991/gitsigns.nvim")

	-- rust
	use("simrat39/rust-tools.nvim")

	-- move
	use("rvmelkonian/move.vim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
