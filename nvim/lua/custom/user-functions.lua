-- Generate github link to cursor position
--   Assumptions:
--   * directory name == repository name
--   * hosted on my personal github
--   * we want a permanent link ==> use a commit hash
local myfunc = function(opts)
  local base_url = "https://github.com/tcrundall/"
  local repo_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  local target
  if opts.args == "commit" then
    -- Get perma link to commit
    target = vim.fn.system("git log -n 1 --pretty='format:%H'")
  else
    -- Link to branch
    target = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  end

  local filename = vim.fn.expand("%:p:.")
  local url = base_url .. repo_name .. "/blob/" .. target .. "/" .. filename .. "#L" .. opts.line1 .. "-L" .. opts.line2
  vim.fn.setreg("*", url)
  return url
end

vim.api.nvim_create_user_command("LinkToCode", function(opts)
  myfunc(opts)
end, { range = true, nargs = "?" })
