-- get custom options, e.g. transparent background
package.loaded["flower.plugin.color"] = false
color = require("flower.plugin.color")

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use, as)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use {
        "rose-pine/neovim",
        config = function()
            require("rose-pine").setup(color.opts)
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
    --     -- requires = {
    --     --     {"luarocks-hererocks"}
    --     -- }
    -- }

    use {  
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use "nvim-treesitter/playground"
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.3",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    use "mbbill/undotree"
    use "tpope/vim-fugitive"
    use "theprimeagen/harpoon"
    use "nvim-lua/plenary.nvim"

    -- Personal touches
    use "christoomey/vim-tmux-navigator"
end)
