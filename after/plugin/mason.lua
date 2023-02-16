local clients = require('kbario.clients')
local clients_to_install = {}
for client, config in pairs(clients) do
  if config then 
    table.insert(clients_to_install, client)
  end
  
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = clients_to_install
})
