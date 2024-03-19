return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    vim.keymap.set('n', '<leader>gh', function()
      vim.cmd '0Gclog'
    end)
  end,
}
