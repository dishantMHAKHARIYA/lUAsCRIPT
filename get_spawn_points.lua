---@diagnostic disable: undefined-global

local spawnPoints = ents.FindByClass("info_player_start")
for k, v in pairs(spawnPoints) do
  print(v)
  print(v:GetPos())
end
