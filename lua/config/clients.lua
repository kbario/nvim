local M = {}

local config = {
    arduino    = { treesitter = { "arduino" }, lsp = { arduino_language_server = {}, }, formatter = {} },
    astro      = { treesitter = { "astro" }, lsp = { astro = {} }, formatter = {} },
    bash       = { treesitter = { "bash" }, lsp = { bashls = {}, powershell_es = {} }, formatter = {}, dap = { "bash" } },
    c          = { treesitter = { "c" }, lsp = {}, formatter = {}, dap = { "cppdbg" } },
    c_sharp    = { treesitter = { "c_sharp" }, lsp = { omnisharp = {}, }, formatter = {} },
    cmake      = { treesitter = { "cmake" }, lsp = {}, formatter = {} },
    comment    = { treesitter = { "comment" }, lsp = {}, formatter = {} },
    css        = {
        treesitter = { "css", "scss" },
        lsp = { cssls = {}, cssmodules_ls = false, tailwindcss = {}, },
        formatter = {}
    },
    dockerfile = { treesitter = { "dockerfile" }, lsp = {}, formatter = {} },
    dot        = { treesitter = { "dot" }, lsp = {}, formatter = {} },
    elixir     = { treesitter = { "elixir" }, lsp = {}, formatter = {} },
    fennel     = { treesitter = { "fennel" }, lsp = {}, formatter = {} },
    fish       = { treesitter = { "fish" }, lsp = {}, formatter = {} },
    git        = {
        treesitter = { "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "diff" },
        lsp = {},
        formatter = {},
    },
    go         = {
        treesitter = { "go", "gomod", "gosum", "gowork" },
        lsp = {
            gopls = {
                cmd = { "gopls", "serve" },
                settings = { gopls = { analyses = { unusedparams = true, }, staticcheck = true, }, },
            },
        },
        formatter = {},
        dap = { "delve" }
    },
    graphql    = { treesitter = { "graphql" }, lsp = { graphql = {} }, formatter = {} },
    help       = { treesitter = { "help" }, lsp = {}, formatter = {} },
    html       = { treesitter = { "html" }, lsp = { emmet_ls = {}, html = {} }, formatter = {} },
    http       = { treesitter = { "http" }, lsp = {}, formatter = {} },
    javascript = {
        treesitter = { "javascript", "jsdoc", "typescript", "tsx" },
        lsp = { denols = false, tsserver = {}, angularls = {} },
        formatter = {},
        dap = { "node2" }
    },                                                                                                --"chrome", --"firefox", --"js" } },
    json       = { treesitter = { "json", "json5", "JSON" }, lsp = { jsonls = {}, }, formatter = {} },
    julia      = { treesitter = { "julia" }, lsp = {}, formatter = {} },
    kotlin     = { treesitter = { "kotlin" }, lsp = {}, formatter = {} },
    latex      = { treesitter = { "latex" }, lsp = {}, formatter = {} },
    llvm       = { treesitter = { "llvm" }, lsp = {}, formatter = {} },
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
    make       = { treesitter = { "make" }, lsp = {}, formatter = {} },
    markdown   = { treesitter = { "markdown", "markdown_inline" }, lsp = { marksman = {}, }, formatter = {} },
    mermaid    = { treesitter = { "mermaid" }, lsp = {}, formatter = {} },
    ocaml      = { treesitter = { "ocaml", "ocaml_interface", "ocamllex" }, lsp = {}, formatter = {} },
    prisma     = { treesitter = { "prisma" }, lsp = { prismals = false, }, formatter = {} },
    python     = { treesitter = { "python" }, lsp = { jedi_language_server = {}, }, formatter = {}, dap = { "python" } },
    r          = { treesitter = { "r" }, lsp = { r_language_server = {}, }, formatter = {} },
    regex      = { treesitter = { "regex" }, lsp = {}, formatter = {} },
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
        formatter = {},
        dap = { "codelldb", "cppdbg" }
    },
    scala      = { treesitter = { "scala" }, lsp = {}, formatter = {} },
    scheme     = { treesitter = { "scheme" }, lsp = {}, formatter = {} },
    sql        = { treesitter = { "sql" }, lsp = { sqlls = {}, }, formatter = {} },
    svelte     = { treesitter = { "svelte" }, lsp = { svelte = {}, }, formatter = {} },
    swift      = { treesitter = { "swift" }, lsp = {}, formatter = {} },
    todotxt    = { treesitter = { "todotxt" }, lsp = {}, formatter = {} },
    toml       = { treesitter = { "toml" }, lsp = {}, formatter = {} },
    vim        = { treesitter = { "vim" }, lsp = { vimls = {}, }, formatter = {} },
    vimdoc     = { treesitter = { "vimdoc" }, lsp = {}, formatter = {} },
    yaml       = { treesitter = { "yaml" }, lsp = { yamlls = {}, azure_pipelines_ls = {} }, formatter = {} },
    zig        = { treesitter = { "zig" }, lsp = { zls = {} }, formatter = {} },
}

M.ensure_treesitter = {}
M.lsp_clients = {}
M.ensure_mason_lsp = {}
M.ensure_mason_null_ls = {}
M.ensure_mason_dap = {}
for _, lang in pairs(config) do
    M.ensure_treesitter = vim.tbl_extend("force", M.ensure_treesitter, lang.treesitter or {})
    M.lsp_clients = vim.tbl_extend("force", M.lsp_clients, lang.lsp or {})
    for client, _ in pairs(lang.lsp or {}) do
        if client then
            table.insert(M.ensure_mason_lsp, client)
        end
    end
    M.ensure_mason_null_ls = vim.tbl_extend("force", M.ensure_mason_null_ls, lang.formatter or {})
    M.ensure_mason_dap = vim.tbl_extend("force", M.ensure_mason_dap, lang.dap or {})
end

return M
