local kiwi = require('kiwi')

kiwi.setup({
  {
    name = "personal",
    path = "/Users/tcrundall/Notes"
  }
})

-- Necessary keybindings
vim.keymap.set('n', '<leader>ww', kiwi.open_wiki_index, {})
vim.keymap.set('n', '<leader>wx', kiwi.todo.toggle, {})
