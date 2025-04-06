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
    vim.o.errorformat = "%-ABuild FAILED.,%C%.%#,%f(%l\\,%c): %t%.%# %.%#%n:%m,%-G%.%#"

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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.py",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader><leader>p",
      "<cmd>w<cr><cmd>!pyright > pyright.out<cr><cmd>:cfile pyright.out<cr>",
      { desc = "Run [P]yright" }
    )
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.lua",
  callback = function()
    vim.keymap.set("n", "<leader><leader>x", "<cmd>w<cr><cmd>source %<cr>", { desc = "e[X]ecute current lua file" })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.zig",
  callback = function()
    -- My errorformat string for capturing error messages from zig build
    -- see :help errorformat
    --
    -- %-ABuild FAILED.,%C%.%#
    --   capture and ignore the line "Build FAILED." and every following line
    -- %E%f:%l:%c: %m,%Z%m
    --   Capture an error message
    --   %E -- begin multi-line error message
    --   %f -- file name
    --   %l -- line number
    --   %c -- column number
    --   %m -- error message
    --   %+Z -- final line of multi-line message, and (+) include entire line into message
    --
    -- %-A%.%#
    --   %-A -- begin multi line of "Any" type, and (-) ignore it
    --   %.%# -- equivalent to .*, consume remaining letters of error|warning|...
    --
    -- vim.o.errorformat = "%E%f:%l:%c: %m,%Z%m,%-A%.%#"
    vim.o.errorformat = "%E%f:%l:%c: %m,%+Z,%-A%.%#"

    vim.keymap.set("n", "<leader><leader>b", "<cmd>w<cr><cmd>!zig build<cr>", { desc = "[B]uild current zig project" })
    vim.keymap.set("n", "<leader><leader>r", "<cmd>w<cr><cmd>!zig run %<cr>", { desc = "[R]un current zig file" })
    vim.keymap.set("n", "<leader><leader>t", "<cmd>w<cr><cmd>!zig test %<cr>", { desc = "[T]est current zig file" })
    vim.keymap.set(
      "n",
      "<leader><leader>e",
      "<cmd>w<cr><cmd>!zig build 2> errors.out<cr><cmd>cfile errors.out<cr>",
      { desc = "Build and show [E]rrors in current zig project" }
    )
    vim.keymap.set(
      "n",
      "<leader><leader>x",
      "<cmd>w<cr><cmd>!zig run % 2> errors.out<cr><cmd>cfile errors.out<cr>",
      { desc = "e[X]ecute current zig file and show errors" }
    )

    -- useful for ziglings
    vim.keymap.set("n", "c?", "/???<cr>3xi", { desc = "Change next '???'" })
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
