require("flower")
local fun = require("fun.fun")

vim.keymap.set("n", "<leader>f", function() fun.my_func() end)
