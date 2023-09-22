-- set terminals as login shells
vim.opt.shell = "bash -l"


-- point nvim python to one with pynvim installed
vim.g.python3_host_prog = "/Users/tcrundall/Coding/PythonGames/aflsimulator/.venv/bin/python"


-- enable providers
local enabled_providers = {
  "python3_provider"
}

for _, plugin in pairs(enabled_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end


-- set up quickfix map
local quickfix_opts = {noremap=true, silent=true}
local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end

vim.keymap.set("n", "<leader>fq", quickfix, quickfix_opts, "Quick fix")
