local path = require("mason-core.path")
local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { path.concat { vim.fn.stdpath "data", "mason", "packages/node-debug2-adapter/out/src/nodeDebug.js" } },
}

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require 'dap.utils'.pick_process,
    },
  }
end

