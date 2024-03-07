return {
  "nvim-lualine/lualine.nvim",
  "lewis6991/gitsigns.nvim",
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
    version = "v2.x",
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
  -- Note, playground is now deprecated. Use :InspectTree
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
}
