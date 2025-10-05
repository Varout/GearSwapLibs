-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ WIN+X ]           Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Magic Burst Mode Toggle
--
--  Abilities:  [ CTRL+` ]          Full Circle
--              [ CTRL+B ]          Blaze of Glory
--              [ CTRL+A ]          Ecliptic Attrition
--              [ CTRL+D ]          Dematerialize
--              [ CTRL+L ]          Life Cycle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    --  Load common lua lists and functions
    include('common_lists.lua')
    include('common_functions.lua')

    geo_timer = ''
    indi_timer = ''
    indi_duration = 308
    entrust_timer = ''
    entrust_duration = 344
    entrust = 0
    newLuopan = 0

    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}

    element_colours = {
        ['Fire']      = "(255,  0,  0)",
        ['Blizzard']  = "(  0,255,255)",
        ['Aero']      = "(  0,255,128)",
        ['Stone']     = "(255,255,  0)",
        ['Thunder']   = "(255, 85,230)",
        ['Water']     = "(  0,  0,255)",
    }

    degrade_array = {
        ['Fire']      = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice']       = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind']      = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth']     = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water']     = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs']    = {'Aspir','Aspir II','Aspir III'},
    }

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    --  Pocket Mode: If this character is mainly used as a pocket holder, set this to true
    pocketMode = true
    if characterPocketMode ~= nil then
        pocketMode = characterPocketMode
    end

    --  Check if user has Lorg Mor (ideally stage 2 so it will take hp and wake you)
    --  If you only have the stage 1 version, update it here and in your gear sets
    LorgMor = false
    if player.inventory['Prime Club'] or player.wardrobe['Prime Club'] or
       player.inventory['Lorg Mor'] or player.wardrobe['Lorg Mor'] then
        LorgMor = true
    end

    state.ScreenRes  = M{['description'] = 'UI Screen Resolution'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.ZoomMode   = M(false, 'Movement Speed')

    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'MagicEva')
    state.ScreenRes:options('2460', '1820', '1366', 'off')
    if pocketMode then
        state.ScreenRes:set('off')
    end

    -- Additional local binds
    -- include('Global-Binds.lua')

    --Keybinds (! = ALT / @ = WIN / ^ = CTRL)
    send_command('bind ^` input /ja "Full Circle" <me>')
    send_command('bind ^b input /ja "Blaze of Glory" <me>')
    send_command('bind ^a input /ja "Ecliptic Attrition" <me>')
    send_command('bind ^d input /ja "Dematerialize" <me>')
    send_command('bind ^c input /ja "Life Cycle" <me>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind ^insert gs c cycleback Element')
    send_command('bind ^delete gs c cycle Element')
    send_command('bind !w input /ma "Aspir III" <t>')
    send_command('bind !p input /ja "Entrust" <me>')
    --send_command('bind ^, input /ma Sneak <stpc>')
    --send_command('bind ^. input /ma Invisible <stpc>')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle ZoomMode')
    send_command('bind @x gs c cycle IdleMode')

    send_command('bind ^numpad7 input /ws "Black Halo" <t>')
    send_command('bind ^numpad8 input /ws "Hexa Strike" <t>')
    send_command('bind ^numpad9 input /ws "Realmrazer" <t>')
    send_command('bind ^numpad6 input /ws "Exudation" <t>')
    send_command('bind ^numpad1 input /ws "Flash Nova" <t>')

    send_command('bind #- input /follow <t>')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false

    --  UI Box-Related
    ui_box_positions = {
        --  FFXI Resolution: 2460 x 1300
        --  Location fits between chat boxes and EquipViewer, giving enough space for PartyBuffs
        ['2460'] = {
            x = 1725,
            y = 1022
        },
        --  FFXI Resolution: 1820 x 920 (Big laptop, Small Desktop)
        --  Location lines up with the right hand side of the text boxes
        ['1820'] = {
            x = 1030,
            y = 608
        },
        --  FFXI Resolution: 1366 x 736 (Small Laptop)
        --  Location lines up with the right hand side of the text boxes
        ['1366'] = {
            x = 803,
            y = 465
        },
    }

    ui_box_font_sizes = {
        ['1440p'] = 10,
        ['1820'] = 10,
        ['1366'] = 9
    }

    --  Make sure the box transparency doesn't get darker on Subjob change
    if gearswap_ui_box then
        gearswap_ui_box:hide()
    end
    gearswap_ui_box = texts.new(get_ui_config())
    if not pocketMode then
        display_ui()
    end
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^b')
    send_command('unbind ^a')
    send_command('unbind ^d')
    send_command('unbind ^c')
    send_command('unbind !`')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind !w')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @w')
    send_command('unbund @x')
    send_command('unbund @c')

    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad1')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad+')

    gearswap_ui_box:hide()
end

--  ----------------------------------------------------------------------------------------------------
--                      Textbox functions & config
--  ----------------------------------------------------------------------------------------------------
--  Used to Display/Refresh UI
function display_ui()
    gearswap_ui_box:text(get_ui_text())
    gearswap_ui_box:show()
