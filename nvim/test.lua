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

vim.api.nvim_create_user_command("FollowLink", function()
  follow_link()
end, {})

vim.api.nvim_set_keymap("n", "gl", "<cmd>FollowLink<cr>", {})
