ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Tikoz:ElChapVenteDrugs")
AddEventHandler("Tikoz:ElChapVenteDrugs", function(item, count)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem("weed_pooch").count
    local money = 20*count

    if itemcount >= count then
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..count.." weed~s~ pour ~r~"..money.."$~s~ !")
    
        xPlayer.addAccountMoney('black_money', money)
        xPlayer.removeInventoryItem(item, count)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~weed~s~ sur vous !")
    end

end)

RegisterServerEvent("Tikoz:ElChapVenteCoke")
AddEventHandler("Tikoz:ElChapVenteCoke", function(item, count)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem("coke_pooch").count
    local money = 40*count

    if itemcount >= count then
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..count.." coke~s~ pour ~r~"..money.."$~s~ !")
    
        xPlayer.addAccountMoney('black_money', money)
        xPlayer.removeInventoryItem(item, count)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~coke~s~ sur vous !")
    end

end)

RegisterServerEvent("Tikoz:ElChapVenteMeth")
AddEventHandler("Tikoz:ElChapVenteMeth", function(item, count)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem("meth_pooch").count
    local money = 80*count

    if itemcount >= count then
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..count.." meth~s~ pour ~r~"..money.."$~s~ !")
    
        xPlayer.addAccountMoney('black_money', money)
        xPlayer.removeInventoryItem(item, count)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~meth~s~ sur vous !")
    end

end)

RegisterServerEvent("Tikoz:ElChapVenteOpium")
AddEventHandler("Tikoz:ElChapVenteOpium", function(item, count)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem("opium_pooch").count
    local money = 60*count

    if itemcount >= count then
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..count.." opium~s~ pour ~r~"..money.."$~s~ !")
    
        xPlayer.addAccountMoney('black_money', money)
        xPlayer.removeInventoryItem(item, count)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~opium~s~ sur vous !")
    end

end)

RegisterNetEvent("Tikoz:AlertPoliceDrugs")
AddEventHandler("Tikoz:AlertPoliceDrugs", function()

	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Centrale LSPD", nil, "Un citoyen a signalé une ~r~transaction de drogue~s~ !", "CHAR_CALL911", 8)

        end
	end
end)
