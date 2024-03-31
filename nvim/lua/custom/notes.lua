-- Helper functions and mappings for notes in vim

function TOC()
  local target_dir = vim.fn.expand("%:p:h")
  local filenames = vim.fn.readdir(target_dir)

  vim.api.nvim_buf_set_lines(0, 2, -1, false, {})

  local toc_entries = {}
  for _, filename in ipairs(filenames) do
    if filename ~= "_index.md" then
      local short_filename = vim.fn.fnamemodify(filename, ":r")
      local toc_entry = "- [" .. short_filename .. "](./" .. filename .. ")"
      table.insert(toc_entries, toc_entry)
    end
  end

  local toc_start_line = 2
  vim.api.nvim_buf_set_lines(0, toc_start_line, toc_start_line + #toc_entries, false, toc_entries)
end

vim.keymap.set("n", "<leader>tn", TOC, { desc = "[T]able co[N]tents generation" })
