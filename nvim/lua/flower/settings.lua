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
vim.api.nvim_create_autocmd(
-- { "BufEnter" },
-- { "BufRead" },
  { "BufReadPost" },
  -- { command = ":%foldopen!" }
  -- { command = ":lua print('test') | let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))" }
  -- { command = ":lua print('test') -- print('hello')" }
  -- { command = "echo 'hello' | echo 'bye'" }
  -- { command = ":echo 'unfolding' | :normal zR | :echo 'bye'" }
  {
    callback = function()
      print("Buf read!!!")
      print(vim.api.nvim_buf_get_name(0))
      print("Expanding all tabs")
      vim.cmd(":normal zR")
      vim.cmd(":normal zR")
      print("Done")
      -- vim.cmd("set foldlevel?")
      -- vim.cmd(":normal zm")
    end
  }
)
-- vim.o.foldlevel = 999
