local M = {}
-- Make sure that 'stevearc/overseer.nvim' is loaded and set up prior to this
-- local overseer_status = require('overseer-stl')

M.setup_status_line = function()
  local active_content = function()
    local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
    local git = MiniStatusline.section_git { trunc_width = 40 }
    local diff = MiniStatusline.section_diff { trunc_width = 75 }
    local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
    local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
    local filename = MiniStatusline.section_filename { trunc_width = 140 }
    local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
    local location = MiniStatusline.section_location { trunc_width = 75 }
    local search = MiniStatusline.section_searchcount { trunc_width = 75 }

    -- local overseer = overseer_status()
    local lint_progress = function()
      local linters = require('lint').get_running()
      if #linters == 0 then
        return '󰦕'
      end
      return '󱉶 ' .. table.concat(linters, ', ')
    end

    return MiniStatusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      {
        hl = 'MiniStatuslineDevinfo',
        strings = {
          git,
          diff,
          diagnostics,
          lsp,
          -- overseer
          lint_progress(),
        },
      },
      '%<', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location } },
    }
  end

  local statusline = require 'mini.statusline'
  statusline.setup { use_icons = vim.g.have_nerd_font, content = { active = active_content } }
  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function()
    return '%2l:%-2v'
  end
end
return M
