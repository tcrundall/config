return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",
  dependencies = {
    -- LSP Support
    { "neovim/nvim-lspconfig" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
  },
  config = function()
    local lsp_zero = require('lsp-zero')
    local lspconfig = require("lspconfig")
    -- local on_attach = require("config.on_attach")

    lsp_zero.on_attach(function(_, bufnr)
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
    lspconfig.biome.setup {}

    -- setup tsserver for javascript/typescript
    lspconfig.tsserver.setup {}

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

    -- PYTHON ------------------------------------

    -- work uses black, flake8 and isort...
    -- setup python LSP pyright
    lspconfig.pyright.setup({})
    -- lspconfig.ruff_lsp.setup({})

    ----------------------------------------------


    -- setup go LSP server
    -- lspconfig.golangci_lint_ls.setup {}
    lspconfig.gopls.setup({})

    -- setup C# LSP server
    -- requires `dotnet tool install --global csharp-ls`
    --
    -- dotnet tool install --global csharp-ls --version 0.5.7
    -- note: doesn't have go to type definition
    lspconfig.csharp_ls.setup({})

    -- -- Alternative for C#,
    -- -- Installed by downloading and extracting from [here](https://github.com/OmniSharp/omnisharp-roslyn/releases)
    -- lspconfig.omnisharp.setup({
    --   -- cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },
    --   cmd = { "OmniSharp" },

    --   -- Enables support for reading code style, naming convention and analyzer
    --   -- settings from .editorconfig.
    --   enable_editorconfig_support = true,

    --   -- If true, MSBuild project system will only load projects for files that
    --   -- were opened in the editor. This setting is useful for big C# codebases
    --   -- and allows for faster initialization of code navigation features only
    --   -- for projects that are relevant to code that is being edited. With this
    --   -- setting enabled OmniSharp may load fewer projects and may thus display
    --   -- incomplete reference lists for symbols.
    --   enable_ms_build_load_projects_on_demand = false,

    --   -- Enables support for roslyn analyzers, code fixes and rulesets.
    --   enable_roslyn_analyzers = false,

    --   -- Specifies whether 'using' directives should be grouped and sorted during
    --   -- document formatting.
    --   organize_imports_on_format = false,

    --   -- Enables support for showing unimported types and unimported extension
    --   -- methods in completion lists. When committed, the appropriate using
    --   -- directive will be added at the top of the current file. This option can
    --   -- have a negative impact on initial completion responsiveness,
    --   -- particularly for the first few completion sessions after opening a
    --   -- solution.
    --   enable_import_completion = false,

    --   -- Specifies whether to include preview versions of the .NET SDK when
    --   -- determining which version to use for project loading.
    --   sdk_include_prereleases = true,

    --   -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    --   -- true
    --   analyze_open_documents_only = false,
    -- })


    -- azure pipelines
    -- NOTE: Seems to attach correctly, but doesn't seem to do anything...
    lspconfig.azure_pipelines_ls.setup {
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
              "/azure-pipeline*.y*l",
              "/*.azure*",
              "Azure-Pipelines/**/*.y*l",
              "Pipelines/*.y*l",
            },
          },
        },
      },
    }

    -- bash
    lspconfig.bashls.setup({})


    -- allow selection with "enter"
    local cmp = require('cmp')
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      })
    })
  end
}
