packages = {
    "flower",
    "fun.fun"
}

for _, pac in ipairs(packages) do
    package.loaded[pac] = false
    require(pac)
end

local fun = require("fun.fun")
vim.keymap.set("n", "<leader>f", function() fun.my_func() end)

