local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")
-- local on_attach = require("config.on_attach")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })

  -- autoformat on write
  lsp_zero.buffer_autoformat()
end)

-- setup clang...?
-- lspconfig.clangd.setup{}
lsp_zero.setup_servers({
  "clangd",
})

-- setup biome for javascript
require 'lspconfig'.biome.setup {}

-- setup tsserver for javascript/typescript
require 'lspconfig'.tsserver.setup {}

-- setup lua lsp:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Tell lua about the vim global
          diagnostics = { globals = { 'vim' } },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- setup python LSP pyright
lspconfig.pyright.setup({})
lspconfig.ruff_lsp.setup({})

-- setup go LSP server
-- lspconfig.golangci_lint_ls.setup {}
lspconfig.gopls.setup({})

-- setup C# LSP server
-- requires `dotnet tool install --global csharp-ls`
--
-- dotnet tool install --global csharp-ls --version 0.5.7
lspconfig.csharp_ls.setup({})


-- allow selection with "enter"
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  })
})

-- mappings
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover)
