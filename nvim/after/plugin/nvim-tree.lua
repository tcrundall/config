-- local nvimTree = require("nvim-tree")
local api = require("nvim-tree.api")
vim.keymap.set("n", "-", api.tree.open)
vim.keymap.set("n", "<leader>pt", api.tree.toggle)
vim.keymap.set("n", "<leader>tf", api.tree.focus)

local telescope_builtin = require('telescope.builtin')
local telescope_utils = require('telescope.utils')

-- Do a "local" grep. Either from parent dir of current buf
-- or from dir under cursor in tree
vim.keymap.set("n", "<leader>pl",
  function()
    local target_dir

    if api.tree.is_tree_buf() then
      local current_node = api.tree.get_node_under_cursor()
      if current_node.type == "file" then
        current_node = current_node.parent
      end
      target_dir = current_node.absolute_path
      print(target_dir)
    else
      target_dir = telescope_utils.buffer_dir()
    end
    print("Got target_dir: " .. target_dir)

    telescope_builtin.live_grep({ cwd = target_dir })
  end
)
