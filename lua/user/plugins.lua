local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  print("Installing packer, close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim"]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("packer not found")
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
  use("nvim-lua/plenary.nvim")

  -- color scheme
  use("folke/tokyonight.nvim")


  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		tag = "0.1.0",
	})

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

  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("lewis6991/impatient.nvim")
  use("simrat39/symbols-outline.nvim")
  use("kosayoda/nvim-lightbulb")

  -- lsp
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use({
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  })
  use("lvimuser/lsp-inlayhints.nvim")

  use("RRethy/vim-illuminate")

  -- completion
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")

  -- snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  -- git
  use("lewis6991/gitsigns.nvim")



  -- rust
  use("simrat39/rust-tools.nvim")

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

