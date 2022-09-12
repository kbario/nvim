local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", ":Telescope<CR>")

nnoremap("<leader>tf", function ()
  require("telescope.builtin").find_files()
end)

nnoremap("<leader>tk", function ()
  require("telescope.builtin").keymaps()
end)

nnoremap("<leader>tg", function()
    require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end)

nnoremap("<leader>tG", function()
    require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>")})
end)

nnoremap("<leader>tlg", function()
    require('telescope.builtin').live_grep()
end)
