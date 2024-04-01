-- Generate github link to cursor position
--   Assumptions:
--   * directory name == repository name
--   * hosted on my personal github
--   * we want a permanent link ==> use a commit hash
local myfunc = function(opts)
  local base_url = "https://github.com/tcrundall/"
  local repo_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  -- local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  local commit = vim.fn.system("git log -n 1 --pretty='format:%H'")
  local filename = vim.fn.expand("%:p:.")
  local url = base_url .. repo_name .. "/blob/" .. commit .. "/" .. filename .. "#L" .. opts.line1 .. "-L" .. opts.line2
  vim.fn.setreg("*", url)
  return url
end

vim.api.nvim_create_user_command("LinkToCode", function(opts)
  myfunc(opts)
end, { range = true })
