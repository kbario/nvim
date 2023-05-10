local ensure_mason = require("config.clients").ensure_mason
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
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(ensure_mason) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
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
    "jay-babu/mason-null-ls.nvim",
    event = "BufEnter",
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
