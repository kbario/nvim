local utes = require("utils")
return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "kbario/homerows.nvim",
      opts = {
        custom_keys = {
          prime = "l2"
        }
      }
    },
    opts = {
      global_settings = {
        mark_branch = true,
      }
    },
    keys = function()
      local hr = require("homerows").lazy_hr()
      return {
        {
          "<leader>" .. hr.prime .. hr.r0,
          function() require("harpoon.mark").add_file() end,
          desc = "󰠳 Harpoon: Add a mark"
        },
        {
          "<leader>" .. hr.prime .. hr.R0,
          function() require("harpoon.ui").toggle_quick_menu() end,
          desc = "󰠳 Harpoon: Open list"
        },
        {
          "<leader>" .. hr.prime .. hr.r1,
          function() require("harpoon.ui").nav_file(1) end,
          desc = "󰠳 Harpoon: Nav to 1"
        },
        {
          "<leader>" .. hr.prime .. hr.r2,
          function() require("harpoon.ui").nav_file(2) end,
          desc = "󰠳 Harpoon: Nav to 2"
        },
        {
          "<leader>" .. hr.prime .. hr.r3,
          function() require("harpoon.ui").nav_file(3) end,
          desc = "󰠳 Harpoon: Nav to 3"
        },
        {
          "<leader>" .. hr.prime .. hr.r4,
          function() require("harpoon.ui").nav_file(4) end,
          desc = "󰠳 Harpoon: Nav to 4"
        },
      }
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "kbario/homerows.nvim",
        opts = {
          custom_keys = {
            prime = "l2"
          }
        }
      },
    },
    keys = function()
      local hr = require("homerows").lazy_hr()
      return {
        "<leader>" .. hr.prime .. hr.r1b,
        { ":lua require('refactoring').select_refactor()<CR>", mode = 'v' },
        desc = "󱇧 Refactor: Select",
        noremap = true,
        silent = true,
        expr = false,
      }
    end
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood"
  },
}
