local hr = require("homerows.homerows")
local pth = require("plenary.path")
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap

nnoremap(vim.g.mapleader .. hr.l4t .. hr.l4t, function()
  -- get current file name which should be the module you wish to add the comp to
  local module = vim.api.nvim_buf_get_name(0)
  -- -- is standalone?
  -- local isStandaloneInput = vim.fn.input("standalone component? y/n > ")
  -- local isStandalone
  -- if isStandaloneInput == "y" then
  --   isStandalone = true
  -- else
  --   isStandalone = false
  -- end
  -- -- is in current module or top level?
  -- local isInCurrentModuleInput = vim.fn.input("put in current module? (else app module) y/n > ")
  -- local isInCurrentModule
  -- if isInCurrentModuleInput == "y" then
  --   isInCurrentModule = true
  -- else
  --   isInCurrentModule = false
  -- end
  -- get the path of the module without the module in it
  local module_path = vim.fn.fnamemodify(module, ':p:.:h'):gsub('src/app/', ''):gsub('src\\app\\', '')
  -- get the module file name
  module = vim.fn.fnamemodify(module, ':p:.'):gsub('src/app/', ''):gsub('src\\app\\', '')
  -- create a table with possible options for new components
  local comp_tbl = {
    ['p'] = "pipes",
    ['s'] = "services",
    ['c'] = "components",
  }
  -- get the type of component you want - either component, service or pipe
  local type = vim.fn.input("file type (c, s, p) > ")
  -- get the name of the file
  local name = vim.fn.input("file name > ")
  -- check if you want it put in the logical folder based on the component type
  local path
  local auto_sort = vim.fn.input("automatically file component in logical folder? (else custom) y/n > ")
  if auto_sort ~= 'y' and auto_sort ~= 'n' then return print('incorrect input') end
  -- if yes then assign path, else ask for the custom path
  if auto_sort == 'y' then
    path = comp_tbl[type]
  else
    path = vim.fn.input("file path from " .. module_path .. "/ not including name > ")
  end
  -- create the path for the new component to go to
  local new_comp_path = pth:new(string.format('%s/%s/%s/%s', module_path, path, name, name)).filename
  -- print the command
  print(string.format(':!ng g %s %s -m %s', type, new_comp_path, module))
  -- run the command
  -- vim.cmd(string.format(':!ng g %s %s -m %s', type, new_comp_path, module))
end, { desc = "jsbeautifyrc formatting" })

