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
  return url
end

local getAdoLink = function(opts)
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
  local url = string.format(
    "%s%s?path=/%s&version=%s&line=%d&lineEnd=%d&lineStartColumn=0&lineEndColumn=1000",
    base_url,
    repo_name,
    filename,
    target,
    opts.line1,
    opts.line2
  )
  vim.fn.setreg("*", url)
  vim.fn.setreg("+", url)
  return url
end

local getFileName = function(opts)
  local filename = vim.fn.expand("%:p:.")
  vim.fn.setreg("*", filename)
  vim.fn.setreg("+", filename)
  P(filename)
  return filename
end

local getFileNameWithAdoLink = function(opts)
  local filename = getFileName(opts)
  local adoLink = getAdoLink(opts)
  local filenameWithAdoLink = string.format("[%s](%s)", filename, adoLink)
  vim.fn.setreg("*", filenameWithAdoLink)
  vim.fn.setreg("+", filenameWithAdoLink)
  P(filenameWithAdoLink)
  return filenameWithAdoLink
end

vim.api.nvim_create_user_command("LinkToGit", function(opts)
  githubLink(opts)
end, { range = true, nargs = "?" })

vim.api.nvim_create_user_command("LinkToAdo", function(opts)
  getAdoLink(opts)
end, { range = true, nargs = "?" })

vim.api.nvim_create_user_command("LinkToFile", function(opts)
  getFileName(opts)
end, { range = false, nargs = 0 })

vim.api.nvim_create_user_command("LinkToFileWithAdoLink", function(opts)
  getFileNameWithAdoLink(opts)
end, { range = true, nargs = "?" })

vim.api.nvim_create_user_command("YamlToJson", "%!yq -o=json", {})

vim.api.nvim_create_user_command("Json", "%!jq .", {})
