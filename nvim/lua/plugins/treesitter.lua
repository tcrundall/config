return {
  "nvim-treesitter/nvim-treesitter", -- Note, playground is now deprecated. Use :InspectTree

  opts = {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
      "typescript",
      "javascript",
      "python",
      "c",
      "lua",
      "vim",
      "vimdoc",
      -- "vindoc"  -- lead to issues
      "query",
      "yaml",
      "go",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = true,
    },
  },
  build = ":TSUpdate",

  config = function()
    require("nvim-tree").setup()
    local api = require("nvim-tree.api")

    local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
    parser_config.gotmpl = {
      install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = { "src/parser.c" },
      },
      filetype = "gotmpl",
      used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
    }

    -- project [T]ree [T]oggle
    vim.keymap.set("n", "<leader>tt", api.tree.toggle)

    -- project [T]ree [C]lose
    vim.keymap.set("n", "<leader>tc", api.tree.close)

    -- project [T]ree [O]lose
    vim.keymap.set("n", "<leader>to", api.tree.open)

    -- project [T]ree [F]ocus
    vim.keymap.set("n", "<leader>tf", api.tree.focus)

    -- project [T]ree [L]ocate current buffer
    vim.keymap.set("n", "<leader>tl",
      function()
        print("Changed")
        -- api.tree.find_file({find_file=true, focus=true})
        api.tree.focus({ find_file = true })
        -- api.tree.toggle({ find_file = true, focus = true })
      end
    )

    local telescope_builtin = require('telescope.builtin')
    local telescope_utils = require('telescope.utils')

    -- [G]rep [L]ocal
    -- Do a "local" grep. Either from parent dir of current buf
    -- or from dir under cursor in tree
    vim.keymap.set("n", "<leader>gl",
      function()
        local target_dir

        if api.tree.is_tree_buf() then
          local current_node = api.tree.get_node_under_cursor()
          if current_node.type == "file" then
            current_node = current_node.parent
          end
          target_dir = current_node.absolute_path
          -- print(target_dir)
        else
          target_dir = telescope_utils.buffer_dir()
        end
        -- print("Got target_dir: " .. target_dir)

        telescope_builtin.live_grep({ cwd = target_dir })
      end
    )
  end
}
