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
  -- { dir = "~/Coding/nvim/stackmap.nvim/", opts = { key = "value" } },
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically TODO: Understand what this does
  "christoomey/vim-tmux-navigator", -- switch between tmux and nvim panes
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- vim.keymap.set("n", "<leader>rt", "<Plug>PlenaryTestFile", { desc = "[R]un [T]est of file" })
      vim.keymap.set("n", "<leader>rt", ":PlenaryBustedFile", { desc = "[R]un [T]est of file" })
    end,
  },

  -- Unfortunately isn't great at syntax highlighting... maybe I can turn it off somehow?
  -- 'ixru/nvim-markdown', -- pretty markdown with link concealment

  -- Help to debug highlight groups?
  -- {
  --   'Djancyp/custom-theme.nvim',
  --   config = function()
  --     require('custom-theme').setup()
  --   end,
  -- },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- Add indentation guides even on blank lines
  { "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Sophisticated undo history
    "mbbill/undotree",
    keys = { { "<leader>u", ":UndotreeToggle<cr>" } },
  },

  { -- Breadcrumb (show containing function/class)
    "LunarVim/breadcrumbs.nvim",
    dependencies = {
      { "SmiteshP/nvim-navic" },
    },
    opts = {},
    config = function()
      require("nvim-navic").setup({
        lsp = {
          auto_attach = true,
        },
      })

      require("breadcrumbs").setup()
    end,
  },

  { -- Quckly jump between a subset of files
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    -- branch = "not-a-barnch",
    dependences = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({ settings = {
        save_on_toggle = true,
        save_on_ui_close = true,
      } })
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader><tab>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<M-j>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<M-k>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<M-l>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<M-;>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<M-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<M-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform can also run multiple formatters sequentially
        python = { "black", "isort" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        go = { "goimports", "gofmt" },
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        -- cs = { "csharpier" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length=120" },
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
            "--multi-line=3",
            "--trailing-comma",
            "--force-grid-wrap",
            "--use-parentheses",
            "--line-width=120",
          },
        },
      },
    },
  },

  { -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local opts = {
        transparent = true,
        styles = {
          sidebars = "none",
        },
      }
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-night")
      -- You can configure highlights by doing something like
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
