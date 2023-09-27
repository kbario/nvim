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
      local ok, hrr = pcall(require, "homerows")
      if not ok then return end
      local hr = hrr.lazy_hr()
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
