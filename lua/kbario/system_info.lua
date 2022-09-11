local M = {}

M.is_dar = vim.loop.os_uname().sysname == "Darwin"
M.is_lin = vim.fn.has "linux" == 1
M.is_mac = vim.fn.has "macunix" == 1
M.is_win = vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1
M.is_uni = vim.fn.has "unix" == 1
M.s_name = vim.loop.os_uname().sysname

return M
