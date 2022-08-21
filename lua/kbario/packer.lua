vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colours
  use 'folke/tokyonight.nvim'
  use 'joshdick/onedark.vim'

  use {
      'nvim-lualine/lualine.nvim', 
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use("sbdchd/neoformat")
  
  use("neovim/nvim-lspconfig")

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    }

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("onsails/lspkind-nvim")
  use("nvim-lua/lsp_extensions.nvim")
  use("glepnir/lspsaga.nvim")
  use("simrat39/symbols-outline.nvim")

  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
end)
