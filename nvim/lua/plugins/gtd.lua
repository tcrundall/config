return {
  dir = "~/Coding/GtdPlugin/",
  -- "tcrundall/gtd.nvim",

  config = function()
    local opts = {
      notes_dir = "/Users/tcrundall/Google_Drive/Notes/",
      next_actions_file = "/Users/tcrundall/Google_Drive/Notes/next-actions.md",
    }
    local gtd = require("gtd")
    gtd.setup(opts)

    vim.keymap.set("n", "<M-t>", "<cmd>GtdToggleTargetAction<cr>", { desc = "Toggle [T]arget Action" })
    vim.keymap.set("n", "<M-c>", "<cmd>GtdToggleCheck<cr>", { desc = "Toggle [C]heck Action" })
  end,
}
