local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-p>", ":Telescope<CR>")

nnoremap("<leader>tf", function ()
  require("telescope.builtin").find_files()
end)

nnoremap("<leader>tk", function ()
  require("telescope.builtin").keymaps()
end)

