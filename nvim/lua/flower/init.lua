local packages = {
  "flower.remap",
  "flower.settings",
}

-- Invalidating cache to force resourcing
for _, pac in ipairs(packages) do
  package.loaded[pac] = false
  require(pac)
end
