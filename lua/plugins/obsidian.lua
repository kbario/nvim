-- setup info https://github.com/epwalsh/obsidian.nvim?tab=readme-ov-file#plugin-dependencies
return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/brain/**.md"
  },
  dependencies = {
    {
      "kbario/homerows.nvim",
      opts = {
        custom_keys = {
          obsid = "l2t"
        }
      }
    },
    "nvim-lua/plenary.nvim",
    -- see below for full list of optional dependencies 👇
  },
  keys = function()
    local ok, hrr = pcall(require, "homerows")
    if not ok then return end
    local hr = hrr.lazy_hr()
    return {
      {
        "<leader>" .. hr.obsid .. hr.r1,
        "<cmd> ObsidianToday<CR>",
        "󰇈 Obsidian: Today",
      },
    }
  end,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/brain/personal",
      },
      {
        name = "work",
        path = "~/brain/work",
      },
    },
    templates = {
      subdir = "../templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      -- substitutions = {
      --   yesterday = function()
      --     return os.date("%Y-%m-%d", os.time() - 86400)
      --   end
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "daily.md"
    },
    -- see below for full list of options 👇
  },
}
