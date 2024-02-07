ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback("minera_hud:getOnlinePlayers", function(source, cb)
    cb({
        online = GetNumPlayerIndices(),
        max = GetConvar("sv_maxclients", 1000)
    })
end)

RegisterCommand("announce", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getGroup() == "projektleitung" then
            if #args == 0 then
                TriggerClientEvent('minera_hud', xPlayer.source, 'error', "INFINTIY-RP SKELBIMAS", 'Turite pateikti pranešimą!', 5000)
            else
                local msg = table.concat(args, ' ')
                TriggerClientEvent('minera_announce', -1, msg, 7500)
            end
        else
            TriggerClientEvent('minera_hud', xPlayer.source, 'error', "INFINTIY-RP SKELBIMAS", 'Jūs neturite teisių naudoti šią komandą.', 5000)
        end
    else
        local msg = table.concat(args, ' ')
        TriggerClientEvent('minera_announce', -1, msg, 7500)
        print("Skelbimas sėkmingai išsiųstas.")
    end
end)

RegisterCommand("id", function(source, args)
    if source ~= 0 then
        TriggerClientEvent("minera_notify", source, "INFINITY-RP SYSTEMA", "Jūsų ID yra: "..source, "success", 5000)
    end
end)