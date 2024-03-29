local ensure_mason_lsp = require("config.clients").ensure_mason_lsp

local M = {}

---@type PluginLspKeys
M._keys = nil

function M.get(hr)
  if not M._keys then
    ---@class PluginLspKeys
    -- stylua: ignore
    M._keys = {
      {
        "K",
        function() vim.lsp.buf.hover() end,
        desc = "󰒋 LSP: Hover info"
      },
      {
        "<leader>" .. hr.l0 .. hr.l0,
        "<cmd>LspInfo<cr>",
        desc = "󰒋 LSP: Lsp info"
      },
      {
        "<leader>" .. hr.l0 .. hr.r1,
        -- function() vim.lsp.buf.definition() end,
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "󰒋 LSP: Go to definition"
      },
      {
        "<leader>" .. hr.l0 .. hr.r2,
        -- function() vim.lsp.buf.implementation() end,
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "󰒋 LSP: Go to implementation"
      },
      {
        "<leader>" .. hr.l0 .. hr.r3,
        -- function() vim.lsp.buf.references() end,
        "<cmd>Telescope lsp_references<cr>",
        desc = "󰒋 LSP: Go to all references",
      },
      {
        "<leader>" .. hr.l0 .. hr.r4,
        function() vim.lsp.buf.code_action() end,
        desc = "󰒋 LSP: Code actions"
      },
      {
        "<leader>" .. hr.l0 .. hr.r1t,
        M.diagnostic_goto(true),
        desc = "󰒋 LSP: Next diagnostic"
      },
      {
        "<leader>" .. hr.l0 .. hr.r2t,
        M.diagnostic_goto(false),
        desc = "󰒋 LSP: Previous diagnostic"
      },
      {
        "<leader>" .. hr.l0 .. hr.R1t,
        M.diagnostic_goto(true, "ERROR"),
        desc = "󰒋 LSP: Next error"
      },
      {
        "<leader>" .. hr.l0 .. hr.R2t,
        M.diagnostic_goto(false, "ERROR"),
        desc = "󰒋 LSP: Previous error"
      },
      {
        "<leader>" .. hr.l0 .. hr.r3t,
        M.diagnostic_goto(true, "WARN"),
        desc = "󰒋 LSP: Next error"
      },
      {
        "<leader>" .. hr.l0 .. hr.r4t,
        M.diagnostic_goto(false, "WARN"),
        desc = "󰒋 LSP: Previous error"
      },
      {
        "<leader>" .. hr.l0 .. hr.r1b,
        function() vim.lsp.buf.rename() end,
        desc = "󰒋 LSP: Rename variable"
      }
      -- {
      --   "<leader>" .. hr.l0 .. hr.R4t,
      --   function() vim.diagnostic.open_float() end,
      --   desc = "󰒋 LSP: Open float?"
      -- },
    }
  end

  return M._keys
end

function M.on_attach(client, buffer, quays)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

  for _, value in ipairs(quays) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

return {
  "b0o/SchemaStore.nvim",
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true
      },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        -- cond = function()
        --   return require("lazy.core.config").plugins["nvim-cmp"] ~= nil
        -- end,
      },
      {
        "kbario/homerows.nvim",
        opts = {
          custom_keys = {
            lsp = "l0"
          }
        }
      }
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "icons",
        },
        severity_sort = true,
      }
    },
    config = function(_, opts)
      local ok, hrr = pcall(require, "homerows")
      if not ok then return end
      local hr = hrr.lazy_hr()

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = ensure_mason_lsp,
      })

      for name, icon in pairs(require("config.ui").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●" or
            function(diagnostic)
              local icons = require("config.ui").icons.diagnostics
              for d, icon in pairs(icons) do
                if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                  return icon
                end
              end
            end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local clients = require('config.clients').lsp_clients
      local lspconfig = require("lspconfig")

      local setup_client = function(lsp_client, config)
        if not config then
          return
        end

        config = vim.tbl_deep_extend("force", {
          capabilities = require("cmp_nvim_lsp").default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          ),
          on_attach = function(client, bfnr)
            M.on_attach(client, bfnr, M.get(hr))
            if config.kb_keys then
              if type(config.kb_keys) == "function" then
                M.on_attach(client, bfnr, config.kb_keys(hr))
              elseif type(config.kb_keys) == "table" then
                M.on_attach(client, bfnr, config.kb_keys or {})
              end
            end
          end
        }, opts or {}, config or {})

        if lsp_client == 'tsserver' then
          require("typescript").setup({ server = config })
        else
          lspconfig[lsp_client].setup(config)
        end
      end

      -- unleash the hounds
      for client, config in pairs(clients) do
        setup_client(client, config)
      end
    end
  },
}
