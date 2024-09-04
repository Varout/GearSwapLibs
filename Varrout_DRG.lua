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
end


--  ----------------------------------------------------------------------------------------------------
--  Information about custom commands
--  ----------------------------------------------------------------------------------------------------
-- function custom_instructions()
-- end


--  ----------------------------------------------------------------------------------------------------
--  User and job setup
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal, DT')

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    -- state.Dyna = M(false, "Dyna Mode")

    --  Where @ is the Windows Key
    -- send_command('bind @m input /map')                  --  Windows Key + M: Show map, because I'm lazy af
    -- send_command('bind @d gs c Dyna')                   --  Windows Key + D: Activate Dyna mode

    -- custom_instructions()
end


function user_unload()
    -- send_command('unbind @m')
    -- send_command('unbind @d')
end


function init_gear_sets()
    include('Varrout_DRG_GearSets.lua')
end


--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    check_debuff_silenced(spell, eventArgs)

    -- add_to_chat(123, spell.type .. ' | ' .. spell.english)

    if spell.english == "Dismiss" and pet.hpp < 100 then -- Cancel Dismiss If Wyvern's HP Is Under 100% --
        cancel_spell()
        add_to_chat(123, spell.english .. ' Canceled: [' .. pet.hpp .. ']')
        eventArgs.handled = true
        return
    end

    local equipSet
    if spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    elseif spell.type == 'Waltz' then
        -- refine_waltz(spell, action)
        -- equip(sets.precast.Waltz)
    elseif wyv_breath_spells:contains(spell.english) and pet.isvalid then
        if HB_Mage_SubJob:contains(player.sub_job) then
            equip(sets.Pet.HealingBreathTrigger)
        elseif HB_DD_SubJob:contains(player.sub_job) and player.hpp < 34 then
            equip(sets.Pet.HealingBreathTrigger)
        end
    elseif spell.type == 'WeaponSkill' then
        equipSet = sets.precast.WS
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
    elseif spell.type == 'JobAbility' then
        equipSet = sets.precast.JA
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
    elseif spell.type == 'PetCommand' then
        equipSet = sets.Pet
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
    elseif spell.action_type == 'Magic' then
        add_to_chat(200, 'Magic')
        equipSet = sets.precast.FC
    end
    equip(equipSet)
end


--  ----------------------------------------------------------------------------------------------------
--  MIDCAST
--  ----------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- add_to_chat(123, spell.action_type .. ' | ' .. spell.english)
    if spell.type == 'Trust' then
        return
    end

    if spell.action_type == 'Magic' and pet.isvalid then
        if HB_Mage_SubJob:contains(player.sub_job) then
            equip(sets.Pet.HealingBreathTrigger)
        elseif HB_DD_SubJob:contains(player.sub_job) and player.hpp < 34 then
            equip(sets.Pet.HealingBreathTrigger)
        end
    end
end

function job_pet_midcast(spell, action)
    local equipSet = sets.Pet
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.Pet["Restoring Breath"])
    elseif wyv_elem_breath:contains(spell.english) then
        equip(sets.midcast.ElementalBreath)
    end
end


--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    check_special_ring_equipped()

    idleSet = sets.idle
    --  Subjob with MP, give it some refresh
    if DRG_MP_SubJob:contains(player.sub_job) then
        idleSet = set_combine(idleSet, sets.idle.Refresh)

        --  We're in a ToAU Assault or Salvage zone, give a bit of extra idle refresh
        if zones_toau_ring:contains(world.area) then
            idleSet = set_combine(idleSet, sets.idle.RefreshToAU)
        end
    end

    return idleSet
end


--  ----------------------------------------------------------------------------------------------------
--  Checks before equipping new gear
--  ----------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()
end


--  ----------------------------------------------------------------------------------------------------
--  STATUS CHANGE
--  ----------------------------------------------------------------------------------------------------
-- function user_status_change(newStatus, oldStatus)
--     local equipSet = sets.engaged
--     equip(equipSet)
-- end


--  ----------------------------------------------------------------------------------------------------
--  JOB BUFF CHANGE
--  ----------------------------------------------------------------------------------------------------
--  Job specific ability changes, mostly here to handy Sublimation
-- function job_buff_change(buff, gain, eventArgs)
-- end


--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
-- function job_self_command(cmdParams, eventArgs)
-- end


--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book()
end

function select_default_macro_book()
    if HB_Mage_SubJob:contains(player.sub_job) then
        set_macro_page(1, 6)
    else
        set_macro_page(2, 6)
    end

    equip(sets.lockstyle)
    send_command('wait 2; input /lockstyle on')
    -- send_command('wait 2; input /lockstyleset 006')
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
windower.register_event('zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(sets.idle)
    end
)