return {
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
  "ixru/nvim-markdown",

  -- {
  --   "jakewvincent/mkdnflow.nvim",
  --   config = function()
  --     require("mkdnflow").setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- },)

  -- -- orgmode
  -- {
  --   "nvim-orgmode/orgmode",
  --   config = function()
  --     require("orgmode").setup_ts_grammar()
  --     require("orgmode").setup {}
  --   end,
  --   dependencies = {
  --     { "hrsh7th/nvim-cmp" },
  --   }
  -- },)

  -- vimwiki for nvim
  {
    "serenevoid/kiwi.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      local kiwi = require("kiwi")
      kiwi.setup({
        {
          name = "personal",
          path = "/Users/tcrundall/Notes"
        }
      })

      -- Necessary keybindings
      vim.keymap.set('n', '<leader>ww', kiwi.open_wiki_index, {})
      vim.keymap.set('n', '<leader>wx', kiwi.todo.toggle, {})
    end
  }
}
