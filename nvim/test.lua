local function extract_link_from_string(str, search_start)
  local open_paren_ix, close_paren_ix = nil, nil
  while true do
    close_paren_ix = string.find(str, "%)", search_start)
    print(close_paren_ix)
    if close_paren_ix == nil then
      print("Could not find ')' after cursor position")
      return
    else
      -- print("Found ) at " .. close_paren_ix)
    end
    open_paren_ix = FindLast(str, "%(", close_paren_ix)

    if open_paren_ix == nil then
      print("Could not find matching '(' before column " .. close_paren_ix)
      return
    end

    -- Check no closing parentheses inside
    local extra_close_paren_ix =
      string.find(string.sub(str, open_paren_ix, close_paren_ix - 1), "%)")
    print("extra_close_paren_ix: ", extra_close_paren_ix)
    -- Check open parenthesis preceded by square bracket
    local leading_char = string.sub(str, open_paren_ix - 1, open_paren_ix - 1)
    if extra_close_paren_ix == nil and leading_char == "]" then
      break
    else
      search_start = close_paren_ix + 1
      print("Searching again from: ", search_start)
    end
  end
  return string.sub(str, open_paren_ix + 1, close_paren_ix - 1)
end

local function follow_link()
  local current_line = vim.api.nvim_get_current_line()
  local search_start = vim.api.nvim_win_get_cursor(0)[2]

  local address = extract_link_from_string(current_line, search_start)
  if address == nil then
    return
  end
  -- print("Address: ", address)

  if string.sub(address, 1, 1) == "#" then
    -- markdown header in same file
    local markdown_header = string.sub(address, 2)
    local search_phrase = "^#\\+\\s*" .. Replace(markdown_header, "-", ".*")
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
  elseif string.sub(address, 1, 4) == "http" then
    -- webpage
    address = Replace(address, "#", "\\#")
    vim.fn.execute("!google-chrome " .. address, "silent")
  else
    -- filename
    local relative_link = string.sub(address, 1, 1) == "."
    if relative_link then
      local cwd = vim.fn.expand("%:h")
      address = vim.fn.simplify(cwd .. "/" .. address)
    end
    if vim.uv.fs_stat(address) ~= nil then
      vim.cmd("e " .. address)
    else
      print("File does not seem to exist")
    end
  end
end

vim.api.nvim_create_user_command("FollowLink", function()
  follow_link()
end, {})

vim.api.nvim_set_keymap("n", "gl", "<cmd>FollowLink<cr>", {})
