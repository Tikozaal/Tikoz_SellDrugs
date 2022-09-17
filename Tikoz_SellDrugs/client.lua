ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Tikozaal = {}
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

menudrugs = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Drogues"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.slidename == "Weed" and btn.name == "Commencez à vendre" then

                ESX.ShowNotification("Vous êtes à la recherche d'un ~b~client")
                
                RequestAnimDict("cellphone@str_female")

                while not HasAnimDictLoaded("cellphone@str_female") do 
                    Citizen.Wait(0) 
                end
                SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                TaskPlayAnim(PlayerPedId(), "cellphone@str_female", "cellphone_call_listen_yes_b", 8.0, 3.0, 5000, 0, 1, false, false, false)

                Citizen.Wait(5000)

                ESX.ShowNotification("Client trouvé !")

                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local h = GetEntityHeading(ped)
                local pi = Config.Ped[math.random(1, #Config.Ped)]
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Citizen.Wait(0) end
                local pipo = CreatePed(6, po, pos.x+math.random(0, 50), pos.y+math.random(0, 50), pos.z, 150.04, true, false)

                TaskPedSlideToCoord(pipo, pos.x, pos.y, pos.z, h/2, 10000)

                Citizen.CreateThread(function()
                
                    while true do 

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local pedpos = GetEntityCoords(pipo)
                        local dist = #(pos - pedpos)

                        if dist <= 2 then

                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
                            DrawMarker(6, pos.x, pos.y, pos.z-1, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
 
                            if IsControlJustPressed(1, 51) then    

                                local balance = math.random(1, 2)

                                if balance == 1 then
                                    
                                    ESX.ShowNotification("~r~C'est de la caille ton truc, j'me casse !")
                                    TriggerServerEvent('Tikoz:AlertPoliceDrugs')
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                    if ESX.PlayerData.job.name == "police" then
                                        local blip = AddBlipForEntity(pipo)
                                        SetBlipSprite (blip, 1)
                                        SetBlipDisplay(blip, 4)
                                        SetBlipScale(blip, 5.0)
                                        SetBlipColour (blip, 1)
                                        SetBlipAsShortRange(blip, true)

                                        BeginTextCommandSetBlipName("STRING")
                                        AddTextComponentString("~r~Trafic de drogue")
                                        EndTextCommandSetBlipName(blip)

                                        Citizen.Wait(10000)

                                        RemoveBlip(blip)
                                    end
                                else

                                    local count = math.random(1, 5)
                                    local item = "weed_pooch"

                                    TriggerServerEvent("Tikoz:ElChapVenteDrugs", item, tonumber(count))

                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(ped, true)
                                    TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)
                                
                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(pipo, true)
                                    TaskPlayAnim(pipo, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)                            

                                    Citizen.Wait(2000)
                                    
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                end

                                return
                            end

                        else 
                            Citizen.Wait(1000)
                        end

                        Citizen.Wait(0)
                    end

                end)

            elseif btn.slidename == "Coke" and btn.name == "Commencez à vendre" then

                ESX.ShowNotification("Vous êtes à la recherche d'un ~b~client")
                
                RequestAnimDict("cellphone@str_female")

                while not HasAnimDictLoaded("cellphone@str_female") do 
                    Citizen.Wait(0) 
                end
                SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                TaskPlayAnim(PlayerPedId(), "cellphone@str_female", "cellphone_call_listen_yes_b", 8.0, 3.0, 5000, 0, 1, false, false, false)

                Citizen.Wait(5000)

                ESX.ShowNotification("Client trouvé !")

                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local h = GetEntityHeading(ped)
                local pi = Config.Ped[math.random(1, #Config.Ped)]
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Citizen.Wait(0) end
                local pipo = CreatePed(6, po, pos.x+math.random(0, 50), pos.y+math.random(0, 50), pos.z, 150.04, true, false)

                TaskPedSlideToCoord(pipo, pos.x, pos.y, pos.z, h/2, 10000)

                Citizen.CreateThread(function()
                
                    while true do 

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local pedpos = GetEntityCoords(pipo)
                        local dist = #(pos - pedpos)

                        if dist <= 2 then

                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
                            DrawMarker(6, pos.x, pos.y, pos.z-1, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
 
                            if IsControlJustPressed(1, 51) then    

                                local balance = math.random(1, 2)

                                if balance == 1 then
                                    
                                    ESX.ShowNotification("~r~C'est de la caille ton truc, j'me casse !")
                                    TriggerServerEvent('Tikoz:AlertPoliceDrugs')
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                    if ESX.PlayerData.job.name == "police" then
                                        local blip = AddBlipForEntity(pipo)
                                        SetBlipSprite (blip, 1)
                                        SetBlipDisplay(blip, 4)
                                        SetBlipScale(blip, 5.0)
                                        SetBlipColour (blip, 1)
                                        SetBlipAsShortRange(blip, true)

                                        BeginTextCommandSetBlipName("STRING")
                                        AddTextComponentString("~r~Trafic de drogue")
                                        EndTextCommandSetBlipName(blip)

                                        Citizen.Wait(10000)

                                        RemoveBlip(blip)
                                    end
                                else

                                    local count = math.random(1, 5)
                                    local item = "coke_pooch"

                                    TriggerServerEvent("Tikoz:ElChapVenteCoke", item, tonumber(count))

                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(ped, true)
                                    TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)
                                
                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(pipo, true)
                                    TaskPlayAnim(pipo, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)                            

                                    Citizen.Wait(2000)
                                    
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                end

                                return
                            end

                        else 
                            Citizen.Wait(1000)
                        end

                        Citizen.Wait(0)
                    end

                end)

            elseif btn.slidename == "Meth" and btn.name == "Commencez à vendre" then

                ESX.ShowNotification("Vous êtes à la recherche d'un ~b~client")
                
                RequestAnimDict("cellphone@str_female")

                while not HasAnimDictLoaded("cellphone@str_female") do 
                    Citizen.Wait(0) 
                end
                SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                TaskPlayAnim(PlayerPedId(), "cellphone@str_female", "cellphone_call_listen_yes_b", 8.0, 3.0, 5000, 0, 1, false, false, false)

                Citizen.Wait(5000)

                ESX.ShowNotification("Client trouvé !")

                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local h = GetEntityHeading(ped)
                local pi = Config.Ped[math.random(1, #Config.Ped)]
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Citizen.Wait(0) end
                local pipo = CreatePed(6, po, pos.x+math.random(0, 50), pos.y+math.random(0, 50), pos.z, 150.04, true, false)

                TaskPedSlideToCoord(pipo, pos.x, pos.y, pos.z, h/2, 10000)

                Citizen.CreateThread(function()
                
                    while true do 

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local pedpos = GetEntityCoords(pipo)
                        local dist = #(pos - pedpos)

                        if dist <= 2 then

                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
                            DrawMarker(6, pos.x, pos.y, pos.z-1, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
 
                            if IsControlJustPressed(1, 51) then    

                                local balance = math.random(1, 5)

                                if balance == 1 then
                                    
                                    ESX.ShowNotification("~r~C'est de la caille ton truc, j'me casse !")
                                    TriggerServerEvent('Tikoz:AlertPoliceDrugs')
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                    if ESX.PlayerData.job.name == "police" then
                                        local blip = AddBlipForEntity(pipo)
                                        SetBlipSprite (blip, 1)
                                        SetBlipDisplay(blip, 4)
                                        SetBlipScale(blip, 5.0)
                                        SetBlipColour (blip, 1)
                                        SetBlipAsShortRange(blip, true)

                                        BeginTextCommandSetBlipName("STRING")
                                        AddTextComponentString("~r~Trafic de drogue")
                                        EndTextCommandSetBlipName(blip)

                                        Citizen.Wait(10000)

                                        RemoveBlip(blip)
                                    end
                                    

                                else

                                    local count = math.random(1, 5)
                                    local item = "meth_pooch"

                                    TriggerServerEvent("Tikoz:ElChapVenteMeth", item, tonumber(count))

                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(ped, true)
                                    TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)
                                
                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(pipo, true)
                                    TaskPlayAnim(pipo, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)                            

                                    Citizen.Wait(2000)
                                    
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                end

                                return
                            end

                        else 
                            Citizen.Wait(1000)
                        end

                        Citizen.Wait(0)
                    end

                end)

            elseif btn.slidename == "Opium" and btn.name == "Commencez à vendre" then

                ESX.ShowNotification("Vous êtes à la recherche d'un ~b~client")
                
                RequestAnimDict("cellphone@str_female")

                while not HasAnimDictLoaded("cellphone@str_female") do 
                    Citizen.Wait(0) 
                end
                SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
                TaskPlayAnim(PlayerPedId(), "cellphone@str_female", "cellphone_call_listen_yes_b", 8.0, 3.0, 5000, 0, 1, false, false, false)

                Citizen.Wait(5000)

                ESX.ShowNotification("Client trouvé !")

                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local h = GetEntityHeading(ped)
                local pi = Config.Ped[math.random(1, #Config.Ped)]
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Citizen.Wait(0) end
                local pipo = CreatePed(6, po, pos.x+math.random(0, 50), pos.y+math.random(0, 50), pos.z, 150.04, true, false)

                TaskPedSlideToCoord(pipo, pos.x, pos.y, pos.z, h/2, 10000)

                Citizen.CreateThread(function()
                
                    while true do 

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local pedpos = GetEntityCoords(pipo)
                        local dist = #(pos - pedpos)

                        if dist <= 2 then

                            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
                            DrawMarker(6, pos.x, pos.y, pos.z-1, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)
 
                            if IsControlJustPressed(1, 51) then    

                                local balance = math.random(1, 2)

                                if balance == 1 then
                                    
                                    ESX.ShowNotification("~r~C'est de la caille ton truc, j'me casse !")
                                    TriggerServerEvent('Tikoz:AlertPoliceDrugs')
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                    if ESX.PlayerData.job.name == "police" then
                                        local blip = AddBlipForEntity(pipo)
                                        SetBlipSprite (blip, 1)
                                        SetBlipDisplay(blip, 4)
                                        SetBlipScale(blip, 5.0)
                                        SetBlipColour (blip, 1)
                                        SetBlipAsShortRange(blip, true)

                                        BeginTextCommandSetBlipName("STRING")
                                        AddTextComponentString("~r~Trafic de drogue")
                                        EndTextCommandSetBlipName(blip)

                                        Citizen.Wait(10000)

                                        RemoveBlip(blip)
                                    end
                                else

                                    local count = math.random(1, 5)
                                    local item = "opium_pooch"

                                    TriggerServerEvent("Tikoz:ElChapVenteOpium", item, tonumber(count))

                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(ped, true)
                                    TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)
                                
                                    RequestAnimDict("mp_common")
                                    while not HasAnimDictLoaded("mp_common") do 
                                        Citizen.Wait(0) 
                                    end
                                    SetBlockingOfNonTemporaryEvents(pipo, true)
                                    TaskPlayAnim(pipo, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)                            

                                    Citizen.Wait(2000)
                                    
                                    TaskWanderStandard(pipo, 10.0, 10)  

                                end

                                return
                            end

                        else 
                            Citizen.Wait(1000)
                        end

                        Citizen.Wait(0)
                    end

                end)
            end
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Commencez à vendre", slidemax = {"Weed", "Coke", "Meth", "Opium"}},
            }
        }
    }
}

RegisterCommand(Config.Commande, function()

    CreateMenu(menudrugs)

end, false)


