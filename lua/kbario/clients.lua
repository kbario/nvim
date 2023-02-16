M = {
  angularls = {},
  astro = {},
  bashls = {},
  ccls = false,
  cssls = {},
  cssmodules_ls = false,
  denols = false,
  emmet_ls = {},
  gopls = false,
  -- gopls = {
  --   cmd = { "gopls", "serve" },
  --   settings = {
  --     gopls = {
  --       analyses = {
  --         unusedparams = true,
  --       },
  --       staticcheck = true,
  --     },
  --   },
  -- },
  graphql = false,
  html = {},
  jedi_language_server = false,
  jsonls = {},
  marksman = false,
  omnisharp = {},
  prismals = false,
  r_language_server = false,
  remark_ls = {},
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
  solang = false,
  sqlls = {},
  lua_ls = {
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
  svelte = false,
  tailwindcss = {},
  tsserver = {},
  vuels = false,
  vimls = {},
  zls = false,
}

return M
