local hr = require("homerows").hr()
local pth = require("plenary.path")

---map to a keymap
---@param mode string
---@param lhs string
---@param rhs string | function
---@param opts? table
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or {})
end

map("n", "<leader><leader>h", function()
  print("Hello World!")
end, { desc = "󰀄 Me: Prints hello world" })

-- format
map("n", "<leader>" .. hr.r1t, function()
  vim.lsp.buf.format({ async = true })
end, { desc = "󰀄 Me: Format document" })

map("n", "<leader>" .. hr.R1t, function()
  vim.cmd(":w")
  local cdub = vim.loop.cwd()
  local jsbeautifyrc = pth:new(string.format("%s/.jsbeautifyrc.json", cdub))

  local file = pth:new(vim.api.nvim_buf_get_name(0)):make_relative(cdub)
  local filetype = vim.fn.fnamemodify(file, ":e")

  if jsbeautifyrc:exists() and filetype == "html" then
    vim.cmd(string.format(":!js-beautify --config %s --replace %s", jsbeautifyrc.filename, file))
    print("beautified")
  end
end, { desc = "󰀄 Me: Jsbeautifyrc formatting" })

-- source this file
map("n", "<leader><leader>s", "<cmd>source %<CR><cmd>echo 'sourced'<CR>",
  { desc = "󰀄 Me: Source the current file" })

map("n", "<C-h>", "<C-w>h", { desc = "󰀄 Me: Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "󰀄 Me: Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "󰀄 Me: Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "󰀄 Me: Move to right split" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "󰀄 Me: Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "󰀄 Me: Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "󰀄 Me: Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "󰀄 Me: Resize split right" })

-- Move Lines
map("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "󰀄 Me: Move line down" })
map("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "󰀄 Me: Move line up" })
map("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "󰀄 Me: Move line down" })
map("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "󰀄 Me: Move line up" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "󰀄 Me: Move line down" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "󰀄 Me: Move line up" })

-- indenting
map("v", "<", "<gv", { desc = "󰀄 Me: Indent left" })
map("v", ">", ">gv", { desc = "󰀄 Me: Indent right" })

-- have your next appear in the center of the screen
map("n", "n", "nzzzv", { desc = "󰀄 Me: Next forward vertically center aligned" })
map("n", "N", "Nzzzv", { desc = "󰀄 Me: Next backward vertically center aligned" })

-- yank to clipboard
map("v", "<leader>" .. hr.r2t, "\"+y", { desc = "󰀄 Me: Copy to clipbaord" })
map("v", "<leader>" .. hr.R2t, "\"+Y", { desc = "󰀄 Me: Copy to clipbaord" })
-- paste without loosing yank
map("x", "<leader>" .. hr.r3t, "\"_dP", { desc = "󰀄 Me: Paste without loosing yank" })
-- delete without loosing yank
map("x", "<leader>" .. hr.r4t, "\"_d", { desc = "󰀄 Me: Delete without loosing yank" })

map("n", vim.g.mapleader .. hr.l4t .. hr.l4t, function()
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
