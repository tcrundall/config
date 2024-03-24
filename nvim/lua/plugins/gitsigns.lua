return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  config = function()
    local opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        delay = 300,
        virt_text_pos = 'right_align',
        -- virt_text_pos = 'eol',
      },
    }
    print 'configuring gitsigns'
    local gitsigns = require 'gitsigns'
    gitsigns.setup(opts)

    vim.keymap.set('n', 'ga', function()
      gitsigns.stage_hunk()
    end, { desc = '[G]it [A]dd hunk to stage' })

    vim.keymap.set('n', 'gu', function()
      gitsigns.undo_stage_hunk()
    end, { desc = '[G]it [U]ndo last add of hunk to stage' })

    vim.keymap.set('n', 'gX', function()
      print 'Trying to reset hunk'
      gitsigns.reset_hunk()
    end, { desc = '[G]it [X]reset current hunk' })

    vim.keymap.set('n', 'gn', function()
      gitsigns.next_hunk()
    end, { desc = '[G]it go to [N]ext hunk' })

    vim.keymap.set('n', 'gp', function()
      gitsigns.prev_hunk()
    end, { desc = '[G]it go to [P]revious hunk' })
  end,
}
