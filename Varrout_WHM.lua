
--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialise the include file(s).
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')

    --  Make sure all equipment can be changed/updated
    equipment_unlock_all()
end

--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()
    --  White mage specific
    state.Buff["Divine Seal"]     = buffactive["Divine Seal"]     or false
    state.Buff["Divine Caress"]   = buffactive["Divine Caress"]   or false
    state.Buff["Afflatus Solace"] = buffactive["Afflatus Solace"] or false
    state.Buff["Afflatus Misery"] = buffactive["Afflatus Misery"] or false

    --  Scholar specific
    state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
    state.Buff["Sublimation: Complete"]  = buffactive["Sublimation: Complete"]  or false

    --  Black Magic Specific
    state.Buff.ElementalSeal = buffactive['Elemental Seal'] or false
end

--  ----------------------------------------------------------------------------------------------------
--
--  ----------------------------------------------------------------------------------------------------
function custom_instructions()
    add_to_chat(200, "Varrout's WHM Custom commands:")
    add_to_chat(200, "* Windows Key + 2: Reraise")
    add_to_chat(200, "* Windows Key + C: Toggle Cursna Single Target/AoE Mode (Default Single Target)")
    -- add_to_chat(200, "* Windows Key + X: Toggle Dynamis Mode (Neck lock)")
    add_to_chat(200, "* Windows Key + M: Show Map")
end

function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    -- state.Dynamis = M(false, "Dynamis Mode")                    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.CursnaSingle = M(true, "Cursna Single Target Mode")   --  If true, Cursna will use Gambanteinn for added potency

    --  Where @ is the Windows Key
    send_command('bind @c gs c toggle CursnaSingle')    --  Windows Key + C: Toggle Cursna Mode
    send_command('bind @m input /map')          --  Windows Key + m: Show map, because I'm lazy af
    -- send_command('bind @x gs c toggle Dynamis') --  Windows Key + x: Toggle Dynamis Mode
    send_command('bind @1 gs c raise')            --  Windows Key + 1: Cast highest available raise
    send_command('bind @2 gs c reraise')            --  Windows Key + 2: Cast highest available reraise

    --  Set up lockstyle set
    -- randomise_lockstyle()

    custom_instructions()
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @m')
    -- send_command('unbind @x')
    send_command('unbind @1')
    send_command('unbind @2')
end

function init_gear_sets()
    include('Varrout_WHM_GearSets.lua')
end

function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)

    -- if spell.name == "Sublimation" and buffactive['Weakness'] then
    --     --  If weakend, don't waste your Sublimation
    --     cancel_spell()
    --     send_command('input /echo *!! Weakend ~ Cancelling Sublimation !!*')
    --     eventArgs.cancel = true
    --     return
    -- elseif spell.name == "Addendum: White" then
    if spell.name == "Addendum: White" then
        --  No need to waste a strategem on this
        cancel_spell()
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    end

    --  I'm not likely to have 4+ images on WHM with /NIN, but leave as is
    -- if spellMap == 'Utsusemi' then
    --     if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
    --         cancel_spell()
    --         add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
    --         eventArgs.handled = true
    --         return
    --     elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
    --         send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
    --     end
    -- end
end

function job_post_midcast(spell, action, spellMap, eventArgs)

    -- if player.tp > player_tp_lock then
    --     melee_equip_lock()
    -- end

    local equipSet = {}

    if spell.action_type == 'Magic' then
        spell_element_match = spell.element == world.weather_element or spell.element == world.day_element
        -- add_to_chat(100, tostring(spellMap))

        if (spell.skill == 'Enfeebling Magic' or spell.skill == 'Divine Magic') then
            if spell.skill == 'Enfeebling Magic' then
                equipSet = sets.midcast['Enfeebling Magic']
            elseif spell.skill == 'Divine Magic' then
                equipSet = sets.midcast['Divine Magic']
            end

            if spell_element_match then
                equipSet = set_combine(equipSet, sets.midcast.WeatherBoost)
            end

        elseif (spell.skill == 'Healing Magic' and not spells_cure:contains(spellMap)) then

            equipSet = sets.midcast.NASpell

            --  If Divine Caress is active
            if state.Buff.DivineCaress then
                equipSet = set_combine(equipSet, sets.midcast.Caress)
            end

            --  Cursna removal gear is most important. Combine last
            if spell.name == 'Cursna' then
                equipSet = sets.midcast.Cursna
                --  By default single target is off
                if state.CursnaSingle.current == 'on' then
                    add_to_chat(200, "Cursna Single Target")
                    equipSet = set_combine(equipSet, sets.CursnaSingle)
                else
                    add_to_chat(200, "Cursna AoE")
                    equipSet = set_combine(equipSet, sets.CursnaAoE)
                end
            end
        elseif spell.name == "Erase" then
            equipSet = sets.midcast['Erase']
        elseif spells_cure:contains(spellMap) then
            if spell_element_match then
                equipSet = sets.midcast.CureBonus
            else
                equipSet = sets.midcast.Cure
            end
        end
    end

    equip(equipSet)

    if spell.type == "Trust" then
        equip(sets.Trust)
    end
end


