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
}
