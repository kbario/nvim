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
          "<leader>" .. hr.spear .. hr.r0,
          function() require("spear.spear").spear({ ".module.ts", "_helper.ts", "_utils.ts", "_helper.js", "utils.js" }) end,
          desc = "󱡅 spear: nav to module/helper/utils"
        },
        {
          "<leader>" .. hr.spear .. hr.r1,
          function()
            require("spear.spear").spear(
              { ".component.ts", ".service.ts", ".pipe.ts", ".tsx", ".ts", ".jsx", ".js" },
              { match_pref = "next" }
            )
          end,
          desc = "󱡅 spear: nav to main file"
        },
        {
          "<leader>" .. hr.spear .. hr.r2,
          function() require("spear.spear").spear(".component.html", ".html") end,
          desc = "󱡅 spear: nav to "
        },
        {
          "<leader>" .. hr.spear .. hr.r3,
          function()
            require("spear.spear").spear({ ".component.css", ".component.scss", ".component.sass", ".css" })
          end,
          desc = "󱡅 spear: nav to "
        },
        {
          "<leader>" .. hr.spear .. hr.r4,
          function()
            require("spear.spear").spear(
              { ".component.spec.ts", ".service.spec.ts", ".pipe.spec.ts" },
              { match_pref = "next" }
            )
          end,
          desc = "󱡅 spear: nav to "
        },
      }
    end
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
    dev = true
  }
}
