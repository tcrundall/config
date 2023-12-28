vim.g.mapleader = " "

-- vim.keymap.set("n", "<leader>x", function() vim.cmd(":q") end)
vim.keymap.set("n", "<leader>x", ":q<CR>")

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- jump to next custom tag (@y)
vim.keymap.set("n", "<leader>y", "/@y<CR>vlc")
vim.keymap.set({ "i", "n" }, "<c-y>", "<ESC>/@y<CR>vlc")

-- Using plugin
-- vim.keymap.set({"n","i"}, "<c-h>", ":<C-U>TmuxNavigateLeft<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-j>", ":<C-U>TmuxNavigateDown<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-k>", ":<C-U>TmuxNavigateUp<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-l>", ":<C-U>TmuxNavigateRight<cr>", { silent = true })

-- Custom attempt
-- vim.keymap.set({"n","i"}, "<c-h>", ":! tmux select-pane -L<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-j>", ":! tmux select-pane -D<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-k>", ":! tmux select-pane -U<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-l>", ":! tmux select-pane -R<CR><CR>", { silent = true })

-- Splitting
vim.keymap.set("n", "<leader>V", ":vs<CR>:wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>H", ":sp<CR>:wincmd j<CR>", { silent = true })

-- Source nvim config
-- Also redetect filetype to apply file specific settings
vim.keymap.set("n", "<leader>so", ":so ~/.config/nvim/init.lua<CR>:filetype detect<CR>")

-- [C]opy whole [F]ile
vim.keymap.set("n", "<leader>fc", "GVgg\"+y<C-O><C-O>zz")

-- [H]ighlight whole [F]ile
vim.keymap.set("n", "<leader>fh", "GVgg")

------ not versioned currently --------
-- [C]opy highlight to [C]lipboard
vim.keymap.set("v", "<leader>cb", "\"+y")

-- widen pane
vim.keymap.set("n", "<leader>l", "<C-W>10>")

-- thinnen pane
vim.keymap.set("n", "<leader>h", "<C-W>10<")

-- avoid putting when mistyping maps
vim.keymap.set("n", "<leader>p", ":echo 'avoided putting!'<CR>")

-- shift tab unindents in insert mode
vim.keymap.set("i", "<S-Tab>", "<ESC><<a")
-- vim.keymap.set("n", "<S-Tab>", "<<") -- interferes with <C-i>
-- vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")

