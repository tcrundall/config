--[[
Configure certain highlight groups to have no background

Every plugin can add their own highlight groups which need
to be overridden.

See :help highlight

You can see all active highlights with
    :so $VIMRUNTIME/syntax/hitest.vim

Can use a plugin to identify all highlight groups:
    'Djancyp/custom-theme.nvim',
    :CustomTheme (open side bar with all themes)
    One can edit theme color, hit "enter" to apply change

See default nvim groups with `:help highlight-groups`
See nvim tree groups with: `:NvimTreeHiTest`

--]]

local highlight_groups = {
  -- Inferred:
  -- Needed for rose-pine but not for tokyonight
  -- Changing this also changes color of fugitive text
  -- 'Normal',
  -- 'NormalNC',

  -- 'NormalFloat',
  -- 'NormalSB', -- Side Bars, e.g. help in TokyoNight

  -- 'Inactive',
  "SignColumnSB",
  "MsgArea",
  -- 'WinBar',
  "WinSeparator",
  -- 'All',

  -- Telescope
  "TelescopeNormal",
  "TelescopeBorder",

  -- which key
  -- 'WhichKeyFloat',

  -- nvim tree
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NvimTreeStatusLine",
  "NvimTreeStatusLineNC",
  -- 'NvimTreeWinSeparator',
}

function SetBackground()
  for _, hl in pairs(highlight_groups) do
    -- vim.api.nvim_set_hl(0, hl, { bg = 'none', fg = 'none' })
    vim.api.nvim_set_hl(0, hl, { bg = "none" })
  end
end

function UnsetBackground()
  for _, hl in pairs(highlight_groups) do
    vim.api.nvim_set_hl(0, hl, { bg = 1 })
  end
end

function DarkTheme()
  require("tokyonight").setup({ transparent = true })
  vim.cmd.colorscheme("tokyonight-night")
  -- SetBackground()
end

function DarkThemeOpaque()
  require("tokyonight").setup({ transparent = false })
  vim.cmd.colorscheme("tokyonight-night")
  -- vim.cmd.colorscheme("rose-pine-main")
end

function LightTheme()
  -- vim.cmd("colorscheme tokyonight-day")
  require("catppuccin").setup({ transparent_background = true })
  vim.cmd("colorscheme catppuccin-latte")
  -- UnsetBackground()
end

function LightThemeOpaque()
  -- vim.cmd("colorscheme tokyonight-day")
  require("catppuccin").setup({ transparent_background = false })
  vim.cmd("colorscheme catppuccin-latte")
  -- UnsetBackground()
end

-- [TH]eme [D]ark
vim.keymap.set("n", "<leader>thd", DarkTheme)

-- [TH]eme [O]paque [D]ark
vim.keymap.set("n", "<leader>thod", DarkThemeOpaque)

-- [TH]eme [L]ight
vim.keymap.set("n", "<leader>thl", LightTheme)

-- [TH]eme [O]paque [L]ight
vim.keymap.set("n", "<leader>thol", LightThemeOpaque)
