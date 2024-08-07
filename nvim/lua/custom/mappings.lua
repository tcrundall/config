-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>x", "<cmd>clo<cr>", { desc = "E[X]it current pane" })
vim.keymap.set("n", "<leader>l", "<C-W>10>")
vim.keymap.set("n", "<leader>h", "<C-W>10<")
vim.keymap.set("n", "<leader>j", "<C-W>5+")
vim.keymap.set("n", "<leader>k", "<C-W>5-")

-- Open url under cursor in browser
vim.keymap.set(
  "n",
  "gx",
  [[:silent execute '!google-chrome ' . shellescape(expand('<cfile>'), 1)<CR>]],
  { desc = "[G]o to [X]webpage" }
)

-- Identify links of form [text](link) and follow links of type
-- relative file, absolute file (from "cwd"), url and markdown heading
vim.api.nvim_set_keymap("n", "gl", "<cmd>FollowLink<cr>", { desc = "[G]o to [L]ink" })

-- -- Toggle checkbox
vim.api.nvim_set_keymap("n", "<a-x>", "<cmd>ToggleCheckbox<cr>", {})
vim.api.nvim_set_keymap("i", "<a-x>", "<cmd>ToggleCheckbox<cr>", {})

-- Shift highlighed lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Don't overwrite yank buffer on paste
--   deletes highlight, sending to blackhole register, then puts
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("x", "P", [["_dP]])

-- Quick fix list
vim.keymap.set("n", "<leader>co", ":cprev<cr>", { desc = "[C]see [O]pen quickfix list" })
vim.keymap.set("n", "<leader>cn", ":cnext<cr>", { desc = "[C]see [N]ext" })
vim.keymap.set("n", "<leader>cp", ":cprev<cr>", { desc = "[C]see [P]revious" })

-- Dev helpers

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.lua",
  callback = function()
    vim.keymap.set("n", "<leader><leader>x", "<cmd>w<cr><cmd>source %<cr>", { desc = "e[X]ecute current lua file" })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.zig",
  callback = function()
    vim.keymap.set("n", "<leader><leader>x", "<cmd>w<cr><cmd>!zig run %<cr>", { desc = "e[X]ecute current zig file" })
    vim.keymap.set("n", "<leader><leader>t", "<cmd>w<cr><cmd>!zig test %<cr>", { desc = "[T]est current zig file" })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.go",
  callback = function()
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.keymap.set("n", "<leader><leader>t", "<cmd>w<cr><cmd>!go test %:.<cr>", { desc = "[T]est current go file" })
    vim.keymap.set("n", "<leader><leader>T", "<cmd>w<cr><cmd>!go test ./...<cr>", { desc = "[T]est entire go project" })
  end,
})

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
