local tnoremap = require("kbario.keymap").tnoremap
local nnoremap = require("kbario.keymap").nnoremap
local hr = require('homerows.homerows')
tnoremap('<Esc>', '<C-\\><C-n>')
nnoremap('<leader><leader>'..hr.l1, function() vim.cmd(":vsplit term://powershell") end)
