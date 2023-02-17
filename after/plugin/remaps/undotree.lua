local hr = require("homerows.homerows")
local nnoremap = require("kbario.keymap").nnoremap

nnoremap(vim.g.mapleader .. hr.l4 .. hr.r4, ":UndotreeToggle<CR>", { desc = "undotree: toggle" })
