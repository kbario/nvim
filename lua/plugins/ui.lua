return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        "kbario/homerows.nvim",
        opts = {
          custom_keys = {
            neotree = "l4"
          }
        }
      }
    },
    cmd = "Neotree",
    keys = function()
      local hr = require("homerows").lazy_hr()
      return {
        {
          "<leader>" .. hr.neotree .. hr.r1,
          "<cmd> NeoTreeToggle <CR>",
          desc = " NeoTree: Open",
        },
        {
          "<leader>" .. hr.neotree .. hr.r2,
          "<cmd> NvimTreeFocus <CR>",
          desc = " NeoTree: Focus",
        },
        {
          "<leader>" .. hr.neotree .. hr.r3,
          "<cmd> NvimTreeFindFile <CR>",
          desc = " NeoTree: Nav to current file",
        },
        {
          "<leader>" .. hr.neotree .. hr.r4,
          "<cmd> NvimTreeCollapse <CR>",
          desc = " NeoTree: Close",
        }
      }
    end,
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
        },
        bind_to_cwd = false,
        follow_current_file = true,
        use_libuv_file_watcher = true,
        components = {
          harpoon_index = function(config, node, state)
            local Marked = require("harpoon.mark")
            local path = node:get_id()
            local succuss, index = pcall(Marked.get_index_of, path)
            if succuss and index and index > 0 then
              return {
                text = string.format(" 󱡅 %d", index), -- <-- Add your favorite harpoon like arrow here
                highlight = config.highlight or "NeoTreeDirectoryIcon",
              }
            else
              return {}
            end
          end
        },
        renderers = {
          file = {
            { "indent" },
            { "icon" },
            {
              "container",
              content = {
                {
                  "name",
                  zindex = 10
                },
                { "clipboard",     zindex = 10 },
                { "bufnr",         zindex = 10 },
                { "harpoon_index", zindex = 20, align = "right" },
                { "modified",      zindex = 20, align = "right" },
                { "diagnostics",   zindex = 20, align = "right" },
                { "git_status",    zindex = 20, align = "right" },
              },
            },
          },
        }
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
          -- padding = 0,
          -- indent_size = 1
        },
        icon = {
          folder_closed = "󰉋",
          folder_open = "󰝰",
          folder_empty = "󰉖",
          folder_empty_open = "󰷏",
        },
        modified = { symbol = "󱇧" },
      },
    },
  },
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
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "terminal" }, -- "NvimTree" },
      indentLine_enabled = 1,
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    },
    config = function(_, opts)
      -- vim.opt.list = true
      -- vim.opt.listchars:append "space:⋅"
      -- vim.opt.listchars:append "eol:↴"

      require("indent_blankline").setup(opts)
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      text = {
        spinner = "dots_snake",  -- animation shown when tasks are ongoing
        done = "",            -- character shown when all tasks are complete
        commenced = "Started",   -- message shown when task starts
        completed = "Completed", -- message shown when task completes
      },
    },
    event = "BufEnter",
  }

}
