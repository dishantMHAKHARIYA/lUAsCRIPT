---@diagnostic disable: undefined-global
-- This one is intended to be used by only a single person. Spawns you on top of a buidling and then you face an endless hoard of zombies.

local Weapon = { CROSSBOW = "weapon_crossbow", PISTOL = "weapon_pistol", GMOD_TOOL = "gmod_tool", MAGNUM = "weapon_357" }
local Ammo = { [Weapon.MAGNUM] = 5 }
local Command = { START = "!start", END = "!end" }
local GameStatus = { STARTED = 0, ENDED = 1 }
local Xdir = { 0, -1, 1, 0 }
local Ydir = { 1, 0, 0, -1 }

local SPAWN_RADIUS = 400
local SPAWN_POINT = Vector(-2184.205322, -2768.807373, 2848.031250)
local ZOMBIE_CLASS_NAME = "npc_zombie"

local player = player.GetAll()[1]
local score = 0
local gameStatus = GameStatus.ENDED

local function SpawnZombie()
  if #ents.FindByClass(ZOMBIE_CLASS_NAME) > 3 then
    return
  end

  local directionIndex = math.random(4)
  local zombieSpawn = Vector(SPAWN_POINT.x + Xdir[directionIndex] * SPAWN_RADIUS,
    SPAWN_POINT.y + Ydir[directionIndex] * SPAWN_RADIUS, SPAWN_POINT.z)
  local zombie = ents.Create(ZOMBIE_CLASS_NAME)
  zombie:Spawn()
  zombie:SetPos(zombieSpawn)
end

-----------------------------------------

local function CleanupGame()
  if gameStatus == GameStatus.ENDED then
    return
  end

  for k, v in pairs(ents.FindByClass(ZOMBIE_CLASS_NAME)) do
    v:Remove()
  end

  gameStatus = GameStatus.ENDED
end

local function CheckPlayerMessage(player1, text)
  if text == Command.START and gameStatus == GameStatus.ENDED then
    player:SetPos(SPAWN_POINT)
    gameStatus = GameStatus.STARTED

    player:StripWeapons()
    player:StripAmmo()
    player:Give(Weapon.MAGNUM, false)
  end

  if text == Command.END and gameStatus == GameStatus.STARTED then
    CleanupGame()
  end
end

local function CheckNumZombies()
  if gameStatus == GameStatus.ENDED then
    return
  end

  SpawnZombie()
end

local function CheckPlayerPosition ()
  if gameStatus == GameStatus.ENDED then
    return
  end

  if player:GetPos():Distance(SPAWN_POINT) > 1500 then
    player:Kill()
  end
end

local function CheckZombieDeath(entity)
  if entity:GetClass() == ZOMBIE_CLASS_NAME then
    score = score + 1
    player:GiveAmmo(1, Ammo[Weapon.MAGNUM], false)
    print(score)
  end
end

hook.Add("PlayerSay", "CheckPlayerMessageHook", CheckPlayerMessage)
hook.Add("Tick", "CheckNumZombiesHook", CheckNumZombies)
hook.Add("Tick", "CheckPlayerPositionHook", CheckPlayerPosition)
hook.Add("PlayerDeath", "CleanupGame", CleanupGame)
hook.Add("EntityRemoved", "CheckZombieDeath", CheckZombieDeath)
