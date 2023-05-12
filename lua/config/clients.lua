local M = {}

---@class Client
---@field dap? EnsureTable
---@field formatter? EnsureTable
---@field lsp? LspConfig[]
---@field treesitter?EnsureTable
---@field other? EnsureTable

---@class LspConfig
---@field kb_keys? LazyKeys[]

---@alias EnsureTable string[]

---@type Client[]
local configs = {
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
  fennel     = { treesitter = { "fennel" }, lsp = { fennel_language_server = {} } },
  fish       = { treesitter = { "fish" } },
  git        = {
    treesitter = { "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "diff" },
    other = { "gh" },
  },
  go         = {
    treesitter = { "go", "gomod", "gosum", "gowork" },
    lsp = {
      gopls = {
        config = {
          cmd = { "gopls", "serve" },
          settings = { gopls = { analyses = { unusedparams = true, }, staticcheck = true, }, },
        },
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
    lsp = {
      denols = false,
      tsserver = {
        kb_keys = function(hr)
          local ts = require("typescript")
          return {
            {
              "<leader>" .. hr.l0 .. hr.r0b,
              function() ts.actions.fixAll() end,
              desc = "󰒋 TS LSP: Fix all"
            },
            {
              "<leader>" .. hr.l0 .. hr.r2b,
              function() ts.actions.addMissingImports() end,
              desc = "󰒋 TS LSP: Add missing imports"
            },
            {
              "<leader>" .. hr.l0 .. hr.r3b,
              function() ts.actions.organizeImports() end,
              desc = "󰒋 TS LSP: Organise imports"
            },
            {
              "<leader>" .. hr.l0 .. hr.r4b,
              function() ts.actions.removeUnused() end,
              desc = "󰒋 TS LSP: Remove unused imports"
            },
          }
        end,
      },
      angularls = {
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "css", "scss" },
        kb_keys = function(hr)
          return {
            {
              "<leader>" .. hr.spear .. hr.r0,
              function() require("spear.spear").spear({ ".module.ts", "_helper.ts", "_utils.ts", "_helper.js", "utils.js" }) end,
              desc = "󱡅 Spear: Nav to module/helper/utils"
            },
            {
              "<leader>" .. hr.spear .. hr.r1,
              function()
                require("spear.spear").spear(
                  { ".component.ts", ".service.ts", ".pipe.ts" },
                  { match_pref = "next" }
                )
              end,
              desc = "󱡅 Spear: Nav to main file"
            },
            {
              "<leader>" .. hr.spear .. hr.r2,
              function() require("spear.spear").spear(".component.html") end,
              desc = "󱡅 Spear: Nav to template"
            },
            {
              "<leader>" .. hr.spear .. hr.r3,
              function()
                require("spear.spear").spear({ ".component.css", ".component.scss", ".component.sass", ".css" })
              end,
              desc = "󱡅 Spear: Nav to styles"
            },
            {
              "<leader>" .. hr.spear .. hr.r4,
              function()
                require("spear.spear").spear(
                  { ".component.spec.ts", ".service.spec.ts", ".pipe.spec.ts" },
                  { match_pref = "next" }
                )
              end,
              desc = "󱡅 Spear: Nav to tests"
            },
          }
        end,
      }
    },
    -- dap = { "node2" } --"chrome", --"firefox", --"js" } },
  },
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
  toml       = { treesitter = { "toml" } },
  vim        = { treesitter = { "vim" }, lsp = { vimls = {}, } },
  vimdoc     = { treesitter = { "vimdoc" } },
  yaml       = { treesitter = { "yaml" }, lsp = { yamlls = {}, azure_pipelines_ls = {} } },
  zig        = { treesitter = { "zig" }, lsp = { zls = {} } },
  treesitter = { other = { "tree-sitter-cli" } },
}

---@type LspConfig[]
M.lsp_clients = {}
---@type EnsureTable
M.ensure_mason = {}
---@type EnsureTable
M.ensure_treesitter = {}
---@type EnsureTable
M.ensure_mason_lsp = {}
---@type EnsureTable
M.ensure_mason_null_ls = {}
---@type EnsureTable
M.ensure_mason_dap = {}

for _, lang in pairs(configs) do
  -- treesitter
  M.ensure_treesitter = vim.list_extend(M.ensure_treesitter, lang.treesitter or {})
  -- lsp
  for client, config in pairs(lang.lsp or {}) do
    -- install
    if type(client) == "string" and config then
      table.insert(M.ensure_mason_lsp, client)
    end
    -- setup
    if type(client) == "string" and type(config) == "table" then
      M.lsp_clients = vim.tbl_extend("force", M.lsp_clients, { [client] = config or {} })
    end
  end
  -- formatters
  M.ensure_mason_null_ls = vim.list_extend(M.ensure_mason_null_ls, lang.formatter or {})
  -- debuggers
  M.ensure_mason_dap = vim.list_extend(M.ensure_mason_dap, lang.dap or {})
  -- compilers
  M.ensure_mason = vim.list_extend(M.ensure_mason, lang.other or {})
end

return M
