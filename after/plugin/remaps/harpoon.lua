local nnoremap = require("kbario.keymap").nnoremap
local hr = require("homerows.homerows")

local function gen_opts(desc)
  return { desc = desc, silent = true }
end

require("harpoon").setup({
  mark_branch = true
})

-- open the ui menu to see the marks i have
nnoremap("<leader>"..hr.l2..hr.r1t, function ()
  require("harpoon.ui").toggle_quick_menu()
end, gen_opts("harpoon: toggle quick menu"))
-- add mark
nnoremap("<leader>"..hr.l2..hr.r2t, function ()
  require("harpoon.mark").add_file()
end, gen_opts("harpoon: add a file"))
-- navigate to the marks
nnoremap("<leader>"..hr.l2..hr.r1, function ()
  require("harpoon.ui").nav_file(1)
end, gen_opts("harpoon: nav to file 1"))
nnoremap("<leader>"..hr.l2..hr.r2, function ()
  require("harpoon.ui").nav_file(2)
end, gen_opts("harpoon: nav to file 2"))
nnoremap("<leader>"..hr.l2..hr.r3, function ()
  require("harpoon.ui").nav_file(3)
end, gen_opts("harpoon: nav to file 3"))
nnoremap("<leader>"..hr.l2..hr.r4, function ()
  require("harpoon.ui").nav_file(4)
end, gen_opts("harpoon: nav to file 4"))
