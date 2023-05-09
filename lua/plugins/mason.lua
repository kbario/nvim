local ensure_mason_lsp = require("config.clients").ensure_mason_lsp
local ensure_mason_null_ls = require("config.clients").ensure_mason_null_ls
local ensure_mason_dap = require("config.clients").ensure_mason_dap

return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ﮊ",
        },
      },
    },
    max_concurrent_installers = 10,
    build = ":MasonUpdate",
    event = "BufEnter",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = true,
    event = "BufEnter",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    event = "BufEnter",
    opts = {
      automatic_installation = true,
      ensure_installed = ensure_mason_lsp,
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      automatic_installation = true,
      automatic_setup = true,
      ensure_installed = ensure_mason_null_ls
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    event = "BufEnter",
    opts = {
      automatic_installation = true,
      ensure_installed = ensure_mason_dap,
    },
  },
}
