ESX = exports["es_extended"]:getSharedObject()

-- Serverio pusėje
ESX.RegisterServerCallback('myScript:checkIfPlateExists', function(source, cb, plate)
    MySQL.Async.fetchAll('SELECT * FROM parked_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function(result)
        cb(#result > 0)
    end)
end)


ESX.RegisterServerCallback('pablito_getvehicles', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            vehicle.plate = v.plate
            local position = json.decode(v.position)
            local heading = v.heading
            table.insert(vehicles, { position = position, vehProps = vehicle, heading = heading })
        end

        cb(vehicles)
    end)
end)



--[[
function printTable(t)
    for k, v in pairs(t) do
        if type(v) == "table" then
            print(k .. ":")
            printTable(v)
        else
            print(k .. ": " .. tostring(v))
        end
    end
end
]]--

-- naudojimas:
--printTable(myTable)

RegisterServerEvent("pablito_parkavimas")
AddEventHandler("pablito_parkavimas", function(plate, properties, position, heading) -- Pridėjome position ir heading kaip argumentus
    local xPlayer = ESX.GetPlayerFromId(source)

    local pos = position -- Naudojame gautą poziciją
    local plate = plate
    local vehprop = json.encode(properties)

    MySQL.Async.execute("UPDATE owned_vehicles SET position=@position, heading=@heading WHERE plate=@plate", { -- Pridėjome heading į SQL užklausą
        ['@position'] = json.encode(pos), -- Įrašome visą pozicijos vektorių
        ['@heading'] = heading, -- Įrašome kryptį
        ['@plate'] = plate,
    })
    MySQL.Async.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate", {
        ['@vehicle'] = vehprop,
        ['@plate'] = plate,
    })
end)

ESX.RegisterServerCallback('pablito_nogarages:getOutVehicles', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicules = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            vehicle.plate = v.plate -- pridėjome šią eilutę
            local position = json.decode(v.position)
            local heading = v.heading -- pridėjome šią eilutę
            table.insert(vehicules, { position = position, vehProps = vehicle, heading = heading }) -- pridėjome heading
        end

        cb(vehicules)
    end)
end)
ESX.RegisterServerCallback('getvehiclescommand', function(source,cb)

	local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT position FROM owned_vehicles", {}, function(result)
        local pos = {}
        for i = 1, #result, 1 do
            table.insert(pos, { ["position"] = json.decode(result[i]["position"]) })
        end
        cb(pos)
    end)
end)

ESX.RegisterServerCallback('pablito_nogarages:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if(xPlayer.getMoney() >= Config.moneytoretrieve) then
        xPlayer.removeMoney(100)
        cb(true)
    else
        cb(false)
    end
end)


RegisterServerEvent('myScript:saveVehicle')
AddEventHandler('myScript:saveVehicle', function(vehicleProps, position, heading)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local plate = vehicleProps.plate

    MySQL.Async.execute('UPDATE owned_vehicles SET position = @position, heading = @heading, ar_parkuota = 1 WHERE owner = @owner AND plate = @plate', {
        ['@position'] = json.encode(position),
        ['@heading'] = heading,
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(rowsChanged)
        if rowsChanged == 0 then
            print('Tr. priemonė su šiais valst.nr. nerasta: ' .. plate)
        end
    end)
end)


-- Serverio pusėje
RegisterServerEvent('myScript:retrieveVehicle')
AddEventHandler('myScript:retrieveVehicle', function(plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('UPDATE owned_vehicles SET ar_parkuota = 0 WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(rowsChanged)
        if rowsChanged == 0 then
            print('Tr. priemonė su šiais valst.nr. nerasta: ' .. plate)
        end
    end)
end)

ESX.RegisterServerCallback('pablito_getvehicles', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
        for _, v in pairs(data) do
            local vehicle = json.decode(v.vehicle)
            vehicle.plate = v.plate
            local position = json.decode(v.position)
            local heading = v.heading
            table.insert(vehicles, { position = position, vehProps = vehicle, heading = heading })
        end

        cb(vehicles)
    end)
end)

ESX.RegisterServerCallback('myScript:checkIfVehicleIsOwned', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)