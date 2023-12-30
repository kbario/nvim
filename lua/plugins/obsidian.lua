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
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
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
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      -- substitutions = {
      --   yesterday = function()
      --     return os.date("%Y-%m-%d", os.time() - 86400)
      --   end
    },

    -- see below for full list of options 👇
  },
}
