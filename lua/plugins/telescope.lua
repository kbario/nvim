local utils = require("utils")
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
		{
			"kbario/homerows.nvim",
			opts = {
				custom_keys = {
					telescope = "l1"
				}
			}
		},
	},
	keys = function(_, keys)
		local hr = require("homerows").lazy_hr()
		local mappings = {
			-- find
			{ "<leader>" .. hr.telescope .. hr.r0,  "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
			{
				"<leader>" .. hr.telescope .. hr.r1,
				function() require("telescope.builtin").files({ cwd = utils.get_root() }) end,
				desc = " Find Files (root dir)"
			},
			{
				"<leader>" .. hr.telescope .. hr.r2,
				function()
					require("telescope.builtin").grep_string({
						cwd = utils.get_root(),
						search = vim.fn.input("Grep For > ")
					})
				end,
				desc = " Grep prompt"
			},
			{
				"<leader>" .. hr.telescope .. hr.R2,
				function()
					require("telescope.builtin").grep_string({
						cwd = utils.get_root(),
						search = vim.fn.input("<cword>")
					})
				end,
				desc = " Grep under cursor"
			},
			{
				"<leader>" .. hr.telescope .. hr.r3,
				function() require("telescope.builtin").live_grep({ cwd = utils.get_root() }) end,
				desc = " Live grep"
			},
			{
				"<leader>" .. hr.telescope .. hr.R3,
				function()
					require('telescope.builtin').live_grep({
						cwd = utils.get_root(),
						glob_pattern = vim.fn.input("glob_pattern > ")
					})
				end,
				desc = " Live grep with prompted pattern"
			},
			{
				"<leader>" .. hr.telescope .. hr.r1b,
				"<cmd>Telescope command_history<cr>",
				desc = " Command History"
			},
			-- {
			-- 	"<leader>" .. hr.telescope .. ,
			-- 	"<cmd>Telescope help_tags<cr>",
			-- 	desc =
			-- 	"Help Pages"
			-- },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope oldfiles<cr>",                         desc = "Recent" },
			-- { "<leader>" .. hr.telescope .. "", function() require("telescope.builtin")["oldfiles"](, { cwd = vim.loop.cwd() }) desc = "Recent (cwd)" }, end,
			-- git
			{ "<leader>" .. hr.telescope .. hr.r2t, "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>" .. hr.telescope .. hr.r1t, "<cmd>Telescope git_status<CR>",  desc = "status" },
			-- search
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope autocommands<cr>",                     desc = "Auto Commands" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope commands<cr>",                         desc = "Commands" },
			-- {
			-- 	"<leader>" .. hr.telescope .. "",
			-- 	"<cmd>Telescope diagnostics bufnr=0<cr>",
			-- 	desc =
			-- 	"Document diagnostics"
			-- },
			-- {
			-- 	"<leader>" .. hr.telescope .. "",
			-- 	"<cmd>Telescope diagnostics<cr>",
			-- 	desc =
			-- 	"Workspace diagnostics"
			-- },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>" .. hr.telescope .. hr.r4,  "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope man_pages<cr>",                  desc = "Man Pages" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope marks<cr>",                      desc = "Jump to Mark" },
			-- { "<leader>" .. hr.telescope .. "", "<cmd>Telescope vim_options<cr>",                desc = "Options" },
			{ "<leader>" .. hr.telescope .. "",     "<cmd>Telescope resume<cr>",      desc = "Resume" },
			-- {
			-- 	"<leader>" .. hr.telescope .. "",
			-- 	function() require("telescope.builtin")["colorscheme"](, { enable_preview = true }) end,
			-- 	desc =
			-- 	"Colorscheme with preview"
			-- },
			-- {
			-- 	"<leader>" .. hr.telescope .. "",
			-- 	utils.telescope("lsp_document_symbols", {
			-- 		symbols = {
			-- 			"Class",
			-- 			"Function",
			-- 			"Method",
			-- 			"Constructor",
			-- 			"Interface",
			-- 			"Module",
			-- 			"Struct",
			-- 			"Trait",
			-- 			"Field",
			-- 			"Property",
			-- 		},
			-- 	}),
			-- 	desc = "Goto Symbol",
			-- },
			-- {
			-- 	"<leader>" .. hr.telescope .. "",
			-- 	utils.telescope("lsp_dynamic_workspace_symbols", {
			-- 		symbols = {
			-- 			"Class",
			-- 			"Function",
			-- 			"Method",
			-- 			"Constructor",
			-- 			"Interface",
			-- 			"Module",
			-- 			"Struct",
			-- 			"Trait",
			-- 			"Field",
			-- 			"Property",
			-- 		},
			-- 	}),
			-- 	desc = "Goto Symbol (Workspace)",
			-- },
		}
		return vim.list_extend(mappings, keys)
	end,
	version = false, -- telescope did only one release, so use HEAD for now
	cmd = "Telescope",
	opts = function()
		local actions = require "telescope.actions"
		local previewers = require("telescope.previewers")
		local sorters = require("telescope.sorters")

		return {
			defaults = {
				-- icons
				entry_prefix = "  ",
				prompt_prefix = "   ",
				selection_caret = " ",
				-- display
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8, -- try delete to see what happens
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				path_display = { "truncate" },
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				winblend = 0,

				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				file_ignore_patterns = { "node_modules" },

				file_previewer = previewers.vim_buffer_cat.new,
				grep_previewer = previewers.vim_buffer_vimgrep.new,
				qflist_previewer = previewers.vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = previewers.buffer_previewer_maker,

				file_sorter = sorters.get_fuzzy_file,
				generic_sorter = sorters.get_generic_fuzzy_sorter,

				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},


				mappings = {
					i = {
						["<Esc>"] = actions.close,
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<c-t>"] = function(...)
							return require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<a-t>"] = function(...)
							return require("trouble.providers.telescope").open_selected_with_trouble(...)
						end,
						-- ["<a-i>"] = function()
						-- 	utils.telescope("find_files", { no_ignore = true })()
						-- end,
						-- ["<a-h>"] = function()
						-- 	utils.telescope("find_files", { hidden = true })()
						-- end,
						["<C-f>"] = function(...)
							return require("telescope.actions").preview_scrolling_down(...)
						end,
						["<C-b>"] = function(...)
							return require("telescope.actions").preview_scrolling_up(...)
						end,
					},
					n = { ["q"] = actions.close },
				},
			},
			-- 		-- extensions_list = { "themes", "terms" },
		}
	end,
	config = function(_, opts)
		local telescope = require "telescope"
		telescope.setup(opts)

		-- for _, ext in ipairs(opts.extensions_list) do
		-- 	telescope.load_extension(ext)
		-- end
	end
}
