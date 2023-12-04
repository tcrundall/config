local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

-- [P]roject [F]ind files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- TODO: what is difference between grep_string and live_grep
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- [G]rep [P]roject
vim.keymap.set('n', '<leader>gp', builtin.live_grep, {})

-- [G]rep [G]it
vim.keymap.set('n', '<leader>gg', builtin.git_files, {})

-- Perform grep using cwd of buffer as root (works within netrw)
-- vim.keymap.set('n', '<leader>pl', function()
--   builtin.live_grep({ cwd = utils.buffer_dir(), })
-- end, {})
