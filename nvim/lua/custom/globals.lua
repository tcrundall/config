P = function(arg)
  print(vim.inspect(arg))
end

R = function(package_name)
  print("Reloading " .. package_name)
  package.loaded[package_name] = nil
  return require(package_name)
end
