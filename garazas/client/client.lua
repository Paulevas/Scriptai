ESX = exports["es_extended"]:getSharedObject()
local playerloaded
local coords = false
local vehicles = {}

function CreateVehicles()
    ESX.TriggerServerCallback('pablito_getvehicles', function(vehiclesData)
        vehicles = vehiclesData
    end)
end

--patikrina, ar automobilis su tam tikru numeriu jau yra žaidime
function CheckIfVehicleExists(plate)
    local vehicles = ESX.Game.GetVehicles()
    for i=1, #vehicles, 1 do
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicles[i])
        if vehicleProps.plate == plate then
            return true
        end
    end
    return false
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        --CreateBlip()
        GetPlayers()
        print("importuojamos transporto priemonės")
    end
end)

function GetPlayers()
    Citizen.Wait(Config.timetospawn * 1000)
    print(GetNumberOfPlayers())
    ESX.ShowNotification('Neperkraukite FiveM, krauname automobilius.')
    Citizen.Wait(1000)
    CreateVehicles()
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(5)
    end
end

Citizen.CreateThread(function()   
    while true do
        Citizen.Wait(Config.savetime * 1000)
        local player = GetPlayerPed(-1) 
        if IsPedInAnyVehicle(player) then
            local car = GetVehiclePedIsUsing(player)
            local properties = ESX.Game.GetVehicleProperties(car)
            local plate = properties["plate"]
            --print("^2 Išsaugota tr. priemonė ^0" .. plate .. "")
            TriggerServerEvent("pablito_parkavimas", plate, properties)
            SetEntityAsMissionEntity(car, true, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        dist = 0
        if dist < 5 then
            if IsControlJustPressed(0, 166) then
                ReturnVehicleMenu()
            end
        end
    end
end)

RegisterCommand('parkuotis', function(source, args)
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)
    if vehicle ~= 0 then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        ESX.TriggerServerCallback('myScript:checkIfVehicleIsOwned', function(isOwned)
            if isOwned then
                local position = GetEntityCoords(vehicle) -- Gauname transporto priemonės poziciją
                local heading = GetEntityHeading(vehicle) -- Gauname transporto priemonės kryptį
                ESX.ShowNotification("Pradedamas automobilio parkavimas. Tai užtruks 5 sekundes. Stovėkite vietoje")
                exports['progressBars']:startUI(5000, "Parkuojama transporto priemonė") -- parkavimo krovimosi pranešimas
                for i = 1, 5 do  -- kiek laiko parkuojasi automobilis (60 tai bus 1 minutė arba 60 sekundžių)
                    Citizen.Wait(1000) -- laukia 1 sekundę
                    if #(position - GetEntityCoords(vehicle)) > 10 then
                        ESX.ShowNotification("Automobilis pajudėjo, parkavimas nutrauktas.")
                        return
                    end
                end
                TriggerServerEvent('myScript:saveVehicle', vehicleProps, position, heading) -- pridėjome position ir heading
                ESX.Game.DeleteVehicle(vehicle)
                ESX.ShowNotification("Jūsų automobilis sėkmingai priparkuotas.")
            else
                ESX.ShowNotification("Jūs negalite parkuoti transporto priemonės, kurios nesate įsigijęs.")
            end
        end, vehicleProps.plate)
    else
        ESX.ShowNotification("Jūs turite būti automobilyje, kad galėtumėte jį parkuoti.")
    end
end)

function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry('FloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function OpenMenuGarage(PointType)
    ESX.UI.Menu.CloseAll()
    local elements = {}

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'droga', {
        title    = ('Automobilių meniu'),
        align    = 'top-right',
        elements = {
            {label = ('Sulaikytas automobilis'), value = 'return_vehicle'},
            }}, function(data, menu)

        if (data.current.value == 'return_vehicle') then
            ReturnVehicleMenu()
        end
            menu.close()
        end, function(data, menu)
            menu.close()
    end)
end

function ReturnVehicleMenu()
    ESX.TriggerServerCallback('pablito_nogarages:getOutVehicles', function(vehicles)
        local elements = {}

        for _, v in pairs(vehicles) do
            local labelvehicle = GetDisplayNameFromVehicleModel(v.vehProps.model) .. ' [' .. v.vehProps.plate .. ']'
            local heading = v.heading -- pridėjome šią eilutę

            table.insert(elements, {
                label = labelvehicle,
                value = v,
                heading = heading -- pridėjome šią eilutę
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_vehicle', {
            title = ('MANO TRANSPORTO PRIEMONĖS'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            --print("Išduodama orientacija: " .. data.current.heading) -- pridėjome šią eilutę
            SpawnPoundedVehicle(data.current.value, data.current.heading)
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end) -- Trūko šio 'end' raktažodžio
end

function SpawnPoundedVehicle(vehicle, heading)
    if vehicle and vehicle.position then -- Patikriname, ar vehicle ir vehicle.position yra ne nil
        local player = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(player)

        -- Patikriname, ar vehicle.position yra JSON eilutė ir išanalizuojame ją, jei reikia
        local vehiclePosition = type(vehicle.position) == 'string' and json.decode(vehicle.position) or vehicle.position
        local vehicleCoords = vector3(vehiclePosition.x, vehiclePosition.y, vehiclePosition.z)

        if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z) <= 10.0 then
            if not CheckIfVehicleExists(vehicle.vehProps.plate) then
                LoadModel(vehicle.vehProps.model)
                exports['progressBars']:startUI(2000, "Išduodamas automobilis")
                Citizen.Wait(2000)
                local car = CreateVehicle(vehicle.vehProps.model, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, heading, true, true)
                ESX.Game.SetVehicleProperties(car, vehicle.vehProps)
                -- TaskWarpPedIntoVehicle(player, car, -1) -- Ši eilutė buvo pašalinta
            else
                ESX.ShowNotification("Šis automobilis jau yra jums išduotas.")
            end
        else
            ESX.ShowNotification("Jūs esate per toli nuo automobilio parkavimo vietos.")
        end
    else
        ESX.ShowNotification("Klaida: negalima rasti transporto priemonės pozicijos.")
    end
end