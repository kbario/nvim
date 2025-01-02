vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Print on Lua file entry',
  group = vim.api.nvim_create_augroup('koil', { clear = true }),
  pattern = '*.lua',
  callback = function()
    vim.print 'hello LUA!'
  end,
})
