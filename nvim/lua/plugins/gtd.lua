local notes_dir = vim.fn.expand(vim.env.NOTES_DIR)
local next_actions_file = notes_dir .. "/next-actions.md"

return {
  "tcrundall/gtd.nvim",

  config = function()
    local opts = {
      notes_dir = notes_dir,
      next_actions_file = next_actions_file,
    }
    local gtd = require("gtd")

    gtd.setup(opts)

    vim.keymap.set("n", "<M-t>", "<cmd>GtdToggleTargetAction<cr>", { desc = "Toggle [T]arget Action" })
    vim.keymap.set("n", "<M-c>", "<cmd>GtdToggleCheck<cr>", { desc = "Toggle [C]heck Action" })
    vim.keymap.set(
      "n",
      "<leader>ea",
      "<cmd>vs " .. next_actions_file .. "<cr>",
      { desc = "[E]dit next [A]ctions file" }
    )
  end,
}
