local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap

local hr = require("homerows.homerows")

nnoremap("<C-p>", ":Telescope<CR>")

nnoremap("<leader>" .. hr.l1 .. hr.r0, function()
  require("telescope.builtin").resume()
end, { desc = "telescope: resume previous" })
nnoremap("<leader>" .. hr.l1 .. hr.R0, function()
  require("telescope.builtin").command_history()
end, { desc = "telescope: command history" })

nnoremap("<leader>" .. hr.l1 .. hr.r1, function()
  require("telescope.builtin").find_files()
end, { desc = "telescope: find files" })

nnoremap("<leader>" .. hr.l1 .. hr.r2, function()
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
end, { desc = "telescope: grep that ask for input" })
nnoremap("<leader>" .. hr.l1 .. hr.R2, function()
  require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "telescope: grep string you are on" })

nnoremap("<leader>" .. hr.l1 .. hr.r3, function()
  require('telescope.builtin').live_grep()
end, { desc = "telescope: live grep" })
nnoremap("<leader>" .. hr.l1 .. hr.R3, function()
  require('telescope.builtin').live_grep({ glob_pattern = vim.fn.input("glob_pattern > ") })
end, { desc = "telescope: live grep" })

nnoremap("<leader>" .. hr.l1 .. hr.r4, function()
  require("telescope.builtin").git_status()
end, { desc = "telescope: keymaps" })

nnoremap("<leader>" .. hr.l1 .. hr.r4b, function()
  require("telescope.builtin").keymaps()
end, { desc = "telescope: keymaps" })

-- vstask maps

nnoremap("<leader>" .. hr.l0b .. hr.r1, function()
  require("telescope").extensions.vstask.tasks()
end, { desc = "vstask: tasks" })
nnoremap("<leader>" .. hr.l0b .. hr.r2, function()
  require("telescope").extensions.vstask.inputs()
end, { desc = "vstask: inputs" })
nnoremap("<leader>" .. hr.l0b .. hr.r3, function()
  require("telescope").extensions.vstask.history()
end, { desc = "vstask: history" })
nnoremap("<leader>" .. hr.l0b .. hr.r4, function()
  require("telescope").extensions.vstask.launch()
end, { desc = "vstask: launch" })

