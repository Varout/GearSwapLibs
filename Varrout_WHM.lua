--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()
    --  Load common lua lists and functions
    include('common_lists.lua')
    include('common_functions.lua')

    --  Make sure all equipment can be changed/updated
    equipment_unlock_all()

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
--  Information about custom commands
--  ----------------------------------------------------------------------------------------------------
function custom_instructions()
    add_to_chat(200, "Varrout's WHM Custom commands:")
    add_to_chat(200, "* Windows Key + 1: Raise Target")
    add_to_chat(200, "* Windows Key + 2: Reraise")
    add_to_chat(200, "* Windows Key + C: Toggle Cursna Single Target/AoE Mode (Default Single Target)")
    add_to_chat(200, "* Windows Key + M: Show Map")
end


--  ----------------------------------------------------------------------------------------------------
--  User and job setup
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    state.CursnaSingle = M(true, "Cursna Single Target Mode")   --  If true, Cursna will use Gambanteinn for added potency

    --  Where @ is the Windows Key
    send_command('bind @c gs c toggle CursnaSingle')    --  Windows Key + C: Toggle Cursna Mode
    send_command('bind @m input /map')                  --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind @1 gs c raise')                  --  Windows Key + 1: Cast highest available raise
    send_command('bind @2 gs c reraise')                --  Windows Key + 2: Cast highest available reraise

    custom_instructions()
end


function user_unload()
    send_command('unbind @c')
    send_command('unbind @m')
    send_command('unbind @1')
    send_command('unbind @2')
end


function init_gear_sets()
    include('Varrout_WHM_GearSets.lua')
end


--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)

    if spell.name == "Addendum: White" then
        --  No need to waste a strategem on this
        cancel_spell()
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    end
end


--  ----------------------------------------------------------------------------------------------------
--  MIDCAST
--  ----------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    local equipSet = {}

    if spell.action_type == 'Magic' then
        local spell_element_match = check_spell_weather_day_match(spell)

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
    elseif spell.type == "Trust" then
        equipSet = sets.Trust
    end

    equip(equipSet)
end


--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    check_special_ring_equipped()

    idleSet = sets.idle

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


--  ----------------------------------------------------------------------------------------------------
--  STATUS CHANGE
--  ----------------------------------------------------------------------------------------------------
function user_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        melee_equip_lock()
    elseif oldStatus == 'Engaged' then
        melee_equip_unlock()
    end
end


--  ----------------------------------------------------------------------------------------------------
--  JOB BUFF CHANGE
--  ----------------------------------------------------------------------------------------------------
--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)
    if state.Buff["Sublimation: Activated"] then
        equip(sets.Sublimation)
    elseif buff == "Sublimation: Activated" and not gain then
        equip(sets.idle)
    end
end


--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)

    --  Make Reraise easy to handle
    if (cmdParams[1]:lower() == 'reraise') then
        cast_highest_available_reraise()
        eventArgs.handled = true
        return

    --  Make Raise easy to handle
    elseif cmdParams[1]:lower() == 'raise' then
        cast_highest_available_raise()
        eventArgs.handled = true
        return
    end
end


--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)    -- Jason
    send_command('wait 2; input /lockstyleset 004')
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
--  Lock weapon and sub slots
function melee_equip_lock()
    equipment_lock_specific({'main', 'sub',})
end

--  Unlock weapon and sub slots
function melee_equip_unlock()
    equipment_unlock_specific({'main', 'sub',})
end

windower.register_event('zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(sets.idle)
    end
)