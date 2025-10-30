
local veh_plates = {}

AddEventHandler('somis-betterevents:vehicleEntered', function(source, vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    veh_plates[source] = "glove" .. plate
end)

AddEventHandler('somis-betterevents:vehicleExit', function(source, vehicle)
    veh_plates[source] = nil
end)

local hookId = exports.ox_inventory:registerHook('openInventory', function(data)
    if data.inventoryType == 'glovebox' then
        local plate = veh_plates[data.source]
        if not plate then return true end
        if tostring(plate) ~= tostring(data.inventoryId) then
            return false
        end
    end
end)