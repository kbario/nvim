local hr = require("homerows.homerows")

require("nvim-surround").setup({
  keymaps = {
    insert = false,
    insert_line = false,
    normal = vim.g.mapleader .. hr.r1b,
    normal_cur = vim.g.mapleader .. hr.R1b,
    normal_line = false, -- vim.g.mapleader .. hr.r1b .. hr.R1b,
    normal_cur_line = false, -- vim.g.mapleader .. hr.r1b .. hr.R1b .. hr.R1b,
    visual = vim.g.mapleader .. hr.r2b,
    visual_line = vim.g.mapleader .. hr.R2b,
    change = vim.g.mapleader .. hr.r3b,
    delete = vim.g.mapleader .. hr.r4b,
  },
})
