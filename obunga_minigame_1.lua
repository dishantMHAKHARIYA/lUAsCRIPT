---@diagnostic disable: undefined-global

-- Define the globals here
GameStatus = { WAITING = 0, STARTED = 1 }
PlayerCommand = { Start = "!ostart", End = "!oend" }

-- Define the locals here
local obungaCreated = false
local obunga = nil
local gameStatus = GameStatus.WAITING

local playerReadyMap = {}
for k, v in pairs(player.GetAll()) do
  playerReadyMap[v:GetName()] = false
  print(v:GetName())
end

-- Handle hooks here
function OnEntityCreated(entity)
  if (entity:GetClass() ~= "npc_obunga") then
    return
  end

  if obungaCreated or gameStatus == GameStatus.WAITING then
    entity:Remove()
    return
  end
  obungaCreated = true

  for k, v in pairs(player.GetAll()) do
    v:PrintMessage(HUD_PRINTTALK, "Obunga Time !")
  end
end

function PlayerDeath(victim, inflictor, attacker)
  if obungaCreated and attacker:GetClass() == "npc_obunga" then
    victim:PrintMessage(HUD_PRINTTALK, "Obunga killed you !")
    obunga:Remove()
    obungaCreated = false

    for k, v in pairs(player.GetAll()) do
      if v:GetName() == victim.GetName() then
        goto continue_label
      end

      v:PrintMessage(HUD_PRINTTALK, "Obunga killed: " .. victim:GetName())
      ::continue_label::
    end

    for k, v in pairs(playerReadyMap) do
      playerReadyMap[k] = false
      gameStatus = GameStatus.WAITING
    end
  end
end

function ProcessPlayerMessage(sender, text, isTeamChat)
  if text == PlayerCommand.Start then
    playerReadyMap[sender:GetName()] = true

    for k, v in pairs(playerReadyMap) do
      if v == false then
        return
      end
    end

    if gameStatus == GameStatus.WAITING then
      gameStatus = GameStatus.STARTED
      obunga = ents.Create("npc_obunga")
      obunga:Spawn()
    end
  elseif text == PlayerCommand.End then
    playerReadyMap[sender:GetName()] = false

    for k, v in pairs(playerReadyMap) do
      if v == true then
        return
      end
    end

    if gameStatus == GameStatus.STARTED then
      obunga:Remove()
      gameStatus = GameStatus.WAITING
      obungaCreated = false
    end
  end
end

-- Add hooks here
hook.Add("OnEntityCreated", "OnEntityCreatedHook", OnEntityCreated)
hook.Add("PlayerDeath", "PlayerDeathHook", PlayerDeath)
hook.Add("PlayerSay", "CheckPlayerMessageHook", ProcessPlayerMessage)
