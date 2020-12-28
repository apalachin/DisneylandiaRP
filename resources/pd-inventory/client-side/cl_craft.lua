local _currCraft

Citizen.CreateThread(function()
    while true do
        local idle = 500
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        
        for _,v in pairs(cfg.craftCoordinates) do
            local dist = GetDistanceBetweenCoords(pos, v.coords, true)
            if dist <= 5 and not isInInventory then
                idle = 0
                DrawMarker(23, v.coords.x, v.coords.y, v.coords.z-0.98,0,0,0,0,0,0,0.8,0.8,0.8,0,50,150,50,0,0,0,0)

                if dist <= 1 then
                    if IsControlJustPressed(0, 38) then
                        openCraft(v.type)
                        _currCraft = v.type
                    end
                end
            end
        end

        Citizen.Wait(idle)
    end
end)

RegisterNUICallback("CraftItem", function(data, cb)
    
    if type(data.number) == "number" and math.floor(data.number) == data.number and _currCraft and data.number > 0 then
        TriggerServerEvent("b03461cc:pd-inventory:craftItem", data.data.item, _currCraft, data.number)
    end

    Wait(300)

    updateInventory()
end)

function openCraft(craft)
    local weight,data,_ = vrpServer.getInv(gridZone)
    
    isInInventory = true

    SendNUIMessage({ action = "display", type = "craft" })
    SetNuiFocus(true, true)

    local data2 = vrpServer.loadCraft(craft)

    SendNUIMessage({ action = "setText", text = 'ply-' .. GetPlayerServerId(PlayerId()), weight = weight, max = max })
    SendNUIMessage({ action = "setItems", itemList = data })

    SendNUIMessage({ action = "setSecondText", text = 'craft-' .. craft })
    SendNUIMessage({ action = "setSecondItems", itemSList = data2 })
end