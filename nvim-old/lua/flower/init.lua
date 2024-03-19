local packages = {
  "flower.remap",
  "flower.settings",
  "flower.colors",
}

-- Invalidating cache to force resourcing
for _, pac in ipairs(packages) do
  package.loaded[pac] = false
  require(pac)
end
