-- set bash
vim.o.shell = "/bin/bash"

-- set line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true


-- Setting tabspace behaviour
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true

-- Cursor control
vim.o.scrolloff = 8

-- Buffer settings for auto-read and -write
vim.o.autoread = true
vim.api.nvim_create_autocmd(
  { "FocusGained", "BufEnter", "BufWinEnter" },
  {
    command = ":silent! !"
  }
)
vim.api.nvim_create_autocmd(
  { "FocusLost", "WinLeave" },
  { command = ":silent! noautocmd w" }
)

-- Fold options
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 1
