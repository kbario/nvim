local nnoremap = require("kbario.keymap").nnoremap
local hr = require("homerows.homerows")

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
nnoremap("<leader>h"..hr.r1, function ()
  require("harpoon.ui").nav_file(1)
end, silent)
nnoremap("<leader>h"..hr.r2, function ()
  require("harpoon.ui").nav_file(2)
end, silent)
nnoremap("<leader>h"..hr.r3, function ()
  require("harpoon.ui").nav_file(3)
end, silent)
nnoremap("<leader>h"..hr.r4, function ()
  require("harpoon.ui").nav_file(4)
end, silent)
