local function jump_to_markdown_header(link)
  local markdown_header = link:sub(2)
  local search_phrase = "^#\\+\\s*" .. markdown_header:gsub("-", ".*")
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
end

local function jump_to_url(link)
  link = link:gsub("#", "\\#")
  vim.fn.execute("!google-chrome " .. link, "silent")
end

local function jump_to_file(address)
  local relative_link = address:sub(1, 1) == "."

  if relative_link then
    local dir_of_current_file = vim.fn.expand("%:h")
    address = vim.fn.simplify(dir_of_current_file .. "/" .. address)
  end

  -- openable files
  local openable_extensions = { "pdf", "png", "jpg", "jpeg", "xlsx", "doc", "docx" }
  for _, extension in pairs(openable_extensions) do
    if vim.endswith(address, extension) then
      address = address:gsub(" ", "\\ ")
      vim.ui.open(address)
      -- vim.fn.execute("!open " .. address)
      return
    end
  end

  if vim.uv.fs_stat(address) == nil then
    print("File does not seem to exist")
    print(address)
    return
  end

  vim.cmd("e " .. address)
end

local function is_valid_markdown_link(str, open_paren_ix, close_paren_ix)
  -- a valid link will not contain any parenthesis with in it
  -- and the open parenthesis will be preceded by a closing square bracket
  local extra_close_paren_ix = str:sub(open_paren_ix, close_paren_ix - 1):find("%)")
  local leading_char = str:sub(open_paren_ix - 1, open_paren_ix - 1)
  return extra_close_paren_ix == nil and leading_char == "]"
end

local function extract_address_from_string(str, search_start)
  local open_paren_ix, close_paren_ix = nil, nil

  while true do
    close_paren_ix = str:find("%)", search_start)
    if close_paren_ix == nil then
      print("Could not find ')' after cursor position")
      return
    end
    open_paren_ix = FindLast(str, "%(", close_paren_ix)

    if open_paren_ix == nil then
      print("Could not find matching '(' before column " .. close_paren_ix)
      return
    end

    if is_valid_markdown_link(str, open_paren_ix, close_paren_ix) then
      break
    else
      search_start = close_paren_ix + 1
    end
  end
  return str:sub(open_paren_ix + 1, close_paren_ix - 1)
end

local function follow_link()
  local current_line = vim.api.nvim_get_current_line()
  -- Note columns are 0 indexed, but strings are 1 indexed
  local search_start = vim.api.nvim_win_get_cursor(0)[2] + 1

  local address = extract_address_from_string(current_line, search_start)
  if address == nil then
    return
  end

  if vim.startswith(address, "#") then
    jump_to_markdown_header(address)
  elseif vim.startswith(address, "http") then
    jump_to_url(address)
  else
    jump_to_file(address)
  end
end

vim.api.nvim_create_user_command("FollowLink", function()
  follow_link()
end, {})

vim.api.nvim_set_keymap("n", "gl", "<cmd>FollowLink<cr>", {})
