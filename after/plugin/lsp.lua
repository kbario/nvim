-- capabilities for lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- get path to lua server based on operating system
local my_system = require("kbario.system_info")
local lua_cmd
if my_system.is_mac then
  lua_cmd = { "/opt/homebrew/Cellar/lua-language-server/3.5.3/libexec/bin/lua-language-server" }
else
  lua_cmd = { "lua-language-server" }
end

-- the primeagen
local Remap = require("kbario.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- kbario
require("spear").setup({
  match_pref = "first",
  save_on_spear = false
})
local spear = require("spear.spear").spear
local homerows = require("kbario.what_layout")

-- mason
require("mason").setup()
require("mason-lspconfig").setup()

-- lsp
local lspconfig = require("lspconfig")
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
    native_menu = false,
  },
})

local client_attach = setmetatable({
  angularls = function()
    nnoremap("<leader>s" .. homerows.first_right, function()
      spear(".component.ts")
    end)
    nnoremap("<leader>s" .. homerows.second_right, function()
      spear(".component.html")
    end)
    nnoremap("<leader>s" .. homerows.third_right, function()
      spear({ ".component.css", ".component.scss", ".component.sass" })
    end)
    nnoremap("<leader>s" .. homerows.fourth_right, function()
      spear(".component.spec.ts")
    end)
  end
}, {
  __index = function()
    return function() end
  end,
})
--[[
local file_attach = setmetatable({
  markdown = function()
    nnoremap("<leader>ms", function()
      vim.api.nvim_command(":MarkdownPreview")
    end)
    nnoremap("<leader>mq", function()
      vim.api.nvim_command(":MarkdownPreviewStop")
    end)
  end,
}, {
  __index = function()
    return function() end
  end,
}) ]]

local fancy_attach = function(client, file_type)
  nnoremap("K", function() vim.lsp.buf.hover() end)
  nnoremap("<leader>gd", function() vim.lsp.buf.definition() end)
  nnoremap("<leader>dg", function() vim.diagnostic.open_float() end)
  nnoremap("<leader>gn", function() vim.diagnostic.goto_next() end)
  nnoremap("<leader>gp", function() vim.diagnostic.goto_prev() end)
  nnoremap("<leader>ga", function() vim.lsp.buf.code_action() end)
  nnoremap("<leader>gr", function() vim.lsp.buf.references() end)
  nnoremap("<leader>gi", function() vim.lsp.buf.implementation() end)
  nnoremap("<leader>rn", function() vim.lsp.buf.rename() end)
  inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
  nnoremap("<leader>mp", function() print("filetype:", file_type, "and client:", client) end)
  -- Attach any filetype specific options to the client
  -- file_attach[file_type](client)
end

local setup_client = function(client, config)
  if not config then
    return
  end

  local file_type = vim.api.nvim_buf_get_option(0, "filetype")

  config = vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = fancy_attach(client, file_type),
  }, config or {})

  lspconfig[client].setup(config)
end

local clients = {
  graphql = false,
  bashls = false,
  emmet_ls = {},
  marksman = {},
  tailwindcss = false,
  svelte = false,
  vuels = false,
  vimls = false,
  r_language_server = false,
  prismals = false,
  html = {},
  angularls = {},
  zls = false,
  tsserver = {},
  ccls = false,
  jedi_language_server = false,
  solang = false,
  cssls = {},
  jsonls = {},
  cssmodules_ls = false,
  gopls = {
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
      }
    }
  },
  sumneko_lua = {
    cmd = lua_cmd,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

-- unleash the hounds
for client, config in pairs(clients) do
  setup_client(client, config)
end


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
