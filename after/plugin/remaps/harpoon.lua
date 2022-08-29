local nnoremap = require("kbario.keymap").nnoremap

local silent = { silent = true }

-- add mark
nnoremap("<leader>ha", function ()
  require("harpoon.mark").add_file()
end, silent)

-- open the ui menu to see the marks i have
nnoremap("<leader>hu", function ()
  require("harpoon.ui").toggle_quick_menu()
end, silent)

-- navigate to the marks
nnoremap("<leader>hn", function ()
  require("harpoon.ui").nav_file(1)
end, silent)
nnoremap("<leader>he", function ()
  require("harpoon.ui").nav_file(2)
end, silent)
nnoremap("<leader>hi", function ()
  require("harpoon.ui").nav_file(3)
end, silent)
nnoremap("<leader>ho", function ()
  require("harpoon.ui").nav_file(4)
end, silent)
