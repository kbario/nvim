local Remap = require("kbario.keymap")

local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

local M = {}

M.lsp_keymaps = function ()
      nnoremap("K", function() vim.lsp.buf.hover() end)
      nnoremap("<leader>gd", function() vim.lsp.buf.definition() end)
      -- nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
      nnoremap("<leader>dg", function() vim.diagnostic.open_float() end)
      nnoremap("<leader>gn", function() vim.diagnostic.goto_next() end)
      nnoremap("<leader>gp", function() vim.diagnostic.goto_prev() end)
      nnoremap("<leader>ga", function() vim.lsp.buf.code_action() end)
      nnoremap("<leader>gr", function() vim.lsp.buf.references() end)
      nnoremap("<leader>gi", function() vim.lsp.buf.implementation() end)
      nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
      nnoremap("<leader>sa", function() vim.lsp.buf.formatting() end)
      inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
end

return M
