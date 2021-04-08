-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions
-------------------------------------------------------------------------------------------------------------------

--  Equipment Related
all_gear_slots = {
    'main', 'sub',   'range',     'ammo',
    'head', 'neck',  'left_ear',  'right_ear',
    'body', 'hands', 'left_ring', 'right_ring',
    'back', 'waist', 'legs',      'feet',
}

--  Locks all equipment slots
function equipment_lock_all()
    equipment_lock_specific(all_gear_slots)
end

--  Locks specific equipment slots
--  Accepts an array of strings equivalent to equipment slots
function equipment_lock_specific(gear_array)
    for iterator, slot in ipairs(gear_array) do
        disable(slot)
    end
end

--  Unlocks all equipment slots
function equipment_unlock_all()
    equipment_unlock_specific(all_gear_slots)
end

--  Unlocks specific equipment slots
--  Accepts an array of strings equivalent to equipment slots
function equipment_unlock_specific(gear_array)
    for iterator, slot in ipairs(gear_array) do
        enable(slot)
    end
end