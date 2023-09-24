vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.keymap.set("n", "<leader>x", function() vim.cmd(":q") end)
vim.keymap.set("n", "<leader>x", ":q<CR>")

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>")

-- Using plugin
-- vim.keymap.set({"n","i"}, "<c-h>", ":<C-U>TmuxNavigateLeft<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-j>", ":<C-U>TmuxNavigateDown<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-k>", ":<C-U>TmuxNavigateUp<cr>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-l>", ":<C-U>TmuxNavigateRight<cr>", { silent = true })
-- 
-- Custom attempt
-- vim.keymap.set({"n","i"}, "<c-h>", ":! tmux select-pane -L<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-j>", ":! tmux select-pane -D<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-k>", ":! tmux select-pane -U<CR><CR>", { silent = true })
-- vim.keymap.set({"n","i"}, "<c-l>", ":! tmux select-pane -R<CR><CR>", { silent = true })


-- Splitting
vim.keymap.set("n", "<leader>v", ":vs<CR>:wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>h", ":sp<CR>:wincmd j<CR>", { silent = true })
