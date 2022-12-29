ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Tikozaal = {}
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
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

function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

RegisterNetEvent("Tikoz:alertbalance")
AddEventHandler("Tikoz:alertbalance", function(posped)

    local blip = AddBlipForCoord(posped)
    SetBlipSprite (blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 5.0)
    SetBlipColour (blip, 1)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~r~Trafic de drogue")
    EndTextCommandSetBlipName(blip)
    Wait(10000)
    RemoveBlip(blip)

end)

RegisterNetEvent("Tikoz:animdeal")
AddEventHandler("Tikoz:animdeal", function(pipo, etat)

    if etat == "oui" then
        local ped = PlayerPedId()
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do 
            Wait(0) 
        end
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)

        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do 
            Wait(0) 
        end
        SetBlockingOfNonTemporaryEvents(pipo, true)
        TaskPlayAnim(pipo, "mp_common", "givetake1_a", 8.0, 3.0, 2000, 0, 1, false, false, false)                            

        Wait(2000)
        
        TaskWanderStandard(pipo, 10.0, 10)  

    elseif etat == "non" then
        TaskWanderStandard(pipo, 10.0, 10)  
    end
end)

menusell = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Selldrugs"},
    Data = {currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            for i=1, #listedrugs, 1 do
                if btn.name == listedrugs[i].name then
                    local name = listedrugs[i].name
                    local item = listedrugs[i].item 
                    local prixmin = listedrugs[i].prixmin
                    local prixmax = listedrugs[i].prixmax
                    selldrugs(name, item, prixmin, prixmax)
                end
            end
            
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
            }
        }
    }
}

function selldrugs(name, item, prixmin, prixmax)

    CloseMenu()

    ESX.ShowNotification("Vous êtes à la recherche d'un ~b~client")
    
    RequestAnimDict("cellphone@str_female")

    while not HasAnimDictLoaded("cellphone@str_female") do 
        Wait(0) 
    end
    SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
    TaskPlayAnim(PlayerPedId(), "cellphone@str_female", "cellphone_call_listen_yes_b", 8.0, 3.0, 5000, 0, 1, false, false, false)

    Wait(5000)

    ESX.ShowNotification("Client trouvé !")

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local h = GetEntityHeading(ped)
    local pi = Config.Ped[math.random(1, #Config.Ped)]
    local po = GetHashKey(pi)
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end
    local pipo = CreatePed(6, po, pos.x+math.random(0, 25), pos.y+math.random(0, 25), pos.z, 150.04, true, false)

    TaskPedSlideToCoord(pipo, pos.x, pos.y, pos.z, h/2, 10000)

    CreateThread(function()
    
        while true do 

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local pedpos = GetEntityCoords(pipo)
            local dist = #(pos - pedpos)

            if dist <= 2 then

                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour vendre de la ~b~"..name)
                DrawMarker(6, pos.x, pos.y, pos.z-1, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

                if IsControlJustPressed(1, 51) then    

                    local D1 = math.random(1, 20)
                    local D2 = math.random(1, 20)
                    local D3 = math.random(1, 20)
                    local D4 = math.random(1, 20)
                    local D5 = math.random(1, 20)

                    local balance = D1+D2+D3+D4+D5

                    if balance >= Config.Chance then
                        local posped = GetEntityCoords(PlayerPedId())
                        ESX.ShowNotification("~r~C'est de la caille ton truc, j'me casse !")
                        TriggerServerEvent('Tikoz:AlertPoliceDrugs', posped)
                        TaskWanderStandard(pipo, 10.0, 10)  
                    else
                        local count = math.random(1, 5)
                        TriggerServerEvent("Tikoz:SellVenteDrugs", name, item, prixmin, prixmax, tonumber(count), pipo)
                    end

                    return
                end

            else 
                Wait(1000)
            end

            Wait(0)
        end

    end)
end

RegisterCommand(Config.Command, function()
    menusell.Menu["Menu :"].b = {}
    for i=1, #listedrugs, 1 do 
        table.insert(menusell.Menu["Menu :"].b, { name = listedrugs[i].name, ask = "", askX = true})
    end
     CreateMenu(menusell)
end, false)

