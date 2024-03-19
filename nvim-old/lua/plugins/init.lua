return {
  "christoomey/vim-tmux-navigator",
  "tpope/vim-abolish",
  "tpope/vim-commentary",
  -- "nvim-lua/plenary.nvim",
  {
    "rose-pine/neovim",
    config = function()
      print("Setup rose-pine")
    end,
  },
  { "nvim-lualine/lualine.nvim", opts = {}, },
  { "lewis6991/gitsigns.nvim",   opts = {}, },
  {
    "mbbill/undotree",
    keys = { { "<leader>u", ":UndotreeToggle<cr>", }, },
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      vim.keymap.set("n", "<leader>gh", function()
        vim.cmd("0Gclog")
      end)
    end
  },
  {
    "theprimeagen/harpoon",
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      require("nvim-tree").setup({})
    end
  },

}
