local ensure_treesitter = require("config.clients")
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		lazy = false,
		dependencies = {
			-- defaults for treesitter autotagging
			"windwp/nvim-ts-autotag",
			-- extends commenting; use in conjunction with comment.nvim
			"JoosepAlviste/nvim-ts-context-commentstring",
			-- shows the context/code block/function/paragraph the cursor is currently in
			'nvim-treesitter/nvim-treesitter-context',
			-- not sure, might delete later
			"nvim-treesitter/nvim-treesitter-refactor",
			-- not sure; from LazyVim
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- PERF: no need to load the plugin, if we only need its queries for mini.ai
					local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
					local opts = require("lazy.core.plugin").values(plugin, "opts", false)
					local enabled = false
					if opts.textobjects then
						for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
							if opts.textobjects[mod] and opts.textobjects[mod].enable then
								enabled = true
								break
							end
						end
					end
					if not enabled then
						require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
					end
				end,
			},
		},
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- needed for windwp/nvim-ts-autotag to work
			autotag = { enable = true },
			-- needed for JoosepAlviste/nvim-ts-context-commentstring to work
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = ensure_treesitter,
			highlight = {
				enable = true,
				disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
				use_languagetree = true,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			-- for refactor; delete if delete refactor
			refactor = {
				highlight_definitions = {
					enable = true,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				highlight_current_scope = { enable = true },
				smart_rename = {
					enable = true,
					-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
					keymaps = {
						smart_rename = "grr",
					},
				},
			}
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/playground",
		dependencies = { "nvim-treesitter" },
		cmd = { "TSPlaygroundToggle" },
		opts = {
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = 'o',
					toggle_hl_groups = 'i',
					toggle_injected_languages = 't',
					toggle_anonymous_nodes = 'a',
					toggle_language_display = 'I',
					focus_language = 'f',
					unfocus_language = 'F',
					update = 'R',
					goto_node = '<cr>',
					show_help = '?',
				},
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
	}
}

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	cmd = {
-- 		"TSBufDisable",
-- 		"TSBufEnable",
-- 		"TSBufToggle",
-- 		"TSDisable",
-- 		"TSEnable",
-- 		"TSToggle",
-- 		"TSInstall",
-- 		"TSInstallInfo",
-- 		"TSInstallSync",
-- 		"TSModuleInfo",
-- 		"TSUninstall",
-- 		"TSUpdate",
-- 		"TSUpdateSync",
-- 	},
-- }

-- return {
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		version = false, -- last release is way too old and doesn't work on Windows
-- 		keys = {
-- 			{ "<c-space>", desc = "Increment selection" },
-- 			{ "<bs>",      desc = "Decrement selection", mode = "x" },
-- 		},
-- 		---@type TSConfig
-- 		opts = {
-- 			ensure_installed = {
-- 			},
-- 		},
-- 	},
-- }
