Config = {}

Config.Locations = {
    Management = {
        ['lostmc'] = {
            grade = 0,
            coords = vector3(973.55, -97.87, 74.87),
            radius = 0.5,
            distance = 1.5,
            useZ = true,
            debugPoly = false,
        }
    },
    Stash = {
        ['lostmc'] = { -- Ensure gang name here matches your shared/gangs.lua
            label = 'Lost MC Stash', -- Label used by inventory
            grade = 0, -- Grade able to view target option
            size = 100000, -- Stash storage size
            slots = 30, -- Stash storage slots
            raidtime = math.random(10,20), -- Time taken for service jobs to raid stash
            coords = vector3(977.2, -104.19, 74.85), -- Coords for circlezone
            radius = 0.5, -- Radius of circlezone
            distance = 1.5, -- Distance zone can be targeted
            useZ = true, -- Use Z coord above to place zone
            debugPoly = true -- Debug zone
        }
    },
    Wardrobe = {
        ['lostmc'] = { -- Ensure gang name here matches your shared/gangs.lua
            grade = 0, -- Grade able to view target option
            coords = vector3(986.98, -92.94, 74.85), -- Coords for circlezone
            radius = 0.5, -- Radius of circlezone
            distance = 1.5, -- Distance zone can be targeted
            useZ = true, -- Use Z coord above to place zone
            debugPoly = true -- Debug zone
        }
    }
}

Config.ServiceJobs = {
    {name = "police", grade = 1},
}