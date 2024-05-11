-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    { "rcarriga/nvim-dap-ui", dependencies = {
      "https://github.com/nvim-neotest/nvim-nio",
    } },
    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",
    -- "NicholasMata/nvim-dap-cs",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dap.set_log_level("TRACE")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "delve",
        "debugpy",
      },
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    ---@diagnostic disable: undefined-field
    vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into TEST" })
    vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: Terminate" })
    vim.keymap.set("n", "<F8>", dap.step_back, { desc = "Debug: Step Back" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })
    ---@diagnostic enable: undefined-field

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

    ---@diagnostic disable: undefined-field
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    ---@diagnostic enable: undefined-field

    -- Install golang specific config
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = "*.go",
      callback = function()
        require("dap-go").setup()
      end,
    })

    -- Install python specific config
    local dap_py = require("dap-python")
    dap_py.setup("~/.virtualenvs/debugpy/bin/python")
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      group = vim.api.nvim_create_augroup("dap-py", {}),
      pattern = "*.py",
      callback = function()
        vim.keymap.set("n", "<leader>dm", function()
          dap_py.test_method({ config = { justMyCode = false } })
        end, { desc = "Debug: python [M]ethod" })
        vim.keymap.set("n", "<leader>dc", function()
          dap_py.test_class({ config = { justMyCode = false } })
        end, { desc = "Debug: python [C]lass" })
      end,
    })

    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    --   pattern = "*.cs",
    --   callback = function()
    --     require("dap-cs").setup()
    --   end,
    -- })

    -- configure for csharp from blog post: https://aaronbos.dev/posts/debugging-csharp-neovim-nvim-dap
    -- dap.adapters.coreclr = {
    --   type = "executable",
    --   command = "/home/crundallt/.local/share/nvim/mason/bin/netcoredbg",
    --   args = { "--interpreter=vscode" },
    -- }
    --
    -- dap.configurations.cs = {
    --   {
    --     type = "coreclr",
    --     name = "launch - netcoredbg",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    --     end,
    --   },
    -- }

    -- -- from reddit post: https://www.reddit.com/r/csharp/comments/15ktebq/debugging_with_netcoredbg_in_neovim/
    -- -- User: Zealousideal-Sale358
    -- dap.adapters.coreclr = {
    --   type = "executable",
    --   command = "netcoredbg",
    --   args = { "--interpreter=vscode" },
    -- }
    --
    -- local function get_root_dir()
    --   return vim.fn.getcwd()
    -- end
    --
    -- local function ls_dir(dir)
    --   P(dir)
    --   return { "example" }
    -- end
    --
    -- dap.configurations.cs = {
    --   {
    --     type = "coreclr",
    --     name = "launch - netcoredbg",
    --     request = "launch",
    --     env = "ASPNETCORE_ENVIRONMENT=Development",
    --     args = {
    --       "/p:EnvironmentName=Development", -- this is a msbuild jk
    --       --  this is set via environment variable ASPNETCORE_ENVIRONMENT=Development
    --       "--urls=http://localhost:5002",
    --       "--environment=Development",
    --     },
    --     program = function()
    --       -- return vim.fn.getcwd() .. "/bin/Debug/net8.0/FlareHotspotServer.dll"
    --       local files = ls_dir(get_root_dir() .. "/bin/Debug/")
    --       if #files == 1 then
    --         local dotnet_dir = get_root_dir() .. "/bin/Debug/" .. files[1]
    --         files = ls_dir(dotnet_dir)
    --         for _, file in ipairs(files) do
    --           if file:match(".*%.dll") then
    --             return dotnet_dir .. "/" .. file
    --           end
    --         end
    --       end
    --       -- return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    --       return vim.fn.input({
    --         prompt = "Path to dll",
    --         default = get_root_dir() .. "/bin/Debug/",
    --       })
    --     end,
    --   },
    -- }

    -- -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
    -- vim.g.dotnet_build_project = function()
    --   local default_path = vim.fn.getcwd() .. "/"
    --   if vim.g["dotnet_last_proj_path"] ~= nil then
    --     default_path = vim.g["dotnet_last_proj_path"]
    --   end
    --   local path = vim.fn.input("Path to your *proj file", default_path, "file")
    --   vim.g["dotnet_last_proj_path"] = path
    --   local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
    --   print("")
    --   print("Cmd to execute: " .. cmd)
    --   local f = os.execute(cmd)
    --   if f == 0 then
    --     print("\nBuild: ✔️ ")
    --   else
    --     print("\nBuild: ❌ (code: " .. f .. ")")
    --   end
    -- end
    --
    -- vim.g.dotnet_get_dll_path = function()
    --   local request = function()
    --     return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
    --   end
    --
    --   if vim.g["dotnet_last_dll_path"] == nil then
    --     vim.g["dotnet_last_dll_path"] = request()
    --   else
    --     if
    --       vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
    --       == 1
    --     then
    --       vim.g["dotnet_last_dll_path"] = request()
    --     end
    --   end
    --
    --   return vim.g["dotnet_last_dll_path"]
    -- end

    local ts_utils = require("nvim-treesitter.ts_utils")

    local UNSET = "UNSET"
    local debug_process_id = ""

    local function get_csharp_method_name()
      local current_node = ts_utils.get_node_at_cursor()
      if not current_node then
        return ""
      end

      local expr = current_node

      while expr do
        if expr:type() == "method_declaration" then
          break
        end
        expr = expr:parent()
      end

      if not expr then
        print("Returning since no function found")
        return ""
      end

      for _, text_line in ipairs(ts_utils.get_node_text(expr)) do
        local pattern = "public.* (%S+)%("
        local res = string.match(text_line, pattern)
        if res then
          return res
        end
      end
      return ""
    end

    vim.api.nvim_create_user_command("GetFunctionName", get_csharp_method_name, {})

    -- assumptions:
    --  * in the test file
    --  * vim cwd = PROJ_PATH
    local function get_test_dll()
      local cwd = vim.fn.getcwd()

      -- Get name of current directory in order to infer .dll filename
      -- TODO: Infer instead from .csproj file
      local final_dir_index = string.find(cwd, "[^/]*$")
      if final_dir_index == nil then
        return nil
      end
      local tail = string.sub(cwd, final_dir_index)
      local dll_file_full_path = cwd .. "/bin/Debug/net8.0/" .. tail .. ".dll"
      return dll_file_full_path
    end

    local function start_debug()
      local debug_pid = "UNSET"
      local method_name = get_csharp_method_name()
      local dll_file_full_path = get_test_dll()
      local command = {
        "dotnet",
        "test",
        "--filter",
        "FullyQualifiedName~" .. method_name,
        dll_file_full_path,
      }
      print(table.concat(command, " "))
      vim.fn.jobstart(command, {
        env = {
          VSTEST_HOST_DEBUG = 1,
        },
        stdout_buffered = false,
        on_stdout = function(_, data_table)
          for _, line in ipairs(data_table) do
            if line and debug_pid == "UNSET" then
              local prefix = "Process Id: "
              print("Line: ", line)
              if string.find(line, prefix) then
                -- debug_pid = string.sub(line, string.len(prefix) + 1, string.len(prefix) + 6)
                local pattern = "(%d+)"
                debug_pid = string.match(line, pattern)
                print("Debug process started with ID: ", debug_pid)
                debug_process_id = debug_pid
              end
            end
          end
        end,
      })
    end

    vim.api.nvim_create_user_command("DebugTestCSharp", function()
      start_debug()
    end, {})

    local cs_config = {
      {
        type = "coreclr",
        name = "attach dynamic - netcoredbg",
        request = "attach",
        processId = function()
          return debug_process_id
        end,
        program = get_test_dll,
      },
    }

    local netcoredbg_cmd = vim.fn.expand("~") .. "/.local/share/nvim/mason/bin/netcoredbg"
    dap.adapters.coreclr = {
      type = "executable",
      command = netcoredbg_cmd,
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = cs_config
  end,
}
