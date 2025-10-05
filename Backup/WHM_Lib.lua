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
--  User and job setup
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Check if user has Lorg Mor (ideally stage 1 so it will take hp and wake you)
    LorgMor = false
    if player.inventory['Lorg Mor'] or player.wardrobe['Lorg Mor'] then
        LorgMor = true
    end

    state.CursnaMode = M{['description'] = 'Cursna Mode'}
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    -- state.OffenseMode:options('Normal')
    -- state.HybridMode:options('Normal')
    -- state.CastingMode:options('Normal')
    state.IdleMode:options('Refresh', 'Hybrid', 'MagicEvasion')
    state.CursnaMode:options('Potency', 'AoE')

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    state.AutoCancelRefresh = M(true, "Auto-Cancel Refresh Mode")

    --Keybinds (! = ALT / @ = WIN / ^ = CTRL)
    send_command('bind @c gs c cycle CursnaMode')               --  Windows Key + C: Cycle Cursna Modes
    send_command('bind @x gs c cycle IdleMode')                 --  Windows Key + X: Cycle Idle Modes

    send_command('bind @` gs c toggle AutoCancelRefresh')       --  Windows Key + `: Toggle Auto-Cancel Refresh

    send_command('bind @1 gs c raise')                          --  Windows Key + 1: Cast highest available raise
    send_command('bind @2 gs c reraise')                        --  Windows Key + 2: Cast highest available reraise
    send_command('bind @z gs c slept')                          --  Windows Key + Z: Cancels Stoneskin and equips Lorg Mor

    send_command('bind @m input /map')                          --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind ^c input /ja "Divine Caress" <me>')      --  Ctrl + C: Divine Caress

    display_ui()
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')

    send_command('unbind @`')

    send_command('unbind @1')
    send_command('unbind @2')
    send_command('unbind @z')

    send_command('unbind @m')
    send_command('unbind ^c')
end

function init_gear_sets()
    include('Varrout_WHM_GearSets.lua')
end

--  ----------------------------------------------------------------------------------------------------
--                      Textbox functions & config
--  ----------------------------------------------------------------------------------------------------
--  Used to Display/Refresh UI
function display_ui()
    gearswap_ui_box:text(get_ui_text())
    gearswap_ui_box:show()
end

function get_ui_text()
    output = ''

    output = output .. '           ' .. player.name ..': WHITE MAGE\n\n'
    --  Mode states
    output = output .. '(Win + x)  | Idle Mode           | \\cs(0,255,128)' .. state.IdleMode.current .. '\\cr\n'
    output = output .. '(Win + c)  | Cursna Mode Mode    | \\cs(0,255,128)' .. state.CursnaMode.current .. '\\cr\n'
    output = output .. '(Win + `)  | Auto-Cancel Refresh | \\cs(0,255,128)' .. state.AutoCancelRefresh.current .. '\\cr\n\n'
    --  Shortcut information
    output = output .. 'Shortcuts                                      \n'  --  Stupid long to keep the box from changing size
    output = output .. '(Ctrl + C) | Divine Caress\n'
    output = output .. '(Win  + 1) | Arise/Raise Target\n'
    output = output .. '(Win  + 2) | Reraise'
    --  Debug information here?

    return output
end

function get_ui_config()
    return {
        pos = {     --  This location lines up with the bottom of Equip Viewer in when ffxi is 2460 x 1300
            x = 1755,
            y = 988
        },
        padding = 8,
        text = {
            font = 'Lucida Console',    --  Mono-spaced font looks much nicer
            size = 10,
            stroke = {
                width = 2,
                alpha = 255
            },
            Fonts = {
                'Lucida Console',
                -- 'sans-serif'
            },
        },
        bg = {
            alpha = 100     --  Gives a nice transparency level for the background
        },
        flags = {}
    }
end

gearswap_ui_config = {
    --  To-do: Expand position options for multiple resolutions
    pos = {     --  This location lines up with the bottom of Equip Viewer in when ffxi is 2460 x 1300
        x = 1755,
        y = 988
    },
    padding = 8,
    text = {
        font = 'Lucida Console',
        size = 10,
        stroke = {
            width = 2,
            alpha = 255
        },
        Fonts = {
            'Lucida Console',
            -- 'sans-serif'
        },
    },
    bg = {
        alpha = 100
    }, --  Gives a nice transparency level for the background
    flags = {}
}

