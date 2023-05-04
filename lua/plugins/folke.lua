return {
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		dependencies = {
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						folke = "l3b"
					}
				}
			}
		},
		keys = function(_, keys)
			local hr = require("homerows").lazy_hr()
			local mappings = {
				{
					"<leader>" .. hr.folke .. hr.r1,
					"<cmd>TroubleToggle document_diagnostics<cr>",
					desc = "Document Diagnostics (Trouble)"
				},
				{
					"<leader>" .. hr.folke .. hr.R1,
					"<cmd>TroubleToggle workspace_diagnostics<cr>",
					desc = "Workspace Diagnostics (Trouble)"
				},
				{
					"<leader>" .. hr.folke .. hr.r2,
					"<cmd>TroubleToggle loclist<cr>",
					desc = "Location List (Trouble)"
				},
				{
					"<leader>" .. hr.folke .. hr.R2,
					"<cmd>TroubleToggle quickfix<cr>",
					desc = "Quickfix List (Trouble)"
				},
				{
					"[q",
					function()
						if require("trouble").is_open() then
							require("trouble").previous({ skip_groups = true, jump = true })
						else
							vim.cmd.cprev()
						end
					end,
					desc = "Previous trouble/quickfix item",
				},
				{
					"]q",
					function()
						if require("trouble").is_open() then
							require("trouble").next({ skip_groups = true, jump = true })
						else
							vim.cmd.cnext()
						end
					end,
					desc = "Next trouble/quickfix item",
				},
			}
			return vim.list_extend(mappings, keys)
		end
	},

	-- todo comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		-- stylua: ignore
		dependencies = {
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						folke = "l3b"
					}
				}
			}
		},
		keys = function(_, keys)
			local hr = require("homerows").lazy_hr()
			local mappings = {
				{
					"]t",
					function() require("todo-comments").jump_next() end,
					desc = "Next todo comment"
				},
				{
					"[t",
					function() require("todo-comments").jump_prev() end,
					desc = "Previous todo comment"
				},
				{
					"<leader>" .. hr.folke .. hr.r3,
					"<cmd>TodoTrouble<cr>",
					desc =
					"Todo (Trouble)"
				},
				{
					"<leader>" .. hr.folke .. hr.R3,
					"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
					desc = "Todo/Fix/Fixme (Trouble)"
				},
				{ "<leader>" .. hr.folke .. hr.r4, "<cmd>TodoTelescope<cr>", desc = "Todo" },
				{
					"<leader>" .. hr.folke .. hr.R4,
					"<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
					desc = "Todo/Fix/Fixme"
				},
			}
			return vim.list_extend(mappings, keys)
		end
	},
}