function customize_idle_set(idleSet)
    idleSet = sets.idle

    -- if state.Debug.current == 'on' then
    --    windower.add_to_chat(9, "Currently in: " .. world.area)
    -- end

    -- if player.tp < player_tp_lock then
    --     melee_equip_unlock()
    -- end
    check_special_ring_equipped()

    -- --  Checking special states
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end

    -- if state.Dynamis.current == 'on' then
    --     equip(sets.JSENeck)
    --     disable('neck')
    -- else
    --     enable('neck')
    -- end

    --  Checking player stats
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  If in an Adoulin zone, equip body piece if available
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    --  Check if sublimation is active
    if state.Buff["Sublimation: Activated"] then
        idleSet = set_combine(idleSet, sets.Sublimation)
    end

    return idleSet
end

function user_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        melee_equip_lock()
    elseif oldStatus == 'Engaged' then
        melee_equip_unlock()
    end
end

--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)
    if state.Buff["Sublimation: Activated"] then
        equip(sets.Sublimation)
    elseif buff == "Sublimation: Activated" and not gain then
        equip(sets.idle)
    end
end


function job_self_command(cmdParams, eventArgs)
    --  Make Reraise easy to handle
    if (cmdParams[1]:lower() == 'reraise') then
        cast_highest_available_reraise()

    --  Make Raise easy to handle
    elseif cmdParams[1]:lower() == 'raise' then
        cast_highest_available_raise()
    end

    eventArgs.handled = true
    return
end

function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
end

--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------

--  Checks to see if a special ring is equipped in either ring slot.
--  Locks the slot while the ring is in there until it is changed.
--  Definition in: common_lists.lua
function check_special_ring_equipped_custom()
    if equip_lock_rings:contains(player.equipment.left_ring) then
        windower.add_to_chat(9, "left_ring locked")
        is_ring_locked = true
        disable("left_ring")
    elseif equip_lock_rings:contains(player.equipment.right_ring) then
        windower.add_to_chat(9, "right_ring locked")
        is_ring_locked = true
        disable("right_ring")
    elseif is_ring_locked then
        windower.add_to_chat(9, "Unlocking rings")
        is_ring_locked = false
        enable('left_ring')
        enable('right_ring')
    end
    -- lock_ring_left = equip_lock_rings:contains(player.equipment.left_ring)
    -- lock_ring_right = equip_lock_rings:contains(player.equipment.right_ring)
    -- equipped_ring_to_lock = lock_ring_left or lock_ring_right

    -- windower.add_to_chat(9, "equipped_ring_to_lock: " .. tostring(equipped_ring_to_lock))
    -- if not is_ring_locked and lock_ring_left then
    --     windower.add_to_chat(9, "left_ring locked")
    --     is_ring_locked = true
    --     disable("left_ring")
    -- end
    -- if not is_ring_locked and lock_ring_right then
    --     windower.add_to_chat(9, "right_ring locked")
    --     is_ring_locked = true
    --     disable("right_ring")
    -- end
    -- if is_ring_locked and not equipped_ring_to_lock then
    --     windower.add_to_chat(9, "Unlocking rings")
    --     is_ring_locked = false
    --     enable('left_ring')
    --     enable('right_ring')
    -- end
end

--  Lock weapon and sub slots
function melee_equip_lock()
    equipment_lock_specific({'main', 'sub',})
end

--  Unlock weapon and sub slots
function melee_equip_unlock()
    equipment_unlock_specific({'main', 'sub',})
end

-- local map_ids_raise = {
--     ['Raise'] = 12,
--     ['Raise II'] = 13,
--     ['Raise III'] = 140,
--     ['Arise'] = 494
-- }

-- function cast_highest_available_raise()
--     local spell_recasts = windower.ffxi.get_spell_recasts()

--     if spell_recasts[map_ids_raise['Arise']] == 0 and player.main_job == 'WHM' then
--         send_command('@input /ma "Arise" <t>')
--     elseif spell_recasts[map_ids_raise['Raise III']] == 0 then
--         send_command('@input /ma "Raise III" <t>')
--     elseif spell_recasts[map_ids_raise['Raise II']] == 0 then
--         send_command('@input /ma "Raise II" <t>')
--     elseif spell_recasts[map_ids_raise['Raise']] == 0 then
--         send_command('@input /ma "Raise" <t>')
--     else
--         add_to_chat(100, 'No Raise spells currently available.')
--     end
-- end

-- local map_ids_reraise = {
--     ['Reraise'] = 135,
--     ['Reraise II'] = 141,
--     ['Reraise III'] = 142,
--     ['Reraise IV'] = 848
-- }
-- function cast_highest_available_reraise()
--     local spell_recasts = windower.ffxi.get_spell_recasts()

--     if spell_recasts[map_ids_reraise['Reraise IV']] == 0 and player.main_job == 'WHM' then
--         send_command('@input /ma "Reraise IV" <me>')
--     elseif spell_recasts[map_ids_reraise['Reraise III']] == 0 then
--         send_command('@input /ma "Reraise III" <me>')
--     elseif spell_recasts[map_ids_reraise['Reraise II']] == 0 then
--         send_command('@input /ma "Reraise II" <me>')
--     elseif spell_recasts[map_ids_reraise['Reraise']] == 0 then
--         send_command('@input /ma "Reraise" <me>')
--     else
--         add_to_chat(100, 'No Reraise spells currently available.')
--     end
-- end
