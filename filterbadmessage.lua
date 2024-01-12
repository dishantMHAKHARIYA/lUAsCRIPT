---@diagnostic disable: undefined-global
BAD_WORDS = { SHIT = "shit", WANKER = "wanker" }
BAD_WORD_THRESHOLD = 3
BAD_WORDS_COUNT = {}

function InitialiseAllPlayersData()
  local players = player.GetAll()

  for k, v in pairs(players) do
    print(v:GetName())
    BAD_WORDS_COUNT[v:GetName()] = 0
  end
end

function CheckPlayerMessage(sender, text, isTeamChat)
  if isTeamChat == true then
    return
  end

  for k, v in pairs(BAD_WORDS) do
    if string.find(text, v) ~= nil then
      if BAD_WORDS_COUNT[sender:GetName()] >= BAD_WORD_THRESHOLD then
        print(sender:GetName() .. " said something bad ! Punishing by fire")
        sender:Ignite(10, 1)
        BAD_WORDS_COUNT[sender:GetName()] = 0
      else
        BAD_WORDS_COUNT[sender:GetName()] = BAD_WORDS_COUNT[sender:GetName()] + 1
      end
    end
  end
end

InitialiseAllPlayersData()
hook.Add("PlayerSay", "CheckPlayerMessageHook", CheckPlayerMessage)
