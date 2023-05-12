return {
  {
    "kbario/spear.nvim",
    -- ft = { "tsx", "ts", "html", "css", "scss", "sass" },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "kbario/homerows.nvim",
        opts = {
          custom_keys = {
            spear = "l3"
          }
        }
      }
    },
    config = true,
    keys = function()
      local hr = require("homerows").lazy_hr()
      return {
        {
          "<leader>" .. hr.spear,
          desc = "󱡅 Spear"
        },
      }
    end,
    dev = false
  },
  {
    "kbario/homerows.nvim",
    build = function() require("homerows").build() end,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      prefs = { "programmers_dvorak", "colemak_dh" },
      add_to_keymap = false,
      add_are_keymap = false,
      custom_keys = {
        me = "l1t",
      },
    },
    lazy = false,
    priority = 10000,
    version = "*",
    dev = false,
    config = function(_, opts)
      require("homerows").setup(opts)
      require("config.keymaps")
    end
  }
}
