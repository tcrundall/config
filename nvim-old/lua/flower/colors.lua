function SetBackground()
  local highlight_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",

    "Inactive",
    "WinSeparator",
    "MsgArea",
    "WinBar",
    "All",

    -- new
    "FloatBorder",
    "FloatTitle",
    "TelescopeNormal",
    "TelescopeBorder",
  }
  for _, hl in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, hl, { bg = "none" })
  end
end

function DarkTheme()
  vim.cmd.colorscheme("rose-pine-main")
  SetBackground()
end

function LightTheme()
  vim.cmd("colorscheme rose-pine-dawn")
end

-- [TH]eme [D]ark
vim.keymap.set("n", "<leader>thd", DarkTheme)

-- [TH]eme [L]ight
vim.keymap.set("n", "<leader>thl", LightTheme)

DarkTheme()

----- For reference: -----
-- local highlight_groups = {
--   "ColorColumn",
--   "Conceal",
--   "CurSearch",
--   "Cursor",
--   "lCursor",
--   "CursorIM",
--   "CursorColumn",
--   "CursorLine",
--   "Directory",
--   "DiffAdd",
--   "DiffChange",
--   "DiffDelete",
--   "DiffText",
--   "EndOfBuffer",
--   "TermCursor",
--   "TermCursorNC",
--   "ErrorMsg",
--   "WinSeparator",
--   "Folded",
--   "FoldColumn",
--   "SignColumn",
--   "IncSearch",
--   "Substitute",
--   "LineNr",
--   "LineNrAbove",
--   "LineNrBelow",
--   "CursorLineNr",
--   "CursorLineFold",
--   "CursorLineSign",
--   "MatchParen",
--   "ModeMsg",
--   "MsgArea",
--   "MsgSeparator",
--   "MoreMsg",
--   "NonText",
--   "Normal",
--   "NormalFloat",
--   "FloatBorder",
--   "FloatTitle",
--   "NormalNC",
--   "Pmenu",
--   "PmenuSel",
--   "PmenuKind",
--   "PmenuKindSel",
--   "PmenuExtra",
--   "PmenuExtraSel",
--   "PmenuSbar",
--   "PmenuThumb",
--   "Question",
--   "QuickFixLine",
--   "Search",
--   "SpecialKey",
--   "SpellBad",
--   "SpellCap",
--   "SpellLocal",
--   "SpellRare",
--   "StatusLine",
--   "StatusLineNC",
--   "TabLine",
--   "TabLineFill",
--   "TabLineSel",
--   "Title",
--   "Visual",
--   "VisualNOS",
--   "WarningMsg",
--   "Whitespace",
--   "WildMenu",
--   "WinBar",
--   "WinBarNC",
--   "Menu",
--   "Scrollbar",
--   "Tooltip",
--   "All",
-- }
