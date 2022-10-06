local nnoremap = require("kbario.keymap").nnoremap
local homerows = require("kbario.what_layout")

local silent = { silent = true }

require("harpoon").setup({
  mark_branch = true
})

-- add mark
nnoremap("<leader>ha", function ()
  require("harpoon.mark").add_file()
end, silent)

-- open the ui menu to see the marks i have
nnoremap("<leader>hu", function ()
  require("harpoon.ui").toggle_quick_menu()
end, silent)

-- navigate to the marks
nnoremap("<leader>h"..homerows.first_right, function ()
  require("harpoon.ui").nav_file(1)
end, silent)
nnoremap("<leader>h"..homerows.second_right, function ()
  require("harpoon.ui").nav_file(2)
end, silent)
nnoremap("<leader>h"..homerows.third_right, function ()
  require("harpoon.ui").nav_file(3)
end, silent)
nnoremap("<leader>h"..homerows.fourth_right, function ()
  require("harpoon.ui").nav_file(4)
end, silent)
