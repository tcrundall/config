-- function ColorMyPencils(color)
--     -- available colors:
--     -- * rose-pine
--     -- * rose-pine-main
--     -- * rose-pine-dawn
--     -- * rose-pine-moon
--     -- color = color or "rose-pine"
--     color = "rose-pine"
--     color = "rose-pine-main"
--     vim.cmd.colorscheme(color)
-- 
--     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--     vim.api.nvim_set_hl(0, "Inactive", { bg = "none" })
--     vim.api.nvim_set_hl(0, "All", { bg = "none" })
-- end
-- 
-- -- ColorMyPencils()

function DarkTheme()
    vim.cmd.colorscheme("rose-pine-main")
end

function LightTheme()
    vim.cmd("colorscheme github_light")
end

vim.keymap.set("n", "<leader>td", DarkTheme)
vim.keymap.set("n", "<leader>tl", LightTheme)
