local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ('  %d '):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, 'MoreMsg' })
	return newVirtText
end

local p_selector = function(_, filetype, buftype)
	local function handleFallbackException(bufnr, err, providerName)
		if type(err) == "string" and err:match("UfoFallbackException") then
			return require("ufo").getFolds(bufnr, providerName)
		else
			return require("promise").reject(err)
		end
	end

	return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
		or function(bufnr)
			return require("ufo")
				.getFolds(bufnr, "lsp")
				:catch(function(err)
					return handleFallbackException(bufnr, err, "treesitter")
				end)
				:catch(function(err)
					return handleFallbackException(bufnr, err, "indent")
				end)
		end
end





return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		dependencies = {
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						surround_n = "r1b",
						surround_nl = "R1b",
						surround_v = "r2b",
						surround_vl = "R2b",
						surround_c = "r3b",
						surround_d = "r4b",
					}
				}
			}
		},
		keys = function()
			local hr = require("homerows").lazy_hr()
			return {
				{
					"<leader>" .. hr.surround_n,
					"<Plug>(nvim-surround-normal)",
					desc = "󰅴 Surround (n)"
				},
				{
					"<leader>" .. hr.surround_n .. hr.surround_n,
					"<Plug>(nvim-surround-normal-cur)",
					desc = "󰅴 Surround: line (n)"
				},
				{
					"<leader>" .. hr.surround_nl,
					"<Plug>(nvim-surround-normal-line)",
					desc = "󰅴 Surround: on new line (n)"
				},
				{
					"<leader>" .. hr.surround_nl .. hr.surround_nl,
					"<Plug>(nvim-surround-normal-cur-line)",
					desc = "󰅴 Surround: line on new line (n)",
				},
				{
					"<leader>" .. hr.surround_v,
					"<Plug>(nvim-surround-visual)",
					desc = "󰅴 Surround (v)",
					mode = "x"
				},
				{
					"<leader>" .. hr.surround_vl,
					"<Plug>(nvim-surround-visual-line)",
					desc = "󰅴 Surround: line (v)",
					mode = "x"
				},
				{
					"<leader>" .. hr.surround_c,
					"<Plug>(nvim-surround-change)",
					desc = "󰅴 Surround: Change surrounding",
				},
				{
					"<leader>" .. hr.surround_d,
					"<Plug>(nvim-surround-delete)",
					desc = "󰅴 Surround: Delete surrounding"
				},
			}
		end,
		opts = {
			keymaps = {
				insert = false,
				insert_line = false,
				normal = false,
				normal_cur = false,
				normal_line = false,
				normal_cur_line = false,
				visual = false,
				visual_line = false,
				change = false,
				delete = false,
			},
		}
	},
	{
		"numToStr/Comment.nvim",
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		opts = function()
			local commentstring_avail, commentstring = pcall(require,
				"ts_context_commentstring.integrations.comment_nvim")
			return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
		end,
	},
	-- shows you a tree of your code like treesitter playground but frienlier ui
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		dependencies = {
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						symbol_outline = "r4"
					}
				}
			}
		},
		keys = function()
			local hr = require("homerows").lazy_hr()
			return { { "<leader>" .. hr.symbol_outline, "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } }
		end,
		config = true,
	},
	{
		"ggandor/flit.nvim",
		keys = function()
			---@type LazyKeys[]
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = "󱕘 Flit:" .. key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						leap_to = "r1",
						leap_til = "r2",
						leap_back_to = "R1",
						leap_back_til = "R2",
						leap_win = "r3",
					}
				}
			}
		},
		keys = function()
			local hr = require("homerows").lazy_hr()
			return {
				{
					"<leader>" .. hr.leap_to,
					"*<Plug>(leap-forward-to)*",
					mode = { "n", "x", "o" },
					desc = "󱕘 Leap: To"
				},
				{
					"<leader>" .. hr.leap_til,
					"*<Plug>(leap-forward-till)*",
					mode = { "x", "o" },
					desc = "󱕘 Leap: Til"
				},
				{
					"<leader>" .. hr.leap_back_to,
					"*<Plug>(leap-backward-to)*",
					mode = { "n", "x", "o" },
					desc = "󱕘 Leap: Back to"
				},
				{
					"<leader>" .. hr.leap_back_til,
					"*<Plug>(leap-backward-till)*",
					mode = { "x", "o" },
					desc = "󱕘 Leap: Back til"
				},
				{
					"<leader>" .. hr.leap_win,
					"*<Plug>(leap-from-window)*",
					mode = { "n", "x", "o" },
					desc = "󱕘 Leap: Window"
				} }
		end,
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	-- -- buffer remove
	-- {
	--   "echasnovski/mini.bufremove",
	--   -- stylua: ignore
	--   keys = {
	--     { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
	--     { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
	--   },
	-- },
	--
	-- better folding
	{
		"kevinhwang91/nvim-ufo",
		event = { "InsertEnter" },
		dependencies = { "kevinhwang91/promise-async",
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						ufo = "r2t"
					}
				}
			}
		},
		opts = {
			preview = {
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
				},
			},
			-- global handler
			-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
			-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
			fold_virt_text_handler = handler,
			provider_selector = p_selector,
		},
		keys = function()
			local hr = require("homerows.init").lazy_hr()
			return {
				{ "<leader>" .. hr.ufo .. hr.r1, function() require('ufo').openAllFolds() end,         desc =
				"󱃅 Ufo: Open all" },
				{ "<leader>" .. hr.ufo .. hr.r2, function() require('ufo').closeAllFolds() end,        desc =
				"󱃅 Ufo: Close all" },
				{ "<leader>" .. hr.ufo .. hr.r3, function() require('ufo').openFoldsExceptKinds() end,
					                                                                                       desc =
					"󱃅 Ufo: Open excepts kinds" },
				{ "<leader>" .. hr.ufo .. hr.r4, function() require('ufo').closeFoldsWith() end,
					                                                                                       desc =
					"󱃅 Ufo: Close all with" },                                                                           -- closeAllFolds == closeFoldsWith(0)
				{
					"<leader>" .. hr.ufo .. hr.r1t,
					function()
						local winid = require('ufo').peekFoldedLinesUnderCursor()
						if not winid then
							vim.lsp.buf.hover()
						end
					end,
					desc = "󱃅 Ufo: Hover"
				}
			}
		end,
	},
	{
		'Wansmer/treesj',
		dependencies = { 'nvim-treesitter/nvim-treesitter',
			{
				"kbario/homerows.nvim",
				opts = {
					custom_keys = {
						sj = "r3t"
					}
				}
			}
		},
		keys = function()
			local hr = require("homerows.init").lazy_hr()
			return {
				{
					"<leader>" .. hr.sj .. hr.l1
				}
			}
		end,
		opts = {
			use_default_keymaps = false,
			langs = {
				"Javascript",
				"Typescript",
				"Tsx",
				"Jsx",
				"Lua",
				"CSS",
				"SCSS",
				"HTML",
				"Svelte",
				"JSON",
				"Yaml",
				"Python",
				"Rust",
				"R",
				"C/C++",
				"Kotlin",
			},
		}
	}
}
