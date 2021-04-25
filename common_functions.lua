-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions
-------------------------------------------------------------------------------------------------------------------
--  Equipment Related
all_gear_slots = {
    "main", "sub",   "range",     "ammo",
    "head", "neck",  "left_ear",  "right_ear",
    "body", "hands", "left_ring", "right_ring",
    "back", "waist", "legs",      "feet",
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


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Domain Invation
-------------------------------------------------------------------------------------------------------------------
domain_job = {
    ["WAR"] = "heavy", ["PLD"] = "heavy", ["DRK"] = "heavy", ["BST"] = "heavy", ["SAM"] = "heavy", ["DRG"] = "heavy",
    ["MNK"] = "light", ["THF"] = "light", ["RNG"] = "light", ["NIN"] = "light", ["BLU"] = "light", ["COR"] = "light", ["DNC"] = "light", ["RUN"] = "light",
    ["WHM"] = "mage",  ["BLM"] = "mage",  ["RDM"] = "mage",  ["BRD"] = "mage",  ["SMN"] = "mage",  ["PUP"] = "mage",  ["SCH"] = "mage",  ["GEO"] = "mage",
}

domain_set = {}

domain_set["heavy"] = {
    head  = "Hervor Galea",
    body  = "Hervor Haubert",
    hands = "Hervor Mouffles",
    legs  = "Hervor Brayettes",
    feet  = "Hervor Sollerets",
}

domain_set["light"] = {
    head  = "Heidrek Mask",
    body  = "Heidrek Harness",
    hands = "Heidrek Gloves",
    legs  = "Heidrek Brais",
    feet  = "Heidrek Boots",
}

domain_set["mage"] = {
    head  = "Angantyr Beret",
    body  = "Angantyr Robe",
    hands = "Angantyr Mittens",
    legs  = "Angantyr Tights",
    feet  = "Angantyr Boots",
}

--  Gets the armour set for the job type passed as a parameter
--  Expects the Char(3) string for the job
--  Use example: sets.engeged.Domain = get_domain_set(player.main_job)
function get_domain_set(main_job)
    local job_type = domain_job[main_job]
    return domain_set[job_type]
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Locking Common Items
-------------------------------------------------------------------------------------------------------------------

--  Checks to see if a special ring is equipped in either ring slot.
--  Locks the slot while the ring is in there until it is changed.
--  Definition in: common_lists.lua
function check_special_ring_equipped()
    if equip_lock_rings:contains(player.equipment.left_ring) then
        is_ring_locked = true
        equipment_lock_specific({"left_ring",})
    elseif equip_lock_rings:contains(player.equipment.right_ring) then
        is_ring_locked = true
        equipment_lock_specific({"right_ring",})
    elseif is_ring_locked then
        is_ring_locked = false
        equipment_unlock_specific({"left_ring", "right_ring",})
    end
end

function check_status_cp(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"back",})
    else
        equipment_unlock_specific({"back",})
    end
end

function check_status_dynamis(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"neck",})
    else
        equipment_unlock_specific({"neck",})
    end
end