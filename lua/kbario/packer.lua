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

  -- everything relies on
  use 'nvim-lua/plenary.nvim'

  -- colours
  use 'folke/tokyonight.nvim'
  use 'joshdick/onedark.vim'
  use { "catppuccin/nvim", as = "catppuccin",
    config = function()
      require("catppuccin").setup {
        flavour = 'macchiato'
      }
    end
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use("nvim-telescope/telescope-dap.nvim")

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }
  use("nvim-treesitter/playground")

  -- the Primeagen
  use 'ThePrimeagen/harpoon'
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"
    }
  }
  use("ThePrimeagen/vim-be-good")

  -- lualine
  use("nvim-lualine/lualine.nvim")
  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- mason is a lsp server manager (among other things)
  -- makes it easy to manage the LSPs on your system
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",
  }


  -- lsp completion
  use("neovim/nvim-lspconfig")
  use("jose-elias-alvarez/typescript.nvim")
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


  -- debugging
  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text")
  -- use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  -- use {
  --   "microsoft/vscode-js-debug",
  --   opt = true,
  --   run = "npm install --legacy-peer-deps && npm run compile"
  -- }

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

  require('packer').use { 'mhartington/formatter.nvim' }

  -- prettier
  use('numToStr/prettierrc.nvim')
  -- use { "prettier/vim-prettier",
  --   run = 'npm install --frozen-lockfile --production',
  --   ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml',
  --     'html' } }

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

  use {
    'phaazon/mind.nvim',
    branch = 'v2.2',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'mind'.setup()
    end
  }

  -- git
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
  use("mbbill/undotree")
  -- use('tpope/vim-fugitive')
  -- use('kdheepak/lazygit.nvim')
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup {}
    end
  }
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })

  -- python
  use {
    "ahmedkhalf/jupyter-nvim",
    run = ":UpdateRemotePlugins",
    config = function()
      require("jupyter-nvim").setup()
    end
  }

  -- vscode port
  use {
    'EthanJWright/vs-tasks.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      require("vstask").setup()
    end
  }

  -- kbario plugins
  use {
    "kbario/spear.nvim",
    config = function()
      require("spear").setup()
    end
  }
  use { "kbario/homerows.nvim",
    config = function()
      require("homerows").setup({
        pref = { "programmers_dvorak", "colemak_dh" },
        add_print_keymap = true,
        add_change_keymap = true
      })
    end
  }

  -- local_use("spear.nvim")
  -- local_use("homerows.nvim")
end)
