-- set terminals as login shells
vim.opt.shell = "bash -l"

-- point nvim python to one with pynvim installed
vim.g.python3_host_prog = "/Users/tcrundall/Coding/PythonGames/afl-simulator/aflsim/bin/python"

-- enable providers
local enabled_providers = {
  "python3_provider"
}

for _, plugin in pairs(enabled_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
