local initialized = {}

return { -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- "Hoffs/omnisharp-extended-lsp.nvim",
    "tcrundall/omnisharp-extended-lsp.nvim",

    -- Useful status updates for LSP.
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- For debugging LSP
    -- vim.lsp.set_log_level("trace")
    -- if vim.fn.has("nvim-0.5.1") == 1 then
    --   require("vim.lsp.log").set_format_func(vim.inspect)
    -- end

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        -- Print message upon first time through
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if initialized[client.name] ~= true then
          print("Client " .. client.name .. " initialized = " .. tostring(client.initialized))
          initialized[client.name] = true
        end

        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        if client.name == "omnisharp" then
          -- Define custom omnisharp extension mappings
          map("gd", require("omnisharp_extended").lsp_definition, "Ext. [G]oto [D]efinition")
          map("gr", require("omnisharp_extended").lsp_references, "Ext. [G]oto [R]eferences")
          map("gI", require("omnisharp_extended").lsp_implementation, "Ext. [G]oto [I]mplementation")

          -- This is my own function from my fork of omnisharp_extended
          map("<leader>D", require("omnisharp_extended").lsp_type_definition, "Ext. [G]oto [D]efinition")
        end

        -- Omnisharp doesn't always handle decompiled files well, so we don't allow it here
        local decompiled_root = "/$metadata$/"
        if string.find(event.file, decompiled_root) == nil then
          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end
      end,
    })

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP Specification.
    --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      terraformls = {},
      -- clangd = {},
      gopls = {},
      pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- Some languages (like typescript) have entire language plugins that can be useful:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- But for many setups, the LSP (`tsserver`) will work just fine
      tsserver = {},

      -- csharp-ls only available for .NET >8.0
      -- csharp_ls = {
      --   settings = {
      --     cmd = 'dotnet tool csharp-ls',
      --   },
      -- },

      -- See https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/omnisharp.lua
      -- for available options
      omnisharp = {
        settings = {
          cmd = { "OmniSharp" },
          -- Enables support for reading code style, naming convention and analyzer
          -- settings from .editorconfig.
          enable_editorconfig_support = true,

          -- If true, MSBuild project system will only load projects for files that
          -- were opened in the editor. This setting is useful for big C# codebases
          -- and allows for faster initialization of code navigation features only
          -- for projects that are relevant to code that is being edited. With this
          -- setting enabled OmniSharp may load fewer projects and may thus display
          -- incomplete reference lists for symbols.
          enable_ms_build_load_projects_on_demand = false,

          -- Enables support for roslyn analyzers, code fixes and rulesets.
          enable_roslyn_analyzers = false,

          -- Specifies whether 'using' directives should be grouped and sorted during
          -- document formatting.
          organize_imports_on_format = false,

          -- Enables support for showing unimported types and unimported extension
          -- methods in completion lists. When committed, the appropriate using
          -- directive will be added at the top of the current file. This option can
          -- have a negative impact on initial completion responsiveness,
          -- particularly for the first few completion sessions after opening a
          -- solution.
          enable_import_completion = true,

          -- Specifies whether to include preview versions of the .NET SDK when
          -- determining which version to use for project loading.
          sdk_include_prereleases = true,

          -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
          -- true
          analyze_open_documents_only = false,
        },
      },

      azure_pipelines_ls = {
        root_dir = require("lspconfig.util").find_git_ancestor,
        settings = {
          yaml = {
            schemas = {
              -- [vim.fn.expand '~' .. '/.config/azure_piplines_lsp/service-schema.json'] = '*.yaml',
              -- ['service-schema.json'] = {
              --   '/azure-pipeline*.y*l',
              --   '/*.azure*',
              --   'Azure-Pipelines/**/*.y*l',
              --   'Pipelines/*.y*l',
              --   'templates/*.y*l',
              --   '**/*.y*l',
              --   '*.yaml',
              -- },
            },
          },
        },
      },

      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
      --         ['../path/relative/to/file.yml'] = '/.github/workflows/*',
      --         -- ['/templates'] = '/.github/workflows/*',
      --         ['/templates'] = '**/*.yaml',
      --       },
      --     },
      --   },
      -- },

      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    }

    -- Ensure the servers and tools above are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu
    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format lua code
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
