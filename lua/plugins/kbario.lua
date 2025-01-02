return {
  {
    'kbario/spear.nvim',
    -- ft = { "tsx", "ts", "html", "css", "scss", "sass" },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = true,
    keys = {
      '<leader>' .. 's',
      desc = '󱡅 Spear',
    },
    dev = false,
  },
}
