---@diagnostic disable: undefined-global

function HandleReload()
  print("Reload was pressed !")
end

hook.Add("Reload", "HandleReloadHook", HandleReload)