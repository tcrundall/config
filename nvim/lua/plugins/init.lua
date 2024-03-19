-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
-- NOTE: Plugins can also be added by using a table,
-- with the first argument being the link and the following
-- keys can be used to configure plugin behavior/loading/etc.
--
-- Use `opts = {}` to force a plugin to be loaded.
--
--  This is equivalent to:
--    require('Comment').setup({})
return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically TODO: Understand what this does
  'christoomey/vim-tmux-navigator', -- switch between tmux and nvim panes

  -- Unfortunately isn't great at syntax highlighting... maybe I can turn it off somehow?
  -- 'ixru/nvim-markdown', -- pretty markdown with link concealment

  -- Help to debug highlight groups?
  -- {
  --   'Djancyp/custom-theme.nvim',
  --   config = function()
  --     require('custom-theme').setup()
  --   end,
  -- },

  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- Add indentation guides even on blank lines
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  {
    'theprimeagen/harpoon',
    config = function()
      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'

      vim.keymap.set('n', '<leader>a', mark.add_file, { desc = '[A]dd file to harpoon list' })
      vim.keymap.set('n', '<leader><tab>', ui.toggle_quick_menu, { desc = 'Open harpoon list' })
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'black', 'isort' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        cs = { 'csharpier' },
      },
      formatters = {
        black = {
          prepend_args = { '--line-length=120' },
        },
        -- flake is not a built in formatter. I'll need to define my own
        -- flake8 = {
        --   prepend_args = {
        --     '--max-line-length=120',
        --     '--ignore=F405,F403',
        --   },
        -- },
        isort = {
          prepend_args = {
            '--multi-line=3',
            '--trailing-comma',
            '--force-grid-wrap',
            '--use-parentheses',
            '--line-width=120',
          },
        },
      },
    },
  },

  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local opts = {
        transparent = true,
        styles = {
          sidebars = 'none',
        },
      }
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme 'tokyonight-night'
      -- You can configure highlights by doing something like
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },

  require 'kickstart.plugins.debug',
}
