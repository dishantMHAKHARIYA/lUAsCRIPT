---@diagnostic disable: undefined-global

local entities = ents.GetAll()

for k, v in pairs(entities) do
  print(v:GetClass())

  if v:IsPlayer() == false or v:GetClass() ~= "gmod_tool" then
    v:Ignite(10, 1)
  end
end