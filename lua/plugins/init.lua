return {
  'tpope/vim-sleuth',
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      if vim.g.colour_scheme == 'catppuccin' then
        vim.cmd.colorscheme 'catppuccin-mocha'
      end
    end,
  },
  { 'Bilal2453/luvit-meta', lazy = true },
}
