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
function SetBackground()
  local highlight_groups = {
    -- Inferred:
    -- Needed for rose-pine but not for tokyonight
    -- Changing this also changes color of fugitive text
    'Normal',
    'NormalNC',

    'NormalFloat',
    -- 'NormalSB', -- Side Bars, e.g. help in TokyoNight

    'Inactive',
    'SignColumnSB',
    'MsgArea',
    'WinBar',
    -- 'WinSeparator',
    'All',

    -- Telescope
    'TelescopeNormal',
    'TelescopeBorder',

    -- which key
    -- 'WhichKeyFloat',

    -- nvim tree
    'NvimTreeNormal',
    'NvimTreeNormalNC',
    'NvimTreeStatusLine',
    'NvimTreeStatusLineNC',
    -- 'NvimTreeWinSeparator',
  }
  for _, hl in pairs(highlight_groups) do
    -- vim.api.nvim_set_hl(0, hl, { bg = 'none', fg = 'none' })
    vim.api.nvim_set_hl(0, hl, { bg = 'none' })
  end
end

function DarkTheme()
  -- vim.cmd.colorscheme 'tokyonight-night'
  vim.cmd.colorscheme 'rose-pine-main'
  SetBackground()
end
function DarkThemeOpaque()
  vim.cmd.colorscheme 'tokyonight-night'
  -- vim.cmd.colorscheme 'rose-pine-main'
end

function LightTheme()
  vim.cmd 'colorscheme tokyonight-day'
end

-- [TH]eme [D]ark
vim.keymap.set('n', '<leader>thd', DarkTheme)
vim.keymap.set('n', '<leader>a', DarkTheme)
vim.keymap.set('n', '<leader>f', DarkThemeOpaque)

-- [TH]eme [L]ight
vim.keymap.set('n', '<leader>thl', LightTheme)

DarkTheme()
