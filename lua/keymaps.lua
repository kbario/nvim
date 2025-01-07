if vim.opt.hlsearch then
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
end

-- find the current word
vim.keymap.set('n', '<leader>st', '/<c-r>=expand("<cword>")<cr><cr>')
-- find the current highlight
vim.keymap.set('n', '<leader>rt', ':s/\\(<c-r>=expand("<cword>")<cr>\\)/')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- for running lua from nvim without restarting
vim.keymap.set('n', '<leader>xx', '<cmd>source %<CR>')
vim.keymap.set('n', '<leader>x', ':.lua<CR>')
vim.keymap.set('v', '<leader>x', ':lua<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set({ 'n', 'v' }, '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ 'n', 'v' }, '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'i', 't' }, '<C-h>', '<C-\\><C-N><C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'i', 't' }, '<C-l>', '<C-\\><C-N><C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'i', 't' }, '<C-j>', '<C-\\><C-N><C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'i', 't' }, '<C-k>', '<C-\\><C-N><C-w>k', { desc = 'Move focus to the upper window' })

local state = { win = -1, buf = -1 }

local toggle_terminal = function(letter)
  state[letter] = -1
  return function()
    -- if win is open and the current buffer equals the requested then close
    if vim.api.nvim_win_is_valid(state.win) and state.buf == state[letter] then
      vim.api.nvim_win_close(state.win, false)
      state.win = -1
      state.buf = -1
      return
    end

    -- if the requested buffer doesn't exist, make it
    if not vim.api.nvim_buf_is_valid(state[letter]) then
      state[letter] = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
      state.buf = state[letter]
    end

    -- Define window configuration
    local win_config = { split = 'right', width = 75 }

    if vim.api.nvim_win_is_valid(state.win) then
      vim.api.nvim_win_set_buf(state.win, state[letter])
      state.buf = state[letter]
    else
      -- Create the window with the requested buffer
      state.win = vim.api.nvim_open_win(state[letter], true, win_config)
      state.buf = state[letter]
    end

    -- make it a terminal if not already
    if vim.bo[state[letter]].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  end
end

for _, letter in ipairs { 'n', 'e' } do
  vim.keymap.set('n', '<space>p' .. letter, toggle_terminal(letter))
end
