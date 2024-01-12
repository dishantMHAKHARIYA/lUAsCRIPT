---@diagnostic disable: undefined-global

local players = player.GetAll()
local MIN_THRESHOLD_DISTANCE = 300
local teleportPoints = {}
local spawnPoints = ents.FindByClass("info_player_start")
for k, v in pairs(spawnPoints) do
  teleportPoints[k] = v:GetPos()
end

local function checkObungaDistance()
  local obunga = nil
  for k, v in pairs(ents.GetAll()) do
    if v:GetClass() == "npc_obunga" then
      obunga = v
      goto continue_label
    end
  end
  goto return_label

  ::continue_label::
  local player = players[1]

  if player:GetPos():Distance(obunga:GetPos()) < MIN_THRESHOLD_DISTANCE then
    local farthestDistance = 0
    local farthestPoint = nil
    for k, p in pairs(teleportPoints) do
      local distance = obunga:GetPos():Distance(p)
      if farthestDistance < distance then
        farthestPoint = p
        farthestDistance = distance
      end
    end

    player:SetPos(farthestPoint)
  end

  ::return_label::
end

hook.Add("Tick", "CheckObungaDistance", checkObungaDistance)
