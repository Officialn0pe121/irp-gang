local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('irp-gang:notify', function(msg,type)
    QBCore.Functions.Notify(msg,type)
end)

local ServiceJob = function(player)
    local pJob = QBCore.Functions.GetPlayerData().job
    for i = 1, #Config.ServiceJobs, 1 do
        if pJob.onduty and pJob.name == Config.ServiceJobs[i].name and pJob.grade.level >= Config.ServiceJobs[i].grade then
            return true
        else 
            return false
        end
    end
end

RegisterNetEvent('irp-gang:client:OpenStash', function(data)
    local player = PlayerPedId()
    if not data.force then
        TriggerEvent('inventory:client:SetCurrentStash', data.stash)
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.stash, {
            maxweight = data.size,
            slots = data.slots,
        })
    else
        QBCore.Functions.Progressbar(data.stash, 'Forcing Entry..', data.raidtime*1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {
            animDict = 'mini@safe_cracking',
            anim = 'door_open_succeed_stand',
            flags = 49,
        }, {}, {}, function()
            TriggerEvent('inventory:client:SetCurrentStash', data.stash)
            TriggerServerEvent('inventory:server:OpenInventory', 'stash', data.stash, {
                maxweight = data.size,
                slots = data.slots,
            })
            ClearPedTasks(player)
        end, function()
            TriggerEvent('inventory:client:busy:status', false)
            TriggerEvent('irp-gang:notify', "Canceled..", 'error')
            ClearPedTasks(player)
        end)
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Locations.Management) do
        exports['qb-target']:AddCircleZone('gangmanage_'..k, v.coords, v.radius, { 
                name= 'gangmanage_'..k, 
                debugPoly= v.debugPoly, 
                useZ= v.useZ, 
            },{ 
            options = { 
                {
                    event = 'qb-gangmenu:client:OpenMenu',
                    icon = "fa-solid fa-circle",
                    label = 'Open Gang Management',
                    gang = {[k] = v.grade}
                },
            },
            distance = v.distance
        })
    end
    for k, v in pairs(Config.Locations.Stash) do
        exports['qb-target']:AddCircleZone('gangstash_'..k, v.coords, v.radius, { 
                name= 'gangstash_'..k, 
                debugPoly= v.debugPoly, 
                useZ= v.useZ, 
            },{ 
            options = { 
                {
                    event = 'irp-gang:client:OpenStash',
                    icon = "fa-solid fa-circle",
                    label = "Open Stash",
                    gang = {[k] = v.grade}
                },
                {
                    event = 'irp-gang:client:OpenStash',
                    icon = "fa-solid fa-circle",
                    label = 'Force Entry',
                    canInteract = function(entity)
                        if ServiceJob() then
                            return true
                        end
                    end,
                    stash = v.label,
                    size = v.size,
                    slots = v.slots,
                    raidtime = v.raidtime,
                    force = true
                },
            },
            distance = v.distance
        })
    end
    for k, v in pairs(Config.Locations.Wardrobe) do
        exports['qb-target']:AddCircleZone('gangwardrobe_'..k, v.coords, v.radius, { 
                name= 'gangwardrobe_'..k, 
                debugPoly= v.debugPoly, 
                useZ= v.useZ, 
            },{ 
            options = { 
                {
                    event = 'qb-clothing:client:openOutfitMenu',
                    icon = "fa-solid fa-circle",
                    label = 'Change Outfit',
                    gang = {[k] = v.grade}
                },
            },
            distance = v.distance
        })
    end
end)