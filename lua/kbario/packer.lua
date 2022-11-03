vim.cmd("packadd packer.nvim")

return require('packer').startup(function(use)
  local local_use = function(plug_name, opts)
    opts = opts or {}

    if vim.fn.isdirectory(vim.fn.expand("~/luaProjects/" .. plug_name)) == 1 then
      opts[1] = "~/luaProjects/" .. plug_name
    end

    use(opts)
  end

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- colours
  use 'folke/tokyonight.nvim'
  use 'joshdick/onedark.vim'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use("nvim-treesitter/playground")

  -- harpoon
  use 'nvim-lua/plenary.nvim'
  use 'ThePrimeagen/harpoon'

  -- lualine
  use("nvim-lualine/lualine.nvim")
  -- icons
  use("kyazdani42/nvim-web-devicons")


  use("sbdchd/neoformat")

  -- mason is a lsp server manager (among other things)
  -- makes it easy to manage the LSPs on your system
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  use("neovim/nvim-lspconfig")

  -- lsp completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("onsails/lspkind-nvim")
  use("nvim-lua/lsp_extensions.nvim")
  use("glepnir/lspsaga.nvim")
  use("simrat39/symbols-outline.nvim")

  -- lua snippet plugin
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")

  use("ThePrimeagen/vim-be-good")

  -- debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")

  -- TODO highlighting
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- prettier
  use('numToStr/prettierrc.nvim')

  -- notifications and updates
  use('j-hui/fidget.nvim')

  -- beastmode commenting
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- markdown preview
  use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" }
  })

  -- kbario plugins
  use("kbario/spear.nvim")
  use("kbario/homerows.nvim")
  -- local_use("spear.nvim")
  -- local_use("homerows.nvim")
end)
