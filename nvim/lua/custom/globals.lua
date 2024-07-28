P = function(arg)
  print(vim.inspect(arg))
end

R = function(package_name)
  print("Reloading " .. package_name)
  package.loaded[package_name] = nil
  return require(package_name)
end

function Replace(s, old, new)
  local result = ""
  while true do
    local start, finish = string.find(s, old)
    if start == nil then
      break
    end
    result = result .. string.sub(s, 0, start - 1) .. new
    s = string.sub(s, finish + 1)
  end
  return result .. s
end

function FindLast(s, pattern, end_pos)
  local ix = 0 ---@type integer | nil
  local position = nil
  while ix ~= nil and ix < end_pos do
    ix = string.find(s, pattern, ix)
    if ix == nil or ix > end_pos then
      break
    end
    position = ix
    ix = ix + 1
  end
  return position
end
