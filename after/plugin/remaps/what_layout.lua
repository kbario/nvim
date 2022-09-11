local M = {}
local nnoremap = require("kbario.keymap").nnoremap

nnoremap("<leader>lw", function()
  print(vim.env.keyboard_layout)
end)

nnoremap("<leader>lc", function()
  -- TODO impl resourcing nvim
  -- TODO writing the new layout in the set file
  local layout = vim.fn.input("what keybr layout you use?: ")
  vim.env.keyboard_layout = layout
  print("new keybr layout = "..vim.env.keyboard_layout)
end)

local default_layout = 'qwerty'

local layouts = {
  qwerty = {
    first_left = "f",
    second_left = "d",
    third_left = "s",
    fourth_left = "a",
    first_right = "j",
    second_right = "k",
    third_right = "l",
    fourth_right = ";",
    first_left_cap = "F",
    second_left_cap = "D",
    third_left_cap = "S",
    fourth_left_cap = "A",
    first_right_cap = "J",
    second_right_cap = "K",
    third_right_cap = "L",
    fourth_right_cap = ":",
  },
  colemak = {
    first_left = "t",
    second_left = "s",
    third_left = "r",
    fourth_left = "a",
    first_right = "n",
    second_right = "e",
    third_right = "i",
    fourth_right = "o",
    first_left_cap = "T",
    second_left_cap = "S",
    third_left_cap = "R",
    fourth_left_cap = "A",
    first_right_cap = "N",
    second_right_cap = "E",
    third_right_cap = "I",
    fourth_right_cap = "O",
  }
}

M.first_left = layouts[vim.env.keyboard_layout].first_left or layouts[default_layout].first_left
M.second_left = layouts[vim.env.keyboard_layout].second_left or layouts[default_layout].second_left
M.third_left = layouts[vim.env.keyboard_layout].third_left or layouts[default_layout].third_left
M.fourth_left = layouts[vim.env.keyboard_layout].fourth_left or layouts[default_layout].fourth_left
M.first_right = layouts[vim.env.keyboard_layout].first_right or layouts[default_layout].first_right
M.second_right = layouts[vim.env.keyboard_layout].second_right or layouts[default_layout].second_right
M.third_right = layouts[vim.env.keyboard_layout].third_right or layouts[default_layout].third_right
M.fourth_right = layouts[vim.env.keyboard_layout].fourth_right or layouts[default_layout].fourth_right
M.first_left_cap = layouts[vim.env.keyboard_layout].first_left_cap or layouts[default_layout].first_left_cap
M.second_left_cap = layouts[vim.env.keyboard_layout].second_left_cap or layouts[default_layout].second_left_cap
M.third_left_cap = layouts[vim.env.keyboard_layout].third_left_cap or layouts[default_layout].third_left_cap
M.fourth_left_cap = layouts[vim.env.keyboard_layout].fourth_left_cap or layouts[default_layout].fourth_left_cap
M.first_right_cap = layouts[vim.env.keyboard_layout].first_right_cap or layouts[default_layout].first_right_cap
M.second_right_cap = layouts[vim.env.keyboard_layout].second_right_cap or layouts[default_layout].second_right_cap
M.third_right_cap = layouts[vim.env.keyboard_layout].third_right_cap or layouts[default_layout].third_right_cap
M.fourth_right_cap = layouts[vim.env.keyboard_layout].fourth_right_cap or layouts[default_layout].fourth_right_cap

return M

