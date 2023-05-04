local utes = require("utils")
return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"kbario/homerows.nvim",
			opts = {
				custom_keys = {
					harpoon = "l2"
				}
			}
		},
		opts = {
			global_settings = {
				mark_branch = true,
			}
		},
		keys = function()
			local hr = require("homerows").lazy_hr()
			return {
				{
					"<leader>" .. hr.harpoon .. hr.r0,
					function() require("harpoon.mark").add_file() end,
					desc = "󰠳 Add a mark"
				},
				{
					"<leader>" .. hr.harpoon .. hr.R0,
					function() require("harpoon.ui").toggle_quick_menu() end,
					desc = "󰠳 Open list"
				},
				{
					"<leader>" .. hr.harpoon .. hr.r1,
					function() require("harpoon.ui").nav_file(1) end,
					desc = "󰠳 Nav to 1"
				},
				{
					"<leader>" .. hr.harpoon .. hr.r2,
					function() require("harpoon.ui").nav_file(2) end,
					desc = "󰠳 Nav to 2"
				},
				{
					"<leader>" .. hr.harpoon .. hr.r3,
					function() require("harpoon.ui").nav_file(3) end,
					desc = "󰠳 Nav to 3"
				},
				{
					"<leader>" .. hr.harpoon .. hr.r4,
					function() require("harpoon.ui").nav_file(4) end,
					desc = "󰠳 Nav to 4"
				},
			}
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{
				"<leader>" .. "x" .. "x",
				{ ":lua require('refactoring').select_refactor()<CR>", mode = 'v' },
				{
					noremap = true,
					silent = true,
					expr = false
				}
			}
		},
	},
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood"
	},
}
