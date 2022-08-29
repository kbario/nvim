local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- prime
inoremap("<C-c>", "<Esc>")

-- easy find and replace that asks if you want to replace each found word
nnoremap("<leader>fr",
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end
)
-- find and replace that doesn't ask, it just replaces all found words
nnoremap("<leader>fR",
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end
)

-- replace word yous cursor is on and asks if you want to change each word
nnoremap("<leader>r",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end
)
-- replace the word you cursor is on but doesn't ask to change one by one, 
-- it just replaces all found words
nnoremap("<leader>R",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end
)

-- format
nnoremap("<leader>fm", function()
  vim.lsp.buf.formatting()
end)

-- source this file
nnoremap("<leader><leader>s", "<cmd>source %<CR>")

-- move lines up or down when highlighted in v-line mode
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
