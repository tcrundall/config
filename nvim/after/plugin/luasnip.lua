print("Entering plugin.luasnip.lua")

-- Needed for all snippets?
require("luasnip.loaders.from_vscode").lazy_load()

require('luasnip').filetype_extend("javascript", { "javascriptreact" })
require('luasnip').filetype_extend("javascript", { "html" })

print("Leaving plugin.luasnip.lua")
