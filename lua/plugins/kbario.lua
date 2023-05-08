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
          desc = "󱡅 Spear: Nav to module/helper/utils"
        },
        {
          "<leader>" .. hr.spear .. hr.r1,
          function()
            require("spear.spear").spear(
              { ".component.ts", ".service.ts", ".pipe.ts", ".tsx", ".ts", ".jsx", ".js" },
              { match_pref = "next" }
            )
          end,
          desc = "󱡅 Spear: Nav to main file"
        },
        {
          "<leader>" .. hr.spear .. hr.r2,
          function() require("spear.spear").spear(".component.html", ".html") end,
          desc = "󱡅 Spear: Nav to template"
        },
        {
          "<leader>" .. hr.spear .. hr.r3,
          function()
            require("spear.spear").spear({ ".component.css", ".component.scss", ".component.sass", ".css" })
          end,
          desc = "󱡅 Spear: Nav to styles"
        },
        {
          "<leader>" .. hr.spear .. hr.r4,
          function()
            require("spear.spear").spear(
              { ".component.spec.ts", ".service.spec.ts", ".pipe.spec.ts" },
              { match_pref = "next" }
            )
          end,
          desc = "󱡅 Spear: Nav to tests"
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
      custom_keys = {
        me = "l1t",
      },
    },
    lazy = false,
    priority = 10000,
    version = "*",
    dev = true,
    config = function(_, opts)
      require("homerows").setup(opts)
      require("config.keymaps")
    end
  }
}
