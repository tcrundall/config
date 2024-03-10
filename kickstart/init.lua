-- disable netrw at the very start to avoid conflict with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set up leader before lazy so mappings can be configured
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'setup-lazy'
print 'Requiring custom'
require 'custom'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
