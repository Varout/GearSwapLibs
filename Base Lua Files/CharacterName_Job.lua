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
function custom_instructions()
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
    -- state.Dyna = M(false, "Dyna Mode")

    --  Where @ is the Windows Key
    -- send_command('bind @m input /map')                  --  Windows Key + M: Show map, because I'm lazy af
    -- send_command('bind @d gs c Dyna')                   --  Windows Key + D: Activate Dyna mode

    custom_instructions()
end


function user_unload()
    -- send_command('unbind @m')
    -- send_command('unbind @d')
end


function init_gear_sets()
    include('CharacterName_Job_GearSets.lua')
end


--  ----------------------------------------------------------------------------------------------------
--  Check before changing any equipment
--  ----------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()
end


--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)

end


--  ----------------------------------------------------------------------------------------------------
--  MIDCAST
--  ----------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)

    equip(equipSet)
end


--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    check_special_ring_equipped()

    idleSet = sets.idle

    return idleSet
end


--  ----------------------------------------------------------------------------------------------------
--  STATUS CHANGE
--  ----------------------------------------------------------------------------------------------------
function user_status_change(newStatus, oldStatus)

end


--  ----------------------------------------------------------------------------------------------------
--  JOB BUFF CHANGE
--  ----------------------------------------------------------------------------------------------------
--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)

end


--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    --  Make Reraise easy to handle
    -- if (cmdParams[1]:lower() == 'reraise') then
    --     cast_highest_available_reraise()
    --     eventArgs.handled = true
    --     return
    -- end

end


--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    -- set_macro_page(#, #)
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------

