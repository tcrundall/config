local function close_any_floating_window()
  -- Escape if in floating window
  local curr_win = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(curr_win).relative ~= "" then
    vim.api.nvim_win_close(curr_win, true)
    -- vim.print("Closed floating window")
  else
    -- vim.print("Not in floating window")
  end
end

local function jump_to_markdown_header(link)
  local markdown_header = link:sub(2)

  -- remove proprietry "markdown-header-" prefix used by atlassian/bitbucket links
  local markdown_prefix = "markdown%-header%-"
  markdown_header = markdown_header:gsub(markdown_prefix, "")

  -- replace "-" with anything, and allow for anything between digits (as the header 1.2 becomes 12 in links)
  local search_phrase = "^#\\+\\s*" .. markdown_header:gsub("-", ".*"):gsub("(%d)", "%1.*")
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
end

local function jump_to_url(link)
  link = link:gsub("#", "\\#")
  vim.fn.execute("!open " .. link, "silent")
end

local function jump_to_file(address)
  -- extract line information (implies no file can have '#' in name)
  local line_info_ix = address:find("#")
  local line_info = ""
  if line_info_ix then
    line_info = address.sub(address, line_info_ix)
    address = address.sub(address, 1, line_info_ix - 1)
    -- vim.print(address)
    -- vim.print(line_info)
  end

  -- try if relative, with or without leader '.'
  local dir_of_current_file = vim.fn.expand("%:h")
  local relative_address = vim.fn.simplify(dir_of_current_file .. "/" .. address)
  if vim.uv.fs_stat(relative_address) ~= nil then
    address = relative_address
  end

  -- print("Got address: " .. address)

  if vim.startswith(address, "file:///") then
    address = vim.fn.substitute(address, "file:///", "/", "")
    -- replace encoded chars
    address = vim.fn.substitute(address, "%2B", "+", "g")
  end

  -- openable files
  local openable_extensions = { "pdf", "png", "jpg", "jpeg", "xlsx", "doc", "docx" }
  for _, extension in pairs(openable_extensions) do
    if vim.endswith(address, extension) then
      address = address:gsub(" ", "\\ ")
      vim.ui.open(address)
      return
    end
  end

  if vim.uv.fs_stat(address) == nil then
    print("File does not seem to exist")
    print(address)
    return
  end
  print("File does exist: " .. address)

  vim.cmd("e " .. address)
  if line_info ~= "" then
    print("Jumping to line info: " .. line_info)
    if vim.startswith(line_info, "#L") then
      local line_number_as_str = line_info:sub(3)
      vim.api.nvim_input(line_number_as_str .. "gg")
    else
      -- attempt to treat as markdown header
      jump_to_markdown_header(line_info)
    end
  end
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
  -- vim.print("Got: " .. current_line)

  -- Get address from [some text](address)
  -- Note columns are 0 indexed, but strings are 1 indexed
  local search_start = vim.api.nvim_win_get_cursor(0)[2] + 1
  local address = extract_address_from_string(current_line, search_start)
  if address == nil then
    return
  end

  close_any_floating_window()

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
