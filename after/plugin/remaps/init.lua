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
end, { desc = "lsp: format document"})

-- easy find and replace that asks if you want to replace each found word
nnoremap("<leader>" .. hr.l1t .. hr.r2,
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end,
  { desc = "find and replace with individual confirm" }
)
-- find and replace that doesn't ask, it just replaces all found words
nnoremap("<leader>" .. hr.l1t .. hr.r2,
  function()
    local fnd = vim.fn.input "find: "
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end,
  { desc = "find and replace all" }
)

-- replace word yous cursor is on and asks if you want to change each word
nnoremap("<leader>r",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/gc")
  end,
  { desc = "replace current under cursor with individual confirm" }
)

-- replace the word you cursor is on but doesn't ask to change one by one,
-- it just replaces all found words
nnoremap("<leader>R",
  function()
    local lines = vim.api.nvim_exec('echo expand("<cword>")', true)
    local fnd = lines
    local rpl = vim.fn.input "replace: "
    vim.cmd(":%s/" .. fnd .. "/" .. rpl .. "/g")
  end,
  { desc = "replace all current under cursor" }
)

-- source this file
nnoremap("<leader><leader>s", "<cmd>source %<CR>", { desc = "source the current file" })

-- move lines up or down when highlighted in v-line mode
vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "move highlighted up" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "move highlighted down" })

-- indenting
vnoremap(">", ">> gv", { desc = "indent right" })
vnoremap("<", "<< gv", { desc = "indent left" })

-- have your next appear in the center of the screen
nnoremap("n", "nzzzv", { desc = "next forward vertically center aligned" })
nnoremap("N", "Nzzzv", { desc = "next backward vertically center aligned" })

nnoremap("<leader>" .. hr.r1, "\"+y", { desc = "copy to clipbaord" })
nnoremap("<leader>" .. hr.R1, "\"+Y", { desc = "copy to clipbaord" })
vnoremap("<leader>" .. hr.r1, "\"+y", { desc = "copy to clipbaord" })
vnoremap("<leader>" .. hr.R1, "\"+Y", { desc = "copy to clipbaord" })
-- paste without loosing yank
xnoremap("<leader>" .. hr.r2, "\"_dP", { desc = "paste without loosing yank" })
-- delete without loosing yank
xnoremap("<leader>" .. hr.r3, "\"_d", { desc = "delete without loosing yank" })
