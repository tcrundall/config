-- Generate github link to cursor position
--   Assumptions:
--   * directory name == repository name
--   * hosted on my personal github
--   * we want a permanent link ==> use a commit hash
local githubLink = function(opts)
  local base_url = "https://github.com/tcrundall"
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
  print(url)
  return url
end

local adoLink = function(opts)
  local base_url = os.getenv("DEFAULT_REPO_URL")
  local repo_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  local target
  if opts.args == "commit" then
    -- Get perma link to commit
    target = "GC" .. vim.fn.system("git log -n 1 --pretty='format:%H'")
  else
    -- Link to branch
    target = "GB" .. vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  end

  local filename = vim.fn.expand("%:p:.")
  local url = base_url
    .. repo_name
    .. "?path=/"
    .. filename
    .. "&version="
    .. target
    .. "&line="
    .. opts.line1
    .. "&lineEnd="
    .. opts.line2
    .. "&lineStartColumn=0&lineEndColumn=1000"
  vim.fn.setreg("*", url)
  vim.fn.setreg("+", url)
  print(url)
  return url
end

vim.api.nvim_create_user_command("LinkToGit", function(opts)
  githubLink(opts)
end, { range = true, nargs = "?" })

vim.api.nvim_create_user_command("LinkToAdo", function(opts)
  adoLink(opts)
end, { range = true, nargs = "?" })
