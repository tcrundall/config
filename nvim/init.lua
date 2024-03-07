-- disable netrw at the very start to avoid conflict with nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up map before initiating lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dim_inactive_windows = false,
      styles = {
        transparancy = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
    },
    -- config = function()
    --   require("cmp").setup({
    --     sources = {
    --       { name = "nvim_lsp" },
    --       { name = "buffer" },
    --       { name = "path" },
    --       { name = "luasnip" },
    --       { name = "nvim_lua" },
    --     }
    --   })
    -- end
  },

  -- setting up snippets
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v2.0.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!:).
    build = "make install_jsregexp"
  },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  },
  "nvim-treesitter/nvim-treesitter",
  -- {
  -- 	"nvim-treesitter/playground",
  -- 	{ build = ":TSUpdate" },
  -- },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { { "nvim-lua/plenary.nvim" } }
  },
  "mbbill/undotree",
  "tpope/vim-fugitive",
  "theprimeagen/harpoon",
  "nvim-lua/plenary.nvim",

  -- Smooth transitions between tmux and nvim panes
  "christoomey/vim-tmux-navigator",

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup({})
    end
  },

  -- commenting out stuff (gc<motion>)
  'tpope/vim-commentary',

  -- Pretty markdown
  --  {
  --    "lukas-reineke/headlines.nvim",
  --    -- "after" is a packer key. move this plugin to
  --    -- dependencie of nvim-treesitter instead
  --    after = "nvim-treesitter",
  --    config = function()
  --      require("headlines").setup()
  --    end,
  --  },

  -- Pretty markdown! Includes link concealment and other hotkeys
  'ixru/nvim-markdown',

  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- },)

  -- -- orgmode
  -- {
  --   'nvim-orgmode/orgmode',
  --   config = function()
  --     require('orgmode').setup_ts_grammar()
  --     require('orgmode').setup {}
  --   end,
  --   dependencies = {
  --     { 'hrsh7th/nvim-cmp' },
  --   }
  -- },)

  -- vimwiki for nvim
  {
    'serenevoid/kiwi.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  -- for case matching replacement
  { 'tpope/vim-abolish' },
})

-- Set up custom settings and mappings
require("flower")
