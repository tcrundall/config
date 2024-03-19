return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('nvim-tree').setup {
      view = {
        width = 50,
      },
      renderer = {
        group_empty = true, -- group empty directories into one line
      },
    }
    local api = require 'nvim-tree.api'

    vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'Project [T]ree [T]oggle' })
    vim.keymap.set('n', '<leader>tc', api.tree.close, { desc = 'Project [T]ree [C]lose' })
    vim.keymap.set('n', '<leader>to', api.tree.open, { desc = 'Project [T]ree [O]pen' })
    -- vim.keymap.set('n', '<leader>tf', api.tree.focus, { desc = 'Project [T]ree [F]ocus' })

    vim.keymap.set('n', '<leader>tl', function()
      api.tree.focus { find_file = true }
    end, { desc = 'Project [T]ree [L]ocate current buffer' })

    local telescope_builtin = require 'telescope.builtin'
    local telescope_utils = require 'telescope.utils'

    local sl_desc = '[S]earch [L]ocal with grep, either from parent dir of current buf or from dir under cursor in tree'
    vim.keymap.set('n', '<leader>sl', function()
      local target_dir

      if api.tree.is_tree_buf() then
        local current_node = api.tree.get_node_under_cursor()
        if current_node.type == 'file' then
          current_node = current_node.parent
        end
        target_dir = current_node.absolute_path
      else
        target_dir = telescope_utils.buffer_dir()
      end

      telescope_builtin.live_grep { cwd = target_dir }
    end, { desc = sl_desc })
  end,
}
