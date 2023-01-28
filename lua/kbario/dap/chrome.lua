local path = require("mason-core.path")
local dap = require('dap')

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { path.concat { vim.fn.stdpath "data", "mason", "packages/vscode-chrome-debug/out/src/chromeDebug.js" } },
}

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
  require("dap").configurations[language] = {
    {
      name = "Debug (attach) Chrome",
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      trace = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
end
