---@diagnostic disable: undefined-global

function HandlePlayerSay(sender, text, isTeamChat)
  if isTeamChat == true then
    print(sender:GetName() .. " in the team said: " .. text)
  else
    print(sender:GetName() .. " said: " .. text)
  end
end

hook.Add("PlayerSay", "PlayerSayHook", HandlePlayerSay)