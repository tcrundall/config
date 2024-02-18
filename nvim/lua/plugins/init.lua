print("In plugins/init.lua")
return {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
		end
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()
		end
		
	},
}

-- return {
-- 	{ "nvim-tree/nvim-tree.lua" },
-- 	{ "rose-pine/neovim", name = "rose-pine" },
-- 	"folke/which-key.nvim",
-- 	{
-- 		"ThePrimeagen/harpoon",
-- 		branch = "harpoon2",
-- 		dependencies = { "nvim-lua/plenary.nvim" }
-- 	},
-- 	-- { "nvim-tree/nvim-tree.lua", config = function require("nvim-tree").setup() end  },
-- 	"nvim-treesitter/nvim-treesitter",
-- 	"nvim-treesitter/playground",
-- 	-- { "nvim-telescope/telescope.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } },
-- 	{
-- 		"nvim-telescope/telescope.nvim",
-- 		keys = {
-- 			-- add a keymap to browse plugin files
-- 			-- stylua: ignore
-- 			{
-- 				"<leader>fp",
-- 				function() require("telescope.builtin").find_files() end,
-- 				desc = "Find File in Project",
-- 			},
-- 		},
-- 		-- change some options
-- 		opts = {
-- 			defaults = {
-- 				layout_strategy = "horizontal",
-- 				layout_config = { prompt_position = "top" },
-- 				sorting_strategy = "ascending",
-- 				winblend = 0,
-- 			},
-- 		},
-- 	},

-- }
