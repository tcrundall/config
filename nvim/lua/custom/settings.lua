-- set shell to bash, in interactive mode (for access to aliases)
-- avoids super laggy tmux switch when using fish
-- vim.o.shell = '/bin/bash --rcfile ' .. vim.fn.expand '~' .. '/.bash_aliases'
vim.o.shell = "/bin/bash --login"
-- vim.o.shell = '/bin/bash -i'

vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- `:help option-list`

-- Ensure initial fold level is at max
vim.opt.foldlevel = 99

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- Ensure files are at max fold level upon opening?
vim.opt.foldlevel = 100000