gearswap_ui_box = texts.new(gearswap_ui_config)

--  ----------------------------------------------------------------------------------------------------
--  Check before changing any equipment
--  ----------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()
    display_ui()
end

--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)

    if spell.name == "Addendum: White" then
        --  No need to waste a strategem on this
        cancel_spell()
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    elseif spell.name == 'Cursna' then
        equip(sets.precast['Healing Magic'])
        eventArgs.handled = true
        return
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
            if buffactive["Divine Caress"] then
                equipSet = set_combine(equipSet, sets.midcast.Caress)
            end

            --  Cursna removal gear is most important. Combine last
            if spell.name == 'Cursna' then
                if player.sub_job == 'NIN' and sets.midcast.CursnaNIN then
                    equipSet = sets.midcast.CursnaNIN
                else
                    --  Equip Cursna set based on state.CursnaMode
                    equipSet = sets.midcast.Cursna[state.CursnaMode.current]
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
    eventArgs.handled = true
    return
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell == "Snenk" or spell == "Invisible") and not spell.interrupted then
       local tempIdle = customize_idle_set(sets.idle)
       tempIdle = set_combine(tempIdle, sets.movement)
       equip(tempIdle)
       eventArgs.handled = true
       return
    end
end

--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    check_special_ring_equipped()

    if player.mpp <= 75 then
        idleSet = set_combine(idleSet, sets.latentRefresh75)
    end

    if player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.latentRefresh50)
    end

    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  If in town
    if areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.town)
    end

    --  If in an Adoulin zone, equip body piece if available
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    --  Check if sublimation is active
    if buffactive["Sublimation: Activated"] then
        idleSet = set_combine(idleSet, sets.sublimation)
    end

    if buffactive["Sneak"] or buffactive["Invisible"] then
        idleSet = set_combine(idleSet, sets.movement)
    end

    return idleSet
end

--  ----------------------------------------------------------------------------------------------------
--  STATUS CHANGE
--  ----------------------------------------------------------------------------------------------------
-- function user_status_change(newStatus, oldStatus)
-- end

--  ----------------------------------------------------------------------------------------------------
--  JOB BUFF CHANGE
--  ----------------------------------------------------------------------------------------------------
--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)
    -- add_to_chat(123, buff)
    if buffactive["Sublimation: Activated"] then
        equip(sets.Sublimation)
    elseif buff == "Sublimation: Activated" and not gain then
        equip(sets.idle)
    elseif buff == "sleep" and LorgMor then  --  The string 'sleep' needs to be completely in lower case
        if gain then
            equip(sets.slept)
            melee_equip_lock()
            if buffactive["Stoneskin"] then
                windower.ffxi.cancel_buff(37)  --  Cancels stoneskin
            end
        else
            melee_equip_unlock()
            equip(customize_idle_set(sets.idle))
        end
    elseif (buff == "Sneak" or buff == "Invisible") then
        if gain then
            equip(sets.movement)
        else
            equip(customize_idle_set(sets.idle))
        end
    elseif buff == 'silence' and gain then
        remove_silence()
    elseif buff == 'Refresh' and player.sub_job == 'SCH' then
        --  Salty whm/sch does not want your Refresh
        if state.AutoCancelRefresh.current == 'on' and not buffactive['Weakness'] then
            windower.ffxi.cancel_buff(43)
        end
    end
end

--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    --  Make Reraise easy to handle
    if (cmdParams[1]:lower() == 'reraise') then
        cast_highest_available_reraise()

    --  Make Raise easy to handle
    elseif cmdParams[1]:lower() == 'raise' then
        cast_highest_available_raise()

    --  Wake if slept
    elseif cmdParams[1]:lower() == 'slept' then
        --  Cancel Stoneskin if active
        if buffactive["Stoneskin"] then
            windower.ffxi.cancel_buff(37)   --  Cancels stoneskin
        end
        --  Equip Prime club to wake
        equip(sets.slept)
    end
end

--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)    -- Jason
    send_command('wait 2; input /lockstyleset 003')
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

--  ----------------------------------------------------------------------------------------------------
--                      Misc functions
--  ----------------------------------------------------------------------------------------------------
--  Unlocks rings when zoning. The idea is that my lua locks specific rings when they are equipped
windower.register_event(
    'zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(customize_idle_set(sets.idle))
    end
)