local clients = require('kbario.clients')
local clients_to_install = {}
for client, config in pairs(clients) do
  if config and client ~= "rust_analyzer" then
    table.insert(clients_to_install, client)
  end
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = clients_to_install
})

require("mason-null-ls").setup({
  automatic_setup = true,
  ensure_installed = {
    "sqlfluff", "sql_formatter", "stylua", "codespell", "prettier", "prettierd", "eslint_d"
  }
})
require("null-ls").setup()
