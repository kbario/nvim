return {
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
        or nil,
    dependencies = { "rafamadriz/friendly-snippets", },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end
      vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
        { "vscode", "snipmate", "lua" })
    end,
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    commit = "a9c701fa7e12e9257b3162000e5288a75d280c28", -- https://github.com/hrsh7th/nvim-cmp/issues/1382
    dependencies = {
      'neovim/nvim-lspconfig',
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-cmdline',
      {
        "onsails/lspkind.nvim",
        config = function()
          require("lspkind").init()
        end
      }
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require "cmp"
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      -- local lspkind_status_ok, lspkind = pcall(require, "lspkind")
      if not snip_status_ok then return end

      ---@return cmp.ConfigSchema
      return {
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(_, item)
            local icons = require("config.ui").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end or nil,
          -- lspkind_status_ok and lspkind.cmp_format({
          --   with_text = true,
          --   menu = {
          --     nvim_lsp = "[LSP]",
          --     buffer = "[buf]",
          --     nvim_lua = "[Lua]",
          --     path = "[path]",
          --     luasnip = "[snip]",
          --   }
          -- })
          -- or
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        duplicates = {
          nvim_lsp = 5,
          luasnip = 5,
          cmp_tabnine = 5,
          buffer = 5,
          path = 5,
        },
        experimental = {
          ghost_text = true
        },

        window = {
          completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│", },
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│", },
          },
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-e>"] = cmp.config.disable,
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ["<CR>"] = cmp.mapping.confirm { select = false },
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip",  priority = 750 },
          { name = "buffer",   priority = 500 },
          { name = "path",     priority = 250 },
          { name = "nvim_lua", priority = 100 },
        },
      }
    end,
    config = function(_, opts)
      require('cmp').setup(opts)
      vim.g.cmp_enabled = true
    end
  },
}
