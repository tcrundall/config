return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('nvim-tree').setup {}
    local api = require 'nvim-tree.api'

    vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'Project [T]ree [T]oggle' })
    vim.keymap.set('n', '<leader>tc', api.tree.close, { desc = 'Project [T]ree [C]lose' })
    vim.keymap.set('n', '<leader>to', api.tree.open, { desc = 'Project [T]ree [O]pen' })
    vim.keymap.set('n', '<leader>tf', api.tree.focus, { desc = 'Project [T]ree [F]ocus' })

    vim.keymap.set('n', '<leader>tl', function()
      api.tree.focus { find_file = true }
    end, { desc = 'Project [T]ree [L]ocate current buffer' })
  end,
}
