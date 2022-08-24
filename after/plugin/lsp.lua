local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

require("mason").setup()
require("mason-lspconfig").setup()

local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
  experimental = {
    ghost_text = true,
  },
})

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function()
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
,
  }, _config or {})
end

require("lspconfig").graphql.setup(config())

require('lspconfig').bashls.setup(config())

require('lspconfig').emmet_ls.setup(config())

require("lspconfig").marksman.setup(config())

require("lspconfig").tailwindcss.setup(config())

require("lspconfig").svelte.setup(config())

require("lspconfig").vuels.setup(config())

require("lspconfig").vimls.setup(config())

require("lspconfig").r_language_server.setup(config())

require("lspconfig").prismals.setup(config())

require("lspconfig").html.setup(config())

require("lspconfig").angularls.setup(config())

require("lspconfig").zls.setup(config())

require("lspconfig").tsserver.setup(config())

require("lspconfig").ccls.setup(config())

require("lspconfig").jedi_language_server.setup(config())

require("lspconfig").svelte.setup(config())

require("lspconfig").solang.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").gopls.setup(config({
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))

-- who even uses this?
require("lspconfig").rust_analyzer.setup(config({
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))

require("lspconfig").sumneko_lua.setup(config({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}))

local opts = {
  -- whether to highlight the currently hovered symbol
  -- disable if your cpu usage is higher than you want it
  -- or you just hate the highlight
  -- default: true
  highlight_hovered_item = true,

  -- whether to show outline guides
  -- default: true
  show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
  local plugins = { "friendly-snippets" }
  local paths = {}
  local path
  local root_path = vim.env.HOME .. "/.vim/plugged/"
  for _, plug in ipairs(plugins) do
    path = root_path .. plug
    if vim.fn.isdirectory(path) ~= 0 then
      table.insert(paths, path)
    end
  end
  return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
  paths = snippets_paths(),
  include = nil, -- Load all languages
  exclude = {},
})
