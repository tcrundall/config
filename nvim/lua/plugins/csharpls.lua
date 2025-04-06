return {
  "Decodetalkers/csharpls-extended-lsp.nvim",
  dependencies = {
    "razzmatazz/csharp-language-server",
  },
  config = function()
    local config = {
      handlers = {
        ["textDocument/definition"] = require("csharpls_extended").handler,
        ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
      },
      cmd = { "csharp-ls" },
      -- rest of your settings
    }
    require("lspconfig").csharp_ls.setup(config)
    require("csharpls_extended").buf_read_cmd_bind()
  end,
}
