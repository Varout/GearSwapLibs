-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions
-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Domain Invasion
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
--  Equipment Related
local all_gear_slots = {
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


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Locking Items
-------------------------------------------------------------------------------------------------------------------
--  Check if player has CP Mode enabled
--  Locks in the back piece that is included in the set_to_equip
function check_status_cp(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"back",})
    else
        equipment_unlock_specific({"back",})
    end
end

--  Check if player has Dynamis Mode enabled
--  Locks in the neck piece that is included in the set_to_equip
function check_status_dynamis(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"neck",})
    else
        equipment_unlock_specific({"neck",})
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Ailment Removal
-------------------------------------------------------------------------------------------------------------------
--  Checks if the player is silenced and trying to cast a spell
--  Remove silence using Catholicon, Echo Drops, then Remedy in that order
function check_debuff_silenced(spell, eventArgs)
    if spell.action_type == 'Magic' and buffactive['Silence'] then
        -- If silenced, use what's available to remove it
        cancel_spell()
        if player.inventory['Catholicon'] ~= nil then
            send_command('input /item "Catholicon" <me>')
            send_command('input /echo *!! Silenced ~ Using Catholicon @ '..player.inventory['Catholicon'].count..' Left !!*')
        elseif player.inventory['Echo Drops'] ~= nil then
            send_command('input /item "Echo Drops" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drops @ '..player.inventory['Echo Drops'].count..' Left !!*')
        elseif player.inventory['Remedy'] ~= nil then
            send_command('input /item "Remedy" <me>')
            send_command('input /echo *!! Silenced ~ Using Remedy @ '..player.inventory['Remedy'].count..' Left !!*')
        else
            send_command('input /echo *!! Silenced ~ No items to remove it !!*')
        end

        eventArgs.cancel = true
        return
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Ailment vs Job Ability Activation
-------------------------------------------------------------------------------------------------------------------
--  Checks if the ability being used is Sublimation and if the player is weakened
--  Cancels the action if both conditions are met
function check_weakened_sublimation(spell, eventArgs)
    if spell.name == "Sublimation" and (buffactive['Weakness'] or player.hpp < 55) then
        --  If weakend, don't waste your Sublimation
        cancel_spell()
        send_command('input /echo *!! Weakend ~ Cancelling Sublimation !!*')

        eventArgs.cancel = true
        return
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Raise & Reraise
--  Can beused for custom shortcuts
-------------------------------------------------------------------------------------------------------------------
function cast_highest_available_raise()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local map_ids_raise = {
        ['Raise'] = 12,
        ['Raise II'] = 13,
        ['Raise III'] = 140,
        ['Arise'] = 494
    }

    if spell_recasts[map_ids_raise['Arise']] == 0 and player.main_job == 'WHM' then
        send_command('@input /ma "Arise" <t>')
    elseif spell_recasts[map_ids_raise['Raise III']] == 0 then
        send_command('@input /ma "Raise III" <t>')
    elseif spell_recasts[map_ids_raise['Raise II']] == 0 then
        send_command('@input /ma "Raise II" <t>')
    elseif spell_recasts[map_ids_raise['Raise']] == 0 then
        send_command('@input /ma "Raise" <t>')
    else
        add_to_chat(100, 'No Raise spells currently available.')
    end
end

function cast_highest_available_reraise()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local map_ids_reraise = {
        ['Reraise'] = 135,
        ['Reraise II'] = 141,
        ['Reraise III'] = 142,
        ['Reraise IV'] = 848
    }

    if spell_recasts[map_ids_reraise['Reraise IV']] == 0 and player.main_job == 'WHM' then
        send_command('@input /ma "Reraise IV" <me>')
    elseif spell_recasts[map_ids_reraise['Reraise III']] == 0 then
        send_command('@input /ma "Reraise III" <me>')
    elseif spell_recasts[map_ids_reraise['Reraise II']] == 0 then
        send_command('@input /ma "Reraise II" <me>')
    elseif spell_recasts[map_ids_reraise['Reraise']] == 0 then
        send_command('@input /ma "Reraise" <me>')
    else
        add_to_chat(100, 'No Reraise spells currently available.')
    end
end