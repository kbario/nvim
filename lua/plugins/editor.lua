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
		opts = function(_, opts)
			local hr = require("homerows").lazy_hr()
			local keymaps = {
				insert = false,
				insert_line = false,
				normal = "<leader>" .. hr.r1b,
				normal_cur = "<leader>" .. hr.r1b .. hr.r1b,
				normal_line = "<leader>" .. hr.R1b,
				normal_cur_line = "<leader>" .. hr.R1b .. hr.R1b,
				visual = "<leader>" .. hr.r2b,
				visual_line = "<leader>" .. hr.R2b,
				change = "<leader>" .. hr.r3b,
				delete = "<leader>" .. hr.r4b,
			}
			return vim.list_extend(keymaps, opts)
		end,
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
	-- {
	--   "ggandor/flit.nvim",
	--   keys = function()
	--     ---@type LazyKeys[]
	--     local ret = {}
	--     for _, key in ipairs({ "f", "F", "t", "T" }) do
	--       ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
	--     end
	--     return ret
	--   end,
	--   opts = { labeled_modes = "nx" },
	-- },
	-- {
	--   "ggandor/leap.nvim",
	--   keys = {
	--     { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
	--     { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
	--     { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	--   },
	--   config = function(_, opts)
	--     local leap = require("leap")
	--     for k, v in pairs(opts) do
	--       leap.opts[k] = v
	--     end
	--     leap.add_default_mappings(true)
	--     vim.keymap.del({ "x", "o" }, "x")
	--     vim.keymap.del({ "x", "o" }, "X")
	--   end,
	-- },
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
		dependencies = { "kevinhwang91/promise-async" },
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
		keys = {
			{ 'zR', function() require('ufo').openAllFolds() end,         desc = "󱃅 ufo" },
			{ 'zM', function() require('ufo').closeAllFolds() end,        desc = "󱃅 ufo" },
			{ 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = "󱃅 ufo" },
			{ 'zm', function() require('ufo').closeFoldsWith() end,       desc = "󱃅 ufo" }, -- closeAllFolds == closeFoldsWith(0)
			{
				'K',
				function()
					local winid = require('ufo').peekFoldedLinesUnderCursor()
					if not winid then
						-- choose one of coc.nvim and nvim lsp
						vim.fn.CocActionAsync('definitionHover') -- coc.nvim
						vim.lsp.buf.hover()
					end
				end,
				desc = "󱃅  ufo"
			}
		}
	},
	{
		'Wansmer/treesj',
		-- keys = {
		-- 	{},
		-- },
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
