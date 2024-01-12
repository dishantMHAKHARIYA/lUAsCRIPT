SERVER_NAME = "Shervil's GMOD Server"
ALLOWED_PLAYERS = {
    ["Hope"] = "Hope"
}

---@diagnostic disable-next-line: undefined-global
if SERVER then
    print("Hello: ", SERVER_NAME)

    for k, v in pairs(ALLOWED_PLAYERS) do
        print("Allowed Player: " .. k .. " Has val: " .. v)
    end
end

---@diagnostic disable-next-line: undefined-global
if CLIENT then
    print("Hello Client to: ", SERVER_NAME)
end
