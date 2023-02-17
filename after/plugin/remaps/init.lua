local hr = require("homerows.homerows")
local pth = require("plenary.path")
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

nnoremap("<leader><leader>h", function()
  print("Hello World!")
end, { desc = "prints hello world" })

-- format
nnoremap("<leader>" .. hr.l1t .. hr.r1, function()
  vim.lsp.buf.format({ async = true })
end, { desc = "lsp: format document" })

nnoremap("<leader>" .. hr.l1t .. hr.R1, function()
  vim.lsp.buf.format()
  vim.cmd(":w")
  local cdub = vim.loop.cwd()
  local jsbeautifyrc = pth:new(string.format("%s/.jsbeautifyrc.json", cdub))

  local file = pth:new(vim.api.nvim_buf_get_name(0)):make_relative(cdub)
  local filetype = vim.fn.fnamemodify(file, ":e")

  if jsbeautifyrc:exists() and filetype == "html" then
    vim.cmd(string.format(":!js-beautify --config %s --replace %s", jsbeautifyrc.filename, file))
    print("beautified")
  end
end, { desc = "jsbeautifyrc formatting" })

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
nnoremap("<leader><leader>s", "<cmd>source %<CR><cmd>echo 'sourced'<CR>", { desc = "source the current file" })

-- move lines up or down when highlighted in v-line mode
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "move highlighted up" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "move highlighted down" })

-- indenting
vnoremap(">", ">> gv", { desc = "indent right" })
vnoremap("<", "<< gv", { desc = "indent left" })

-- have your next appear in the center of the screen
nnoremap("n", "nzzzv", { desc = "next forward vertically center aligned" })
nnoremap("N", "Nzzzv", { desc = "next backward vertically center aligned" })

-- yank to clipboard
vnoremap("<leader>" .. hr.r1, "\"+y", { desc = "copy to clipbaord" })
vnoremap("<leader>" .. hr.R1, "\"+Y", { desc = "copy to clipbaord" })
-- paste without loosing yank
xnoremap("<leader>" .. hr.r2, "\"_dP", { desc = "paste without loosing yank" })
-- delete without loosing yank
xnoremap("<leader>" .. hr.r3, "\"_d", { desc = "delete without loosing yank" })
