print("In ftplugin.markdown")
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead", "BufEnter" },
  {
    pattern = { "*.md", "*.markdown" },
    callback = function()
      print("In md callback")
      vim.o.syntax = "markdown"
      vim.g.vim_markdown_conceal = 1
      vim.o.conceallevel = 2
    end

  }
)
vim.cmd [[
augroup filetypedetect
  autocmd!
  " Set .md files to use markdown syntax
  autocmd BufNewFile,BufRead *.md set syntax=markdown
augroup END
]]
print("Leaving ftplugin.markdown")
