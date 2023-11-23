local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})

-- Perform grep using cwd of buffer as root (works within netrw)
vim.keymap.set('n', '<leader>pl', function()
  builtin.live_grep({cwd=utils.buffer_dir(),})
end, {})

