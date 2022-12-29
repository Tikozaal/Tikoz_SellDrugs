ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Tikoz:SellVenteDrugs")
AddEventHandler("Tikoz:SellVenteDrugs", function(name, item, prixmin, prixmax, count, pipo)
	
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemcount = xPlayer.getInventoryItem(item).count
    local money = math.random(prixmin, prixmax)
    local total = money*count

    if itemcount >= count then
        etat = "oui"
        TriggerClientEvent('esx:showNotification', source, "Vous avez vendu ~b~x"..count.." ~s~de ~b~"..name.."~s~ pour ~r~"..total.."$~s~ !")
        TriggerClientEvent("Tikoz:animdeal", source, pipo, etat)
        xPlayer.addAccountMoney('black_money', total)
        xPlayer.removeInventoryItem(item, count)
    else
        etat = "non"
        TriggerClientEvent("Tikoz:animdeal", source, pipo, etat)
        TriggerClientEvent('esx:showNotification', source, "Vous avez pas assez de ~b~"..name.."~s~ sur vous !")
    end

end)

RegisterNetEvent("Tikoz:AlertPoliceDrugs")
AddEventHandler("Tikoz:AlertPoliceDrugs", function(posped)

	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Centrale LSPD", nil, "Un citoyen a signalé une ~r~transaction de drogue~s~ !", "CHAR_CALL911", 8)
            TriggerClientEvent('Tikoz:alertbalance', xPlayers[i], posped)
        end
	end
end)
