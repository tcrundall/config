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

local function replace(s, old, new)
  while true do
    local start, finish = string.find(s, old)
    if start == nil then
      break
    end
    s = string.sub(s, 0, start - 1) .. new .. string.sub(s, finish + 1)
  end
  return s
end

local function follow_link()
  -- Capture everything betwen "(" and ")"
  local current_line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local col_num = cursor_pos[2]
  local start_pos = string.find(current_line, "%(", col_num)
  local end_pos = string.find(current_line, "%)", col_num)

  if start_pos == nil or end_pos == nil then
    return
  end
  local address = string.sub(current_line, start_pos + 1, end_pos - 1)

  if string.sub(address, 1, 1) == "#" then
    -- markdown header in same file
    local markdown_header = string.sub(address, 2)
    local search_phrase = "^#\\+\\s*" .. replace(markdown_header, "-", ".*")
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
  elseif string.sub(address, 1, 4) == "http" then
    -- webpage
    print(string.sub(address, 1, 4))
    vim.fn.execute("!google-chrome " .. address, "silent")
  else
    -- filename
    local relative_link = string.sub(address, 1, 1) == "."
    if relative_link then
      local cwd = vim.fn.expand("%:h")
      address = vim.fn.simplify(cwd .. "/" .. address)
    end
    vim.cmd("e " .. address)
  end
end

vim.api.nvim_create_user_command("FollowLink", function()
  follow_link()
end, { range = false, nargs = 0 })

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
