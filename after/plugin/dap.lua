local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

local remap = require("kbario.keymap")
local nnoremap = remap.nnoremap

daptext.setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- require("theprimeagen.debugger.node");

nnoremap("<leader>dt", function()
  dapui.toggle()
end)
--[[nnoremap("<End>", function()
  dapui.toggle(2)
  end)]]

nnoremap("<Leader>dn", function()
  dap.continue()
end)
nnoremap("<Leader>de", function()
  dap.step_over()
end)
nnoremap("<Leader>di", function()
  dap.step_into()
end)
nnoremap("<Leader>do", function()
  dap.step_out()
end)
nnoremap("<Leader>db", function()
  dap.toggle_breakpoint()
end)
nnoremap("<Leader>dB", function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
nnoremap("<leader>dc", function()
  dap.run_to_cursor()
end)

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
