return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

    vim.keymap.set("n", "<leader>gh", function()
      vim.cmd("0Gclog")
    end, { desc = "[G]it [H]istory of current buffer" })

    vim.keymap.set("n", "<leader>gl", "<cmd>Git log -n 25<cr><c-w><s-l>", { desc = "[G]it [L]og" })
  end,
}
