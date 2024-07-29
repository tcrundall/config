vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.cs",
  callback = function()
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4

    -- My errorformat string for capturing error messages from dotnet build
    -- see :help errorformat
    --
    -- %-ABuild FAILED.,%C%.%#
    --   capture and ignore the line "Build FAILED." and every following line
    --
    -- %f(%l\\,%c): %t%.%# CS%n:%m
    --   Capture an error/warning message
    --   %f -- filename
    --   %l -- line number
    --   %c -- column number
    --   %t -- use first letter of error, warning etc to determine type of message
    --   %.%# -- equivalent to .*, consume remaining letters of error|warning|...
    --   %n -- error number
    --   %m -- error message
    --
    -- %-G%.%#
    --   ignore any other line not matched by earlier messages
    vim.o.errorformat = "%-ABuild FAILED.,%C%.%#,%f(%l\\,%c): %t%.%# CS%n:%m,%-G%.%#"

    vim.keymap.set(
      "n",
      "<leader><leader>b",
      "<cmd>!dotnet build | tee errors.out<cr>",
      { desc = "[B]uild current csharp project" }
    )
    vim.keymap.set("n", "<leader><leader>e", "<cmd>cf errors.out<cr>", { desc = "Open [E]rrors in quickfix list" })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "test*.lua",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader><leader>t",
      "<cmd>w<cr><cmd>lua MiniTest.run()<cr>",
      { desc = "[T]est project with mini test" }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>f",
      "<cmd>w<cr><cmd>lua MiniTest.run_file()<cr>",
      { desc = "Test [F]ile with mini test" }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>c",
      "<cmd>w<cr><cmd>lua MiniTest.run_at_location()<cr>",
      { desc = "Test [C]ursor location with mini test" }
    )
  end,
})
