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

--  Check if player has CP Mode enabled
--  Locks back piece for extra capacity points
function check_status_cp(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"back",})
    else
        equipment_unlock_specific({"back",})
    end
end

--  Check if player has Dynamis Mode enabled
--  Locks neck piece for kills to count
function check_status_dynamis(statusOn, set_to_equip)
    if statusOn then
        equip(set_to_equip)
        equipment_lock_specific({"neck",})
    else
        equipment_unlock_specific({"neck",})
    end
end


function check_ammo_pouch_equipped()
    if equip_lock_ammo_pouches:contains(player.equipment.waist) then
        equipment_lock_specific({'waist',})
        is_waist_locked = true
    elseif is_waist_locked then
        equipment_unlock_specific({'waist',})
    end
end

-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Ailment Removal
-------------------------------------------------------------------------------------------------------------------
--  Checks if the player is silenced and trying to cast a spell
--  Remove silence using Echo Drops, Catholicon, then Remedy in that order
function check_debuff_silenced(spell, eventArgs)
    -- add_to_chat(060, spell.type .. ' | ' .. spell.action_type)
    if spell.action_type == 'Magic' and buffactive['Silence'] then
        -- If silenced, use what's available to remove it
        cancel_spell()
        if player.inventory['Echo Drops'] ~= nil then
            send_command('input /item "Echo Drops" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drops @ '..player.inventory['Echo Drops'].count..' Left !!*')
        elseif player.inventory['Catholicon'] ~= nil then
            send_command('input /item "Catholicon" <me>')
            send_command('input /echo *!! Silenced ~ Using Catholicon @ '..player.inventory['Catholicon'].count..' Left !!*')
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

-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Utsusemi Recast
-------------------------------------------------------------------------------------------------------------------
function check_utsusemi_images()
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')

            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Setting Haste Groups
-------------------------------------------------------------------------------------------------------------------
function determine_haste_group()
    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5%/10%
    -- Victory March +0/+3/+4/+5    9.4%/14%/15.6%/17.1%
    -- Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14%
    -- Embrava - 30%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 40%

    classes.CustomMeleeGroups:clear()

    if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604])) then
            --add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            --add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            --add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            --add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) then
            --add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            --add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            --add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            --add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Refine Waltz
-------------------------------------------------------------------------------------------------------------------
function refine_waltz(spell, action)
    local accepted_waltz = S{'Curing Waltz', 'Curing Waltz II', 'Curing Waltz III'}
    if not accepted_waltz:contains(spell.name) then
        return
    end

    local newWaltz = spell.english
    local waltzID
    local missingHP

    if spell.target.type == "SELF" then
        missingHP = player.max_hp - player.hp
    elseif spell.target.isallymember then
        local target = find_player_in_alliance(spell.target.name)
        local est_max_hp = target.hp / (target.hpp/100)
        missingHP = math.floor(est_max_hp - target.hp)
    end

    if missingHP ~= nil then
        if missingHP < 40 and spell.target.name == player.name then
            add_to_chat(123,'Full HP!')
            cancel_spell()
            return
        elseif missingHP < 150 then
            newWaltz = 'Curing Waltz'
            waltzID = 190
        elseif missingHP < 300 then
            newWaltz = 'Curing Waltz II'
            waltzID = 191
        else
            newWaltz = 'Curing Waltz III'
            waltzID = 192
        end
    end

    local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50, ['Curing Waltz IV'] = 65, ['Curing Waltz V'] = 80}
    local tpCost = waltzTPCost[newWaltz]

    local downgrade

    if player.tp < tpCost and not buffactive.trance then

        if player.tp < 20 then
            add_to_chat(123, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
            cancel_spell()
            return
        elseif player.tp < 35 then
            newWaltz = 'Curing Waltz'
        elseif player.tp < 50 then
            newWaltz = 'Curing Waltz II'
        elseif player.tp < 65 then
            newWaltz = 'Curing Waltz III'
        elseif player.tp < 80 then
            newWaltz = 'Curing Waltz IV'
        end

        downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
    end

    if newWaltz ~= spell.english then
        send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
        if downgrade then
            add_to_chat(158, downgrade)
        end
        cancel_spell()
        return
    end

    if missingHP > 0 then
        add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
    end
end

function find_player_in_alliance(name)
    for i,v in ipairs(alliance) do
        for k,p in ipairs(v) do
            if p.name == name then
                return p
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
--  Common Shared Functions - Checking if the element of the spell matches the element of
--                            the day or weather (includes SCH storms)
-------------------------------------------------------------------------------------------------------------------
function check_spell_weather_day_match(spell)
    return spell.element == world.weather_element or spell.element == world.day_element
end

function check_spell_weather_match(spell)
    return spell.element == world.weather_element
end