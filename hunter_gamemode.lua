---@diagnostic disable: undefined-global

-- globals
local GameStatus = { WAITING = 0, STARTED = 1 }
local PlayerCommand = { Start = "!start", End = "!end" }

-- locals
local playerList = player.GetAll()
local hunterSpawnPoints = { Vector(-2295.929199, -2795.144531, 256.031250), Vector(-2295.929199, -2795.144531, 256.031250), Vector(873.948853, -91.540817, -143.968750) }

-- util methods
local function isValidCommand(text)
  for k, v in pairs(PlayerCommand) do
    if v == text then
      return true
    end
  end

  return false
end

local function printAllPlayersData()
  for k, player in pairs(playerList) do
    print(player:GetName())
  end
end

-- hook handlers
local function processPlayerMessage(sender, text, isTeamChat)
  if isTeamChat or isValidCommand(text) == false then
    return
  end

  print("Valid Command !")
end

local function processkeyPress(player, key)
  -- If alt key is pressed
  if key == 262144 then
    player:SetPos(hunterSpawnPoints[math.random(#hunterSpawnPoints)])
  end
end

-- hooks
hook.Add("PlayerSay", "ProcessPlayerMessageHook", processPlayerMessage)
hook.Add("KeyPress", "ProcessKeyPress", processkeyPress)

printAllPlayersData()
