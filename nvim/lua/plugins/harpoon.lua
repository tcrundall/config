return { -- Quckly jump between a subset of files
  "ThePrimeagen/harpoon",
  -- branch = "harpoon2",

  -- Pinning commit due to issue: marks not saved on closing
  -- https://github.com/ThePrimeagen/harpoon/issues/577
  -- Keep an eye on associated PR:
  -- https://github.com/ThePrimeagen/harpoon/pull/557
  commit = "e76cb03",

  dependences = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({ settings = {
      save_on_toggle = true,
      save_on_ui_close = true,
    } })
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<leader><tab>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<M-j>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<M-k>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<M-l>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<M-;>", function()
      harpoon:list():select(4)
    end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<M-S-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<M-S-N>", function()
      harpoon:list():next()
    end)
  end,
}
