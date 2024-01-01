local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.add_snippets("javascript", {
  s("View", {
    t("<View>"),
    t({ "", "\t" }),
    i(1),
    t({ "", "</View>" }),
  }),

  s("ViewStyle", {
    t("<View style={"),
    i(1),
    t({ "}>", "\t" }),
    i(2),
    t({ "", "</View>" }),
  }),

  s("Text", {
    t("<Text>"),
    i(1),
    t("</Text>"),
  }),

  -- arrow function
  s("arrow", {
    t("const "),
    i(1),
    t(" = ("),
    i(2),
    t({ ") => {", "\t" }),
    i(3),
    t({ "", "};" }),
  }),

  -- TextInput
  s("textinput", {
    t({ "<TextInput", "style={{", "\theight: " }),
    i(1),
    t({ ",", "\tborderColor: '" }),
    i(2),
    t({ "',", "\tborderWidth: " }),
    i(3),
    t({ ",", "}}", "defaultValue=\"" }),
    i(4),
    t({ "\"", "/>" }),
  }),

  -- Return
  s("return", {
    t({ "return (", "\t" }),
    i(1),
    t({ "", ");" }),
  }),

  -- Image
  s("image", {
    t({ "<Image", "\tsource={{", "\t\turi: '" }),
    i(1),
    t({ "',", "\t}}", "style={{width: " }),
    i(2),
    t({ ", height: ", }),
    i(3),
    t({ "}}", "/>" }),
  }),

  -- Button
  s("button", {
    t({ "<Button", "\tonPress={() => {", "\t\t", }),
    i(1),
    t({ ";", "\t}}", "\ttitle=" }),
    i(2),
    t({ "", "/>" }),
  }),

})
