ESX = exports["es_extended"]:getSharedObject()
local playerloaded
local coords = false

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        CreateBlip()
        GetPlayers()
        print("create vehicles")
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    playerLoaded = true
    print("spawn")
    GetPlayers()
    CreateBlip()
end)

function GetPlayers()
    Citizen.Wait(Config.timetospawn * 1000)
    print(GetNumberOfPlayers())
    ESX.ShowNotification('Neperkraukite FiveM, krauname automobilius.')
    Citizen.Wait(1000)
    CreateVehicles()
end

function CreateBlip()
    local Blip = AddBlipForCoord(vector3(494.52, -1334.12, 29.32))
    SetBlipSprite (Blip, 635)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 0.9)
    SetBlipColour (Blip, 46)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Išėmimas")
    EndTextCommandSetBlipName(Blip)
end

function CreateVehicles()
    local player = GetPlayerPed(-1)
    ESX.TriggerServerCallback('guille_getvehicles', function(vehicles)
        local coords = GetEntityCoords(player)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        for i = 1, #vehicles, 1 do
            Citizen.Wait(30)
            local position = vehicles[i]["position"]
            local vehicleProps = vehicles[i]["vehProps"]
            local mod = GetDisplayNameFromVehicleModel(vehicleProps["model"])
            SetEntityCoords(player, position.x, position.y, position.z, 1, 1, 1, 0)
            LoadModel(vehicleProps["model"])
            local vehicle = CreateVehicle(vehicleProps["model"], position.x, position.y, position.z - 0.975, position.heading, true, true)
            Citizen.Wait(1000)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
	    SetEntityAsMissionEntity(vehicle, true, true)
            SetVehicleOnGroundProperly(vehicle)
            print("^2 ¡Tr. priemonė ^0" .. mod .. "^2 užkrauta!")
        end
        SetEntityCoords(player, coords.x, coords.y, coords.z, 1, 1, 1, 0)
        Citizen.Wait(500)
        DoScreenFadeIn(1000)
    end)

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
            print("^2 Išsaugota tr. priemonė ^0" .. plate .. "")
            TriggerServerEvent("guille_storevehicle", plate, properties)
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

RegisterCommand("getvehicles", function()
    ESX.TriggerServerCallback('getvehiclescommand', function(pos)
        for i = 1, #pos, 1 do
            local position = pos[i]["position"]
            print("^2 Nuosavos tr. priemonės: ^4" .. position.x, position.y, position.z .. "")
        end
    end)
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
    ESX.TriggerServerCallback('guille_nogarages:getOutVehicles', function(vehicles)
        local elements = {}

        for _, v in pairs(vehicles) do
            local hashVehicule = v.model
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
            local labelvehicle
            labelvehicle = GetLabelText(vehicleName)

            table.insert(elements, {
                label = labelvehicle,
                value = v
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_vehicle', {
            title = ('Atgauti transporto priemone'),
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            ESX.TriggerServerCallback('guille_nogarages:checkMoney', function(hasEnoughMoney)
                if hasEnoughMoney then
                    SpawnPoundedVehicle(data.current.value)
                    menu.close()
                else
                    ESX.ShowNotification('neužtenk pinigų')
                end
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
end

function SpawnPoundedVehicle(vehicle)
    LoadModel(vehicle.model)
    local car = CreateVehicle(vehicle.model, 489.64, -1333.88, 29.32 - 0.975, 316.84, true, true)
    ESX.Game.SetVehicleProperties(car, vehicle)
    
end
