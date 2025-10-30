
local veh_plates = {}

AddEventHandler('entityCreated', function(entity)
  if not DoesEntityExist(entity) or GetEntityType(entity) ~= 2 then
        return
    end
    SetTimeout(2000, function()
    local plate = GetVehicleNumberPlateText(entity)
    if plate then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        veh_plates[netId] = plate
    end
    end)
end)

AddEventHandler('serverEntityCreated', function(entity)
    if not DoesEntityExist(entity) or GetEntityType(entity) ~= 2 then
        return
    end
    SetTimeout(2000, function()
    local plate = GetVehicleNumberPlateText(entity)
    if plate then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        veh_plates[netId] = plate
    end
    end)
end)


AddEventHandler('entityRemoved', function(entity)
    local netId = NetworkGetNetworkIdFromEntity(entity)
    if netId and veh_plates[netId] then
        veh_plates[netId] = nil
    end
end)

local hookId = exports.ox_inventory:registerHook('openInventory', function(data)
    if data.inventoryType == 'glovebox' then
        local plate = veh_plates[data.netId]
        if not plate then return false end
        local cleanId = tostring(data.inventoryId):gsub("^glove", "")
        if tostring(plate) ~= cleanId then
            return false
        end
    end
    if data.inventoryType == 'trunk' then
        local plate = veh_plates[data.netId]
        if not plate then return false end
        local cleanId = tostring(data.inventoryId):gsub("^trunk", "")
        if tostring(plate) ~= cleanId then
            return false
        end
    end
end)
