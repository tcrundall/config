local packages = {
  "flower",
  "fun.fun",
  "luasnippets",
}
-- require("luasnippets")

for _, pack in ipairs(packages) do
  package.loaded[pack] = false
  require(pack)
end

local fun = require("fun.fun")
vim.keymap.set("n", "<leader>f", function() fun.my_func() end)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
