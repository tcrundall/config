local function jump_to_markdown_header(link)
  local markdown_header = string.sub(link, 2)
  local search_phrase = "^#\\+\\s*" .. Replace(markdown_header, "-", ".*")
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
end

local function jump_to_url(link)
  link = Replace(link, "#", "\\#")
  vim.fn.execute("!google-chrome " .. link, "silent")
end

local function jump_to_file(address)
  local relative_link = string.sub(address, 1, 1) == "."

  if relative_link then
    local dir_of_current_file = vim.fn.expand("%:h")
    address = vim.fn.simplify(dir_of_current_file .. "/" .. address)
  end

  if vim.uv.fs_stat(address) ~= nil then
    vim.cmd("e " .. address)
  else
    print("File does not seem to exist")
  end
end

local function is_valid_markdown_link(str, open_paren_ix, close_paren_ix)
  -- a valid link will not contain any parenthesis with in it
  -- and the open parenthesis will be preceded by a closing square bracket
  local extra_close_paren_ix = string.find(string.sub(str, open_paren_ix, close_paren_ix - 1), "%)")
  local leading_char = string.sub(str, open_paren_ix - 1, open_paren_ix - 1)
  return extra_close_paren_ix == nil and leading_char == "]"
end

local function extract_address_from_string(str, search_start)
  local open_paren_ix, close_paren_ix = nil, nil

  while true do
    print("Starting search at ", search_start)
    close_paren_ix = string.find(str, "%)", search_start)
    if close_paren_ix == nil then
      print("Could not find ')' after cursor position")
      return
    else
      print("Closing paren ix: ", close_paren_ix)
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
      print("Searching again from ", search_start)
    end
  end
  return string.sub(str, open_paren_ix + 1, close_paren_ix - 1)
end

local function follow_link()
  local current_line = vim.api.nvim_get_current_line()
  -- Note columns are 0 indexed, but strings are 1 indexed
  local search_start = vim.api.nvim_win_get_cursor(0)[2] + 1

  local address = extract_address_from_string(current_line, search_start)
  if address == nil then
    return
  end
  print("address: ", address)

  if string.sub(address, 1, 1) == "#" then
    jump_to_markdown_header(address)
  elseif string.sub(address, 1, 4) == "http" then
    jump_to_url(address)
  else
    jump_to_file(address)
  end
end

-- Identify line
-- find a - [ ], if found, replace with - [x]
-- find a -, if found, replace with - [ ]
-- find a - [x], if found, replace with -

local function toggle_checkbox()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row_ix = cursor[1]
  print("At row ", row_ix)
  local line = vim.api.nvim_get_current_line()
  local checked_box_pattern = "- %[x%] "
  local checked_box = "- [x] "
  local unchecked_box_pattern = "- %[ %] "
  local unchecked_box = "- [ ] "
  local no_box = "- "
  print("toggling")

  print("Checking line: '", line, "' for ", checked_box_pattern)
  local start_ix, end_ix = line:find(checked_box_pattern)
  print("Start_ix: ", start_ix, "  End_ix: ", end_ix)
  if start_ix ~= nil and end_ix ~= nil then
    print("Found " .. checked_box_pattern)
    line = line:sub(1, start_ix - 1) .. no_box .. line:sub(end_ix + 1)
    print("new line: " .. line)
    vim.api.nvim_buf_set_lines(0, row_ix - 1, row_ix, false, { line })
    return
  end

  print("Checking line: '", line, "' for ", unchecked_box_pattern)
  start_ix, end_ix = line:find(unchecked_box_pattern)
  print("Start_ix: ", start_ix, "  End_ix: ", end_ix)
  if start_ix ~= nil and end_ix ~= nil then
    print("Found " .. unchecked_box_pattern)
    line = line:sub(1, start_ix - 1) .. checked_box .. line:sub(end_ix + 1)
    print("new line: " .. line)
    vim.api.nvim_buf_set_lines(0, row_ix - 1, row_ix, false, { line })
    return
  end

  print("Checking line: '", line, "' for ", no_box)
  start_ix, end_ix = line:find(no_box)
  print("Start_ix: ", start_ix, "  End_ix: ", end_ix)
  if start_ix ~= nil and end_ix ~= nil then
    print("Found " .. no_box)
    line = line:sub(1, start_ix - 1) .. unchecked_box .. line:sub(end_ix + 1)
    print("new line: " .. line)
    vim.api.nvim_buf_set_lines(0, row_ix - 1, row_ix, false, { line })
  end
end

vim.api.nvim_create_user_command("ToggleCheckbox", function()
  toggle_checkbox()
end, {})

vim.api.nvim_set_keymap("n", "<c-s-x>", "<cmd>ToggleCheckbox<cr>", {})
vim.api.nvim_set_keymap("n", "<c-x>", "<cmd>ToggleCheckbox<cr>", {})
