-- Keep cursor centred when jumping
vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "#", "#zz")
vim.keymap.set("n", "*", "*zz")

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- -- jump to next custom tag (@y)
-- vim.keymap.set("n", "<leader>y", "/@y<CR>vlc")
-- vim.keymap.set({ "i", "n" }, "<c-y>", "<ESC>/@y<CR>vlc")

------- Manipulating panes ---------
vim.keymap.set("n", "<leader>V", ":vs<CR>:wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>H", ":sp<CR>:wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<leader>x", ":q<CR>")
vim.keymap.set("n", "<leader>l", "<C-W>10>")
vim.keymap.set("n", "<leader>h", "<C-W>10<")
vim.keymap.set("n", "<leader>j", "<C-W>5+")
vim.keymap.set("n", "<leader>k", "<C-W>5-")
-------------------------------------

-- Source nvim config
-- Also redetect filetype to apply file specific settings
vim.keymap.set("n", "<leader>so", ":so ~/.config/nvim/init.lua<CR>:filetype detect<CR>")

-- [C]opy whole [F]ile
vim.keymap.set("n", "<leader>cf", "GVgg\"+y<C-O><C-O>zz")

-- whole [F]ile, [H]ighlight
vim.keymap.set("n", "<leader>fh", "GVgg")

-- copy highlight to [C]lip[B]oard
vim.keymap.set("v", "<leader>cb", "\"+y")

-- avoid putting when mistyping maps
vim.keymap.set("n", "<leader>p", ":echo 'avoided putting!'<CR>")
