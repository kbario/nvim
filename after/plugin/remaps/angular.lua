local hr = require("homerows.homerows")
local pth = require("plenary.path")
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap

nnoremap(vim.g.mapleader .. hr.l4t .. hr.l4t, function()
  local module = vim.api.nvim_buf_get_name(0)
  -- local module_name = vim.fn.fnamemodify(module, ':p:.:t')
  local module_path = vim.fn.fnamemodify(module, ':p:.:h'):gsub('src/app/', ''):gsub('src\\app\\', '')
  module = vim.fn.fnamemodify(module, ':p:.'):gsub('src/app/', ''):gsub('src\\app\\', '')

  local type = vim.fn.input("file type (c, s, p)> ")
  local name = vim.fn.input("file name > ")

  local path = vim.fn.input("file path from " .. module_path .. "/ not including name > ")
  path = pth:new(string.format('%s/%s/%s/%s', module_path, path, name, name)).filename
  print(string.format(':!ng g %s %s -m %s', type, path, module))
  vim.cmd(string.format(':!ng g %s %s -m %s', type, path, module))

  -- local cdub = vim.loop.cwd()
  -- local jsbeautifyrc = pth:new(string.format("%s/.jsbeautifyrc.json", cdub))
  --
  -- local file = pth:new(vim.api.nvim_buf_get_name(0)):make_relative(cdub)
  -- local filetype = vim.fn.fnamemodify(file, ":e")
  --
  -- if jsbeautifyrc:exists() and filetype == "html" then
  --   vim.cmd(string.format(":!js-beautify --config %s --replace %s", jsbeautifyrc.filename, file))
  --   print("beautified")
  -- end
end, { desc = "jsbeautifyrc formatting" })
