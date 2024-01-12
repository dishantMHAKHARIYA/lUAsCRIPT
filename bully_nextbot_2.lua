---@diagnostic disable: undefined-global

local players = player.GetAll()
local MIN_THRESHOLD_DISTANCE = 300
local teleportPoints = { Vector(-2295.929199, -2795.144531, 256.031250), Vector(-2295.929199, -2795.144531, 256.031250),
  Vector(873.948853, -91.540817, -143.968750) }

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

    obunga:SetPos(farthestPoint)
    obunga:Ignite(10, 1)
  end

  ::return_label::
end

hook.Add("Tick", "CheckObungaDistance", checkObungaDistance)
