local hr = require("homerows.homerows")
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
-- local nmap = Remap.nmap

-- prime
inoremap("<C-c>", "<Esc>")

nnoremap("<leader><leader>h", function()
  print("Hello World!")
end, { desc = "prints hello world" })

-- format
nnoremap("<leader>" .. hr.l1t .. hr.r1, function()
  vim.lsp.buf.format({ async = true })
end)

-- easy find and replace that asks if you want to replace each found word
nnoremap("<leader>" .. hr.l1t .. hr.r2,
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end
)
-- find and replace that doesn't ask, it just replaces all found words
nnoremap("<leader>" .. hr.l1t .. hr.r2,
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end
)

-- replace word yous cursor is on and asks if you want to change each word
--[[ nnoremap("<leader>r",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end
) ]]

-- replace the word you cursor is on but doesn't ask to change one by one,
-- it just replaces all found words
--[[ nnoremap("<leader>R",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end
) ]]

-- source this file
nnoremap("<leader><leader>s", "<cmd>source %<CR>")

-- move lines up or down when highlighted in v-line mode
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- indenting
vnoremap(">", ">> gv")
vnoremap("<", "<< gv")

-- have your next appear in the center of the screen
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

nnoremap("<leader>" .. hr.r1, "\"+y")
vnoremap("<leader>" .. hr.r1, "\"+y")
-- paste without loosing yank
xnoremap("<leader>" .. hr.r2, "\"_dP")
-- delete without loosing yank
xnoremap("<leader>" .. hr.r3, "\"_d")
