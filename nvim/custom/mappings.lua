local M = {}

M.abc = {
  n = {
    ["<leader>R"] = {":!%:p<CR>", "execute file"}
  }
}
return M
