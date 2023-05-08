local hr = require("homerows").hr()
local pth = require("plenary.path")

---map to a keymap
---@param mode string
---@param lhs string
---@param rhs string | function
---@param opts? table
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {})
end

map("n", "<leader><leader>h", function()
  print("Hello World!")
end, { desc = "󰀄 Me: Prints hello world" })

-- format
map("n", "<leader>" .. hr.me .. hr.r1, function()
  vim.lsp.buf.format({ async = true })
end, { desc = "󰀄 Me: Format document" })

map("n", "<leader>" .. hr.me .. hr.R1, function()
  vim.cmd(":w")
  local cdub = vim.loop.cwd()
  local jsbeautifyrc = pth:new(string.format("%s/.jsbeautifyrc.json", cdub))

  local file = pth:new(vim.api.nvim_buf_get_name(0)):make_relative(cdub)
  local filetype = vim.fn.fnamemodify(file, ":e")

  if jsbeautifyrc:exists() and filetype == "html" then
    vim.cmd(string.format(":!js-beautify --config %s --replace %s", jsbeautifyrc.filename, file))
    print("beautified")
  end
end, { desc = "󰀄 Me: Jsbeautifyrc formatting" })

-- easy find and replace that asks if you want to replace each found word
-- nnoremap("<leader>" .. hr.l1t .. hr.r2,
--   function()
--     local fnd = vim.fn.input "find: "
--     local fnd = vim.api.nvim_exec('echo expand("<cword>")', true)
--     local rpl = vim.fn.input "replace: "
--     vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc") -- remove c to replace all
--   end,
--   { desc = "find and replace with individual confirm" }
-- )

-- source this file
map("n", "<leader><leader>s", "<cmd>source %<CR><cmd>echo 'sourced'<CR>",
  { desc = "󰀄 Me: Source the current file" })

map("n", "<C-h>", "<C-w>h", { desc = "󰀄 Me: Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "󰀄 Me: Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "󰀄 Me: Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "󰀄 Me: Move to right split" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "󰀄 Me: Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "󰀄 Me: Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "󰀄 Me: Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "󰀄 Me: Resize split right" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "󰀄 Me: Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "󰀄 Me: Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "󰀄 Me: Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "󰀄 Me: Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "󰀄 Me: Move line down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "󰀄 Me: Move line up" })

-- indenting
map("v", "<", "<gv", { desc = "󰀄 Me: Indent left" })
map("v", ">", ">gv", { desc = "󰀄 Me: Indent right" })

-- have your next appear in the center of the screen
vim.keymap.set("n", "n", "nzzzv", { desc = "󰀄 Me: Next forward vertically center aligned" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "󰀄 Me: Next backward vertically center aligned" })

-- yank to clipboard
vim.keymap.set("v", "<leader>" .. hr.me .. hr.r2, "\"+y", { desc = "󰀄 Me: Copy to clipbaord" })
vim.keymap.set("v", "<leader>" .. hr.me .. hr.R2, "\"+Y", { desc = "󰀄 Me: Copy to clipbaord" })
-- paste without loosing yank
vim.keymap.set("x", "<leader>" .. hr.me .. hr.r3, "\"_dP", { desc = "󰀄 Me: Paste without loosing yank" })
-- delete without loosing yank
vim.keymap.set("x", "<leader>" .. hr.me .. hr.r4, "\"_d", { desc = "󰀄 Me: Delete without loosing yank" })