end

function reset_ui()
    gearswap_ui_box:hide()
    if state.ScreenRes.current ~= 'off' then
        gearswap_ui_box = texts.new(get_ui_config())
        display_ui()
    end
end

function get_ui_text()
    output = ''

    output = output .. '           ' .. player.name ..': GEOMANCER\n\n'
    --  Mode states
    output = output .. '(Win  + C)       | Zoom Mode | \\cs(0,255,128)' .. capitaliseLeadingLetter(state.ZoomMode.current) .. '\\cr\n'
    output = output .. '(Win  + X)       | Idle Mode | \\cs(0,255,128)' .. capitaliseLeadingLetter(state.IdleMode.current) .. '\\cr\n'
    output = output .. '(Ctrl + INS/DEL) | Element   | \\cs' .. element_colours[state.Element.current] .. 'O \\cr' .. capitaliseLeadingLetter(state.Element.current) ..'\n'
    --  Shortcut information
    output = output .. '\nShortcuts                                 \n'  --  Stupid long to keep the box from changing size
    output = output .. '(Ctrl + A) | Ecliptic Attrition (Pot. 25%)\n'
    output = output .. '(Ctrl + B) | Blaze of Glory     (Pot. 50%)\n'
    output = output .. '(Ctrl + C) | Life Cycle    (Pet: HP)\n'
    output = output .. '(Ctrl + D) | Dematerialize (Pet: 0% dt)\n'
    output = output .. '(Ctrl + `) | Full Circle   (Pet: Dismiss)\n'
    output = output .. '(Alt  + P) | Entrust (Indi -> Party)\n'

    return output
end

function get_ui_config()
    return {
        pos = ui_box_positions[state.ScreenRes.current],
        -- pos = {x = 0, y = 0},    --  If you prefer to have just one set location
        padding = 8,
        text = {
            font = 'Lucida Console',    --  Mono-spaced font looks much nicer
            size = ui_box_font_sizes[state.ScreenRes.current],
            -- size = 10,   --  If you prefer to have just one set font
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
            --  75-100 Gives a nice transparency level for the background. Higher is darker
            --  75 is similar transparency to the default for EquipViewer
            alpha = 75
        },
        flags = {}
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and buffactive.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Enfeebling Magic' and newLuopan == 1 then
        -- prevent Cohort Cloak from unequipping head when relic head is locked
        equip(sets.midcast.LockedEnfeebles)
    elseif spell.skill == 'Geomancy' then
        if buffactive.Entrust and spell.english:startswith('Indi-') then
            equip(sets.EntrustDuration)
            entrust = 1
        elseif newLuopan == 0 and spell.english:startswith('Geo-') then
            equip(sets.PetHP)
            disable('head')
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        --[[if spell.english:startswith('Geo') then
            geo_timer = spell.english
            send_command('@timers c "'..geo_timer..'" 600 down spells/00136.png')
        elseif spell.english:startswith('Indi') then
            if entrust == 1 then
                entrust_timer = spell.english
                send_command('@timers c "'..entrust_timer..' ['..spell.target.name..']" '..entrust_duration..' down spells/00136.png')
                entrust = 0
            else
                send_command('@timers d "'..indi_timer..'"')
                indi_timer = spell.english
                send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
            end
        end ]]
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    elseif buff == "sleep" and LorgMor then  --  The string 'sleep' needs to be completely in lower case
        if gain then
            equip(sets.slept)
            melee_equip_lock()
            if buffactive["Stoneskin"] then
                windower.ffxi.cancel_buff(37)  --  Cancels stoneskin
            end
        else
            melee_equip_unlock()
            -- equip(customize_idle_set())
        end
    elseif (buff == "Sneak" or buff == "Invisible") then
        if gain then
            equip(sets.movement)
        else
            -- equip(customize_idle_set())
        end
    elseif buff == 'silence' and gain then
        remove_silence()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        equip(sets.main_weapons)
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
        enable('head')
        newLuopan = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    reset_ui()
    -- check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    classes.CustomIdleGroups:clear()
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if pet.isvalid then
        idleSet = sets.idle[state.IdleMode.current].Pet
        if pet.hpp > 73 then
            if newLuopan == 1 then
                equip(sets.PetHP)
                disable('head')
            end
        elseif pet.hpp <= 73 then
            enable('head')
            newLuopan = 0
        end
    else
        idleSet = sets.idle[state.IdleMode.current]
    end

    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    if not pet.isvalid then
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

        if buffactive["Sneak"] or buffactive["Invisible"] then
            idleSet = set_combine(idleSet, sets.movement)
        end
    end

    return idleSet
end

function customize_melee_set(meleeSet)

    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Auto.value then
        msg = ' Auto: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1,11)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 12')
end

--  Lock weapon and sub slots
function melee_equip_lock()
    disable('main', 'sub')
end

--  Unlock weapon and sub slots
function melee_equip_unlock()
    enable('main', 'sub')
end
