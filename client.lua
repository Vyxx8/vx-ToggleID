local displayPlayerIDs = false
local renderDistance = 20.0 -- Set the render distance (in meters)

RegisterCommand('toggleids', function()
    displayPlayerIDs = not displayPlayerIDs
end, false)

RegisterKeyMapping('toggleids', 'Toggle Player ID Display', 'keyboard', 'U')

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if displayPlayerIDs then
            local localPed = PlayerPedId()
            local localCoords = GetEntityCoords(localPed)
            local players = GetActivePlayers()
            
            for i = 1, #players do
                local playerPed = GetPlayerPed(players[i])
                local playerCoords = GetEntityCoords(playerPed)
                local distance = Vdist(localCoords.x, localCoords.y, localCoords.z, playerCoords.x, playerCoords.y, playerCoords.z)
                
                if distance <= renderDistance then
                    local playerId = GetPlayerServerId(players[i])
                    DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.0, " " .. playerId)
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.50, 0.50)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0150, 0.015 + factor, 0.03, 41, 11, 41, 68)
end
