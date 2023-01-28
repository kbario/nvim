local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")
local hr = require("homerows.homerows")

local remap = require("kbario.keymap")
local nnoremap = remap.nnoremap

daptext.setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

nnoremap(vim.g.mapleader .. hr.l1b .. hr.l1b, function()
  dapui.toggle()
end, { desc = 'dap ui: toggle dap ui' })
--[[nnoremap("<End>", function()
  dapui.toggle(2)
  end)]]

nnoremap(vim.g.mapleader .. hr.l1b .. hr.r1, function()
  dap.step_over()
end, { desc = 'dap: step over' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.r2, function()
  dap.step_into()
end, { desc = 'dap: step into' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.r3, function()
  dap.step_out()
end, { desc = 'dap: step out' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.r4, function()
  dap.continue()
end, { desc = 'dap: continue' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.r1b, function()
  dap.toggle_breakpoint()
end, { desc = 'dap: toggle breakpoint' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.R1b, function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'dap: set conditional breakpoint' })
nnoremap(vim.g.mapleader .. hr.l1b .. hr.r2, function()
  dap.run_to_cursor()
end, { desc = 'dap: run to cursor' })

--[[ require("nvim-dap-virtual-text").setup {
  enabled = true,

  -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
  enabled_commands = false,

  -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_changed_variables = true,
  highlight_new_as_changed = true,

  -- prefix virtual text with comment string
  commented = false,

  show_stop_reason = true,

  -- experimental features:
  virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
} ]]


--[[dapui.setup({
    layouts = {
        {
            elements = {
                "console",
            },
            size = 7,
            position = "bottom",
        },
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40,
            position = "left",
        }
    },
})]]

require("kbario.dap.bash")
require("kbario.dap.chrome")
-- require("kbario.dap.node")
