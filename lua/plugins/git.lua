return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = vim.fn.executable "git" == 1,
		ft = "gitcommit",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "▎" },
			},
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			-- stylua: ignore start
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Prev Hunk")
			map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
			map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
			map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
			map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
			map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
			map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
			map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
			map("n", "<leader>ghd", gs.diffthis, "Diff This")
			map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
		end,
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
