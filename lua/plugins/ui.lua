return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --     dependencies = {
  --       "kbario/homerows.nvim",
  --       opts = {
  --         custom_keys = {
  --           nvimtree = "l4"
  --         }
  --       }
  --     },
  --   },
  --   keys = function()
  --     local hr = require("homerows").lazy_hr()
  --     return {
  --       {
  --         "<leader>" .. hr.nvimtree .. hr.r1,
  --         "<cmd> NvimTreeToggle <CR>",
  --         desc = " Nvim Tree: Open",
  --       },
  --       {
  --         "<leader>" .. hr.nvimtree .. hr.r2,
  --         "<cmd> NvimTreeFocus <CR>",
  --         desc = " Nvim Tree: Focus",
  --       },
  --       {
  --         "<leader>" .. hr.nvimtree .. hr.r3,
  --         "<cmd> NvimTreeFindFile <CR>",
  --         desc = " Nvim Tree: Nav to current file",
  --       },
  --       {
  --         "<leader>" .. hr.nvimtree .. hr.r4,
  --         "<cmd> NvimTreeCollapse <CR>",
  --         desc = " Nvim Tree: Close",
  --       }
  --     }
  --   end,
  --   config = function()
  --     require("nvim-tree").setup({
  --       filters = {
  --         dotfiles = true,
  --       },
  --       disable_netrw = true,
  --       hijack_netrw = true,
  --       hijack_cursor = true,
  --       hijack_unnamed_buffer_when_opening = false,
  --       sync_root_with_cwd = true,
  --       update_focused_file = {
  --         enable = true,
  --         update_root = false,
  --       },
  --       view = {
  --         adaptive_size = false,
  --         side = "left",
  --         width = 30,
  --         preserve_window_proportions = true,
  --       },
  --       git = {
  --         enable = true,
  --         ignore = true,
  --       },
  --       filesystem_watchers = {
  --         enable = true,
  --       },
  --       actions = {
  --         open_file = {
  --           resize_window = true,
  --         },
  --       },
  --       renderer = {
  --         root_folder_label = false,
  --         highlight_git = false,
  --         highlight_opened_files = "none",
  --
  --         indent_markers = {
  --           enable = false,
  --         },
  --
  --         icons = {
  --           show = {
  --             file = true,
  --             folder = true,
  --             folder_arrow = true,
  --             git = true,
  --           },
  --
  --           glyphs = {
  --             default = "󰈔",
  --             symlink = "󱁻",
  --             folder = {
  --               default = "󰉋",
  --               empty = "󰉖",
  --               empty_open = "󰷏",
  --               open = "󰝰",
  --               symlink = "󱁿",
  --               symlink_open = "󱂀",
  --               arrow_open = "",
  --               arrow_closed = "",
  --             },
  --             git = {
  --               unstaged = "✗",
  --               staged = "✓",
  --               unmerged = "",
  --               renamed = "➜",
  --               untracked = "★",
  --               deleted = "󰆴",
  --               ignored = "◌",
  --             },
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = true,
    opts = function()
      local icons = require("config.ui").icons
      --
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1,
                right = 0,
              },
            },
            { "filename", path = 1, symbols = { modified = " 󰷈 ", readonly = "", unnamed = "" } },
          },
          -- lualine_x = {
          -- 	-- stylua: ignore
          -- 	{
          -- 		function() return require("noice").api.status.command.get() end,
          -- 		cond = function()
          -- 			return package.loaded["noice"] and
          -- 				require("noice").api.status.command.has()
          -- 		end,
          -- 		color = Util.fg("Statement"),
          -- 	},
          -- 	-- stylua: ignore
          -- 	{
          -- 		function() return require("noice").api.status.mode.get() end,
          -- 		cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          -- 		color = Util.fg("Constant"),
          -- 	},
          -- 	-- stylua: ignore
          -- 	{
          -- 		require("lazy.status").updates,
          -- 		cond = require("lazy.status").has_updates,
          -- 		color = Util.fg("Special"),
          -- 	},
          lualine_y = {
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
          },
          lualine_z = {
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          -- lualine_z = {
          -- 	function()
          -- 		return " " .. os.date("%R")
          -- 	end,
          -- },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  -- colours
  {
    "folke/tokyonight.nvim",
    lazy = true,     -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme tokyonight]])
    -- end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 10001,
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      buftype_exclude = { "terminal" },
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "terminal" },  -- "NvimTree" },
      indentLine_enabled = 1,
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      text = {
        spinner = "dots_snake", -- animation shown when tasks are ongoing
        done = "",       -- character shown when all tasks are complete
        commenced = "Started", -- message shown when task starts
        completed = "Completed", -- message shown when task completes
      },
    },
    event = "BufEnter",
  }
}
