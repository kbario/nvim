--[[
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local spear = require("ng_spear.spr").spear
local spear_ts = require("ng_spear.spr").spear_ts
local spear_html = require("ng_spear.spr").spear_html
local spear_css = require("ng_spear.spr").spear_css
local spear_spec = require("ng_spear.spr").spear_spec
local hr = require("kbario.what_layout")


nnoremap("<leader>s"..hr.first_right, function ()
  spear_ts()
end)

nnoremap("<leader>s"..hr.second_right, function ()
  spear_html()
end)

nnoremap("<leader>s"..hr.third_right, function ()
  spear_css()
end)

nnoremap("<leader>s"..hr.fourth_right, function ()
  spear_spec()
end)

]]
