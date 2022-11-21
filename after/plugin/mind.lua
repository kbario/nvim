local remap = require("kbario.keymap")
local nnoremap = remap.nnoremap

local hr = require("homerows.homerows")
local mind = require("mind")

mind.setup()

nnoremap("<leader>"..hr.r0..hr.r1, function ()
  mind.open_main()
end, { desc = "open main mind" })

nnoremap("<leader>"..hr.r0..hr.r4, function ()
  mind.close()
end, { desc = "close mind" })
