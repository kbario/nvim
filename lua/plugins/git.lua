return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "kbario/homerows.nvim",
      opts = {
        custom_keys = {
          signs = "l1t"
        }
      }
    },
    enabled = vim.fn.executable "git" == 1,
    ft = "gitcommit",
    on_attach = function(buffer)
      local hr = require("homerows").lazy_hr()
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r1t,
        gs.next_hunk,
        "󰊢 Git: Next Hunk"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r2t,
        gs.prev_hunk,
        "󰊢 Git: Prev Hunk"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r1,
        gs.preview_hunk,
        "󰊢 Git: Preview Hunk"
      )
      map(
        { "o", "x" },
        "<leader>" .. hr.signs .. hr.r1,
        ":<C-U>Gitsigns select_hunk<CR>",
        "󰊢 Git: Select Hunk"
      )
      map(
        { "n", "v" },
        "<leader>" .. hr.signs .. hr.R1,
        ":Gitsigns stage_hunk<CR>",
        "󰊢 Git: Stage Hunk"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r2,
        gs.undo_stage_hunk,
        "󰊢 Git: Undo Stage Hunk"
      )
      map(
        { "n", "v" },
        "<leader>" .. hr.signs .. hr.R2,
        ":Gitsigns reset_hunk<CR>",
        "󰊢 Git: Reset Hunk"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r3,
        gs.stage_buffer,
        "󰊢 Git: Stage Buffer"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.R2,
        gs.reset_buffer,
        "󰊢 Git: Reset Buffer"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r1b,
        function() gs.blame_line({ full = true }) end,
        "󰊢 Git: Blame Line"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.r2b,
        gs.diffthis,
        "󰊢 Git: Diff This"
      )
      map(
        "n",
        "<leader>" .. hr.signs .. hr.R2b,
        function() gs.diffthis("~") end,
        "󰊢 Git: Diff This ~"
      )
    end,
    config = true,
  },
  -- {
  -- 	"sindrets/diffview.nvim",
  -- 	dependencies = "nvim-lua/plenary.nvim",
  -- 	cmd = {
  -- 		"DiffviewOpen",
  -- 		"DiffviewClose",
  -- 		"DiffviewToggleFiles",
  -- 		"DiffviewFocusFiles",
  -- 		"DiffviewRefresh",
  -- 	}
  -- },
  {
    "mbbill/undotree",
    cmd = {
      "UndotreeToggle",
      "UndotreeHide",
      "UndotreeShow",
      "UndotreeFocus",
    }
  },
  -- {'tpope/vim-fugitive'},
  -- {'kdheepak/lazygit.nvim'},
  --  {
  --   'TimUntersberger/neogit',
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('neogit').setup {},
  --   end
  -- },
  --  {
  --   'pwntester/octo.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'kyazdani42/nvim-web-devicons',
  --   },,
  --   config = function()
  --     require "octo".setup()
  --   end
  -- },
}
