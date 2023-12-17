-- get custom options, e.g. transparent background
package.loaded["flower.plugin.color"] = false
Color = require("flower.plugin.color")

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use, as)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup(Color.opts)
      vim.cmd.colorscheme("rose-pine")
    end
  }

  use({
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup({
        -- ...
      })

      -- vim.cmd('colorscheme github_light')
    end
  })

  -- use { "catpuccin/nvim", as "catpuccin",
  --   requires = {
  --     { "luarocks-hererocks" }
  --   }
  -- }

  use {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("cmp").setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "nvim_lua" },
        }
      })
    end
  }

  -- setting up snippets
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  })
  use({ "saadparwaiz1/cmp_luasnip" })
  use({ "rafamadriz/friendly-snippets" })

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }

  use "nvim-treesitter/playground"
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use {
    "nvim-telescope/telescope.nvim", tag = "0.1.3",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use "mbbill/undotree"
  use "tpope/vim-fugitive"
  use "theprimeagen/harpoon"
  use "nvim-lua/plenary.nvim"

  -- Smooth transitions between tmux and nvim panes
  use "christoomey/vim-tmux-navigator"

  -- File tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  -- commenting out stuff (gc<motion>)
  use 'tpope/vim-commentary'

  -- Pretty markdown
  --  use {
  --    "lukas-reineke/headlines.nvim",
  --    after = "nvim-treesitter",
  --    config = function()
  --      require("headlines").setup()
  --    end,
  --  }

  -- Pretty markdown! Includes link concealment and other hotkeys
  use 'ixru/nvim-markdown'

  -- use({
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- })

  -- -- orgmode
  -- use({
  --   'nvim-orgmode/orgmode',
  --   config = function()
  --     require('orgmode').setup_ts_grammar()
  --     require('orgmode').setup {}
  --   end,
  --   requires = {
  --     { 'hrsh7th/nvim-cmp' },
  --   }
  -- })

  -- vimwiki for nvim
  use({
    'serenevoid/kiwi.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  })
end)
