local M = {}

local config = {
  arduino    = { treesitter = { "arduino" }, lsp = { arduino_language_server = {}, } },
  astro      = { treesitter = { "astro" }, lsp = { astro = {} } },
  bash       = { treesitter = { "bash" }, lsp = { bashls = {}, powershell_es = {} }, dap = { "bash" } },
  c          = { treesitter = { "c", "cmake", "make" }, lsp = {}, formatter = {}, dap = { "cppdbg" } },
  c_sharp    = { treesitter = { "c_sharp" }, lsp = { omnisharp = {}, }, formatter = { "csharpier" } },
  comment    = { treesitter = { "comment" }, lsp = {}, formatter = {} },
  css        = { treesitter = { "css", "scss" }, lsp = { cssls = {}, cssmodules_ls = false, tailwindcss = {}, }, },
  dockerfile = { treesitter = { "dockerfile" }, lsp = {}, formatter = {} },
  dot        = { treesitter = { "dot" }, lsp = {}, formatter = {} },
  elixir     = { treesitter = { "elixir" }, lsp = {}, formatter = {} },
  fennel     = { treesitter = { "fennel" }, lsp = { "fennel-language-server" } },
  fish       = { treesitter = { "fish" } },
  git        = {
    treesitter = { "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "diff" },
    lsp = { "gh" },
  },
  go         = {
    treesitter = { "go", "gomod", "gosum", "gowork" },
    lsp = {
      gopls = {
        cmd = { "gopls", "serve" },
        settings = { gopls = { analyses = { unusedparams = true, }, staticcheck = true, }, },
      },
    },
    formatter = { "gofumpt" },
    dap = { "delve" }
  },
  graphql    = { treesitter = { "graphql" }, lsp = { graphql = {} } },
  -- help       = { treesitter = { "help" }},
  html       = { treesitter = { "html" }, lsp = { emmet_ls = {}, html = {} } },
  http       = { treesitter = { "http" } },
  javascript = {
    treesitter = { "javascript", "jsdoc", "typescript", "tsx" },
    lsp = { denols = false, tsserver = {}, angularls = {} },
    dap = { "node2" }
  }, --"chrome", --"firefox", --"js" } },
  json       = { treesitter = { "json", "json5", "JSON", "jsonc" }, lsp = { jsonls = {}, } },
  julia      = { treesitter = { "julia" } },
  kotlin     = { treesitter = { "kotlin" } },
  latex      = { treesitter = { "latex" } },
  llvm       = { treesitter = { "llvm" } },
  lua        = {
    treesitter = { "lua", "luadoc", "luau" },
    lsp = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
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
    },
    formatter = { "stylua" },
  },
  markdown   = {
    treesitter = { "markdown", "markdown_inline" },
    lsp = { marksman = {}, },
    formatter = { "markdown-toc", "markdowlint" }
  },
  mermaid    = { treesitter = { "mermaid" } },
  ocaml      = { treesitter = { "ocaml", "ocaml_interface", "ocamllex" } },
  prisma     = { treesitter = { "prisma" }, lsp = { prismals = false, } },
  python     = { treesitter = { "python" }, lsp = { jedi_language_server = {}, }, dap = { "python" } },
  prettier   = { formatter = { "prettier", "prettierd" }, },
  r          = { treesitter = { "r" }, lsp = { r_language_server = {}, } },
  regex      = { treesitter = { "regex" } },
  rust       = {
    treesitter = { "rust" },
    lsp = {
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
              enable = true,
            },
          },
        },
      },
    },
    dap = { "codelldb", "cppdbg" }
  },
  scala      = { treesitter = { "scala" } },
  scheme     = { treesitter = { "scheme" } },
  sql        = { treesitter = { "sql" }, lsp = { sqlls = {}, } },
  svelte     = { treesitter = { "svelte" }, lsp = { svelte = {}, } },
  swift      = { treesitter = { "swift" } },
  todotxt    = { treesitter = { "todotxt" } },
  treesitter = { lsp = { ["tree-sitter-cli"] = {} } },
  toml       = { treesitter = { "toml" } },
  vim        = { treesitter = { "vim" }, lsp = { vimls = {}, } },
  vimdoc     = { treesitter = { "vimdoc" } },
  yaml       = { treesitter = { "yaml" }, lsp = { yamlls = {}, azure_pipelines_ls = {} } },
  zig        = { treesitter = { "zig" }, lsp = { zls = {} } }
}

M.lsp_clients = {}
M.ensure_treesitter = {}
M.ensure_mason_lsp = {}
M.ensure_mason_null_ls = {}
M.ensure_mason_dap = {}
for _, lang in pairs(config) do
  M.ensure_treesitter = vim.list_extend(M.ensure_treesitter, lang.treesitter or {})
  for client, config in pairs(lang.lsp or {}) do
    if type(client) == "string" and type(config) == "table" then
      table.insert(M.ensure_mason_lsp, client)
      M.lsp_clients = vim.tbl_extend("force", M.lsp_clients, { [client] = config })
    end
  end
  M.ensure_mason_null_ls = vim.list_extend(M.ensure_mason_null_ls, lang.formatter or {})
  M.ensure_mason_dap = vim.list_extend(M.ensure_mason_dap, lang.dap or {})
end

return M
