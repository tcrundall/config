return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "vim",
        "vimdoc",
        "python",
        "go",
        "yaml",
        "typescript",
        "javascript",
        "query", -- TODO: Determine what this is for
        "helm",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<m-v>",
          node_incremental = "<m-n>",
          scope_incremental = "<m-s>",
          node_decremental = "<m-m>",
        },
      },
    })

    vim.api.nvim_create_autocmd({ "BufNew" }, {
      callback = function()
        -- :help vim.v, v:foldlevel, foldtext
        -- https://vi.stackexchange.com/questions/43847/how-to-set-the-value-of-foldexpr-to-be-a-lua-function
        _G.get_fold_text = function()
          local line_length = 60
          local n_folded_lines = vim.v.foldend - vim.v.foldstart + 1
          local fold_title = vim.fn.getline(vim.v.foldstart) .. string.rep(" ", line_length)
          local folded_lines_tag = string.format("  + %s lines", n_folded_lines)
          return (
            string.sub(fold_title, 1, line_length - string.len(folded_lines_tag))
            .. folded_lines_tag
          )
        end

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldtext = "v:lua.get_fold_text()"
      end,
    })

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
