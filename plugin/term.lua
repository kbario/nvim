vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

local state = {}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

---@param term string: the key pressed to get the terminal
---@return function: the function to toggle the `term` terminal
local toggle_terminal = function(term)
  state[term] = { win = -1, buf = -1 }
  return function()
    if not vim.api.nvim_win_is_valid(state[term].win) then
      state[term] = create_floating_window { buf = state[term].buf }
      if vim.bo[state[term].buf].buftype ~= 'terminal' then
        vim.cmd.terminal()
      end
    else
      vim.api.nvim_win_hide(state[term].win)
    end
  end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command('Floaterminal', function()
  local asdf = vim.ui.input 'what quay?'
  if not asdf then
    return
  end
  toggle_terminal(asdf)
end, {})
for _, t in ipairs { 'j', 'k', 'l', ';' } do
  vim.keymap.set({ 'n', 't' }, '<leader>p' .. t, toggle_terminal(t), {})
end
