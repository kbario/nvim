local _openGithubUrl = function()
  local cword = vim.fn.expand '<cWORD>'
  local url = vim.split(cword, "'", { trimempty = true })[1]
  local new_url = 'https://github.com/' .. url
  vim.ui.open(new_url)
end

local _openUrl = function()
  local cword = vim.fn.expand '<cWORD>'
  local urls = vim.split(cword, "'", { trimempty = true })
  local url
  for _, _url in ipairs(urls) do
    if vim.startswith(_url, 'http') then
      url = _url
    end
  end
  vim.ui.open(url)
end

vim.api.nvim_create_user_command('LookUpGithub', _openGithubUrl, {})

vim.api.nvim_create_user_command('LookUpURL', _openUrl, {})

-- vim.keymap.set('n', 'ggg', _openGithubUrl, { desc = 'open a github url'})
-- vim.keymap.set('n', 'ggu', _openUrl, { desc = 'open a url'})

-- kbario/spear.nvim

vim.cmd [[
  aunmenu   PopUp
  anoremenu PopUp.Inspect     <cmd>Inspect<CR>
  amenu     PopUp.-1-         <NOP>
  anoremenu PopUp.Definition  <cmd>lua vim.lsp.buf.definition()<CR>
  anoremenu PopUp.References  <cmd>Telescope lsp_references<CR>
  nnoremenu PopUp.Back        <C-t>
  amenu     PopUp.-2-         <NOP>
  amenu     PopUp.URL         <cmd>LookUpURL<CR>
  amenu     PopUp.Github      <cmd>LookUpGithub<CR>
]]

local group = vim.api.nvim_create_augroup('nvim_popupmenu', { clear = true })
vim.api.nvim_create_autocmd('MenuPopup', {
  pattern = '*',
  group = group,
  desc = 'Custom PopUp Setup',
  callback = function()
    vim.cmd [[
      amenu disable PopUp.Definition
      amenu disable PopUp.References
      amenu disable PopUp.URL
    ]]

    if vim.lsp.get_clients({ bufnr = 0 })[1] then
      vim.cmd [[
        amenu enable PopUp.Definition
        amenu enable PopUp.References
      ]]
    end

    local cword = vim.fn.expand '<cWORD>'
    local urls = vim.split(cword, "'", { trimempty = true })
    for _, url in ipairs(urls) do
      if vim.startswith(url, 'http') then
        vim.cmd [[
        amenu enable PopUp.URL
      ]]
      end
    end
  end,
})
