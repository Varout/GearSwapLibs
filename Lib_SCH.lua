--  For SCH 3-Step
three_step_skillchains = S{
    '3distortion',       --  Blizard / Water
    '3fragmentation',    --  Aero / Thunder
    '3fusion',           --  Fire / Light
    '3gravitation',      --  Dark / Stone
}

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
    --  Pocket Mode: If this character is mainly used as a pocket holder, set this to true
    pocketMode = true
    if characterPocketMode ~= nil then
        pocketMode = characterPocketMode
    end

    --  Check if user has Prime weapon (ideally stage 1 or 2 so it will take hp and wake you)
    --  If you only have the stage 1 version, update it here and in your gear sets
    primeStaff = false
    if player.inventory['Prime Staff'] or player.wardrobe['Prime Staff'] or
       player.inventory['Opashoro'] or player.wardrobe['Opashoro'] then
        primeStaff = true
    end

    state.ScreenRes  = M{['description'] = 'UI Screen Resolution'}

    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.CastingMode:options('Normal', 'MagicBurst')
    state.IdleMode:options('Refresh', 'Hybrid', 'HybridMagEva', 'MagicEvasion')
    state.ScreenRes:options('2460', '1820', '1366', 'off')
    if pocketMode then
        state.ScreenRes:set('off')
    end

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

	--Keybinds (! = ALT / @ = WIN / ^ = CTRL)
    send_command('bind @c gs c cycle CastingMode')      --  Windows Key + C: Cycle Casting Modes
    send_command('bind @x gs c cycle IdleMode')         --  Windows Key + X: Cycle Idle Modes
    send_command('bind @z gs c cycle ScreenRes')        --  Windows Key + Z: Cycle ScreenRes Modes - Where to show the UI, or turn it off

    send_command('bind @m input /map')                  --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind ^c gs c convert')                --  Ctrl + C: Convert

    send_command('bind @1 gs c raise')                  --  Windows Key + 1: Cast highest available raise
    send_command('bind @2 gs c reraise')                --  Windows Key + 2: Cast highest available reraise

    --  Skillchain related
    send_command('bind @5 gs c fragmentation')          --  Windows Key + 5: Fragmentation
    send_command('bind @6 gs c fusion')                 --  Windows Key + 6: Fusion
    send_command('bind @7 gs c distortion')             --  Windows Key + 7: Distortion
    send_command('bind @8 gs c gravitation')            --  Windows Key + 8: Gravitation

    send_command('bind ^F5 gs c 3fragmentation')        --  Ctrl + F5: 3-Step Fragmentation
    send_command('bind ^F6 gs c 3fusion')               --  Ctrl + F6: 3-Step Fusion
    send_command('bind ^F7 gs c 3distortion')           --  Ctrl + F7: 3-Step Distortion
    send_command('bind ^F8 gs c 3gravitation')          --  Ctrl + F8: 3-Step Gravitation

    --  UI Box-Related
    --  Make sure the box transparency doesn't get darker on Subjob change
    if gearswap_ui_box then
        gearswap_ui_box:hide()
    end
    ui_box_positions = {
        --  FFXI Resolution: 2460 x 1300
        --  Location lines up with the bottom of Equip Viewer
        ['2460'] = {
            x = 1725,
            y = 1054
        },
        --  FFXI Resolution: 1820 x 920 (Big laptop, Small Desktop)
        --  Location lines up with the right hand side of the text boxes
        ['1820'] = {
            x = 989,
            y = 610
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

    gearswap_ui_box = texts.new(get_ui_config())
    display_ui()
end

function user_unload()
    send_command('unbind @z')
    send_command('unbind @x')
    send_command('unbind @c')

    send_command('unbind @m')
    send_command('unbind ^c')

    send_command('unbind @1')
    send_command('unbind @2')
    --  Skillchain related
    send_command('unbind @5')
    send_command('unbind @6')
    send_command('unbind @7')
    send_command('unbind @8')

    send_command('unbind ^F5')
    send_command('unbind ^F6')
    send_command('unbind ^F7')
    send_command('unbind ^F8')
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

    output = output .. '            ' .. player.name ..': SCHOLAR\n\n'
    --  Mode states
    output = output .. '(Win + X)  | Idle Mode    | \\cs(0,255,128)' .. state.IdleMode.current .. '\\cr\n'
    output = output .. '(Win + C)  | Casting Mode | \\cs(0,255,128)' .. state.CastingMode.current .. '\\cr\n'
    output = output .. '                                        \n'  --  Stupid long to keep the box from changing size
    --  Shortcut information
    output = output .. '(Ctrl + C) | Convert\n'
    output = output .. '(Win  + 1) | Raise\n'
    output = output .. '(Win  + 2) | Reraise\n'
    output = output .. '\n'
    output = output .. '(Win  + 5) | Fragmentation \\cs(  0,255,128)(\\cr\\cs(255, 85,230))\\cr\n'  --  Green/Purple
    output = output .. '(Win  + 6) | Fusion        \\cs(255,255,255)(\\cr\\cs(255,  0,  0))\\cr\n'  --  White/Red
    output = output .. '(Win  + 7) | Distortion    \\cs(  0,  0,255)(\\cr\\cs(  0,255,255))\\cr\n'  --  Blue/Light Blue
    output = output .. '(Win  + 8) | Gravitation   \\cs(255,255,  0)(\\cr\\cs(  0,  0,  0))\\cr\n'  --  Yellow/Black
    --  Debug information here?

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

--  ----------------------------------------------------------------------------------------------------
--  Check before changing any equipment
--  ----------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    reset_ui()
end

--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)

    if spell.name == "Stoneskin" and buffactive["Stoneskin"] then
        windower.ffxi.cancel_buff(37)
    end
end

--  ----------------------------------------------------------------------------------------------------
--  MIDCAST
--  ----------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    local midcastSet = {}
    local elementMatch = false

    if spell.action_type == 'Magic' then
        elementMatch = check_spell_weather_day_match(spell)
    end

    if (spell.skill == "Healing Magic") then
        ---------------------
        --  Healing Magic  --
        ---------------------
        if (spells_cure:contains(spellMap)) then
            if elementMatch then
                midcastSet = sets.midcast.CurePotency
            else
                midcastSet = sets.midcast.Cure
            end
        elseif (sets.midcast[spell.name]) then
            midcastSet = sets.midcast[spell.name]
        elseif (sets.midcast[spellMap]) then
            midcastSet = sets.midcast[spellMap]
        else
            midcastSet = sets.midcast["Healing Magic"]
        end

        if (not spells_cure:contains(spellMap)) then
            if buffactive["Penury"] then
                midcastSet = set_combine(midcastSet, sets.PenuryParsimony)
            end

            if buffactive["Celerity"] and check_spell_weather_match(spell) then
                midcastSet = set_combine(midcastSet, sets.CelerityAlacrity)
            end
        end

    elseif (spell.skill == "Enhancing Magic") then
        -----------------------
        --  Enhancing Magic  --
        -----------------------
        if (spells_barElement:contains(spell.name)) then
            midcastSet = sets.midcast["BarElement"]
        elseif (spells_barAilment:contains(spell.name)) then
            midcastSet = sets.midcast['BarAilment']
        elseif (sets.midcast[spell.name]) then
            midcastSet = sets.midcast[spell.name]
        elseif (sets.midcast[spellMap]) then
            midcastSet = sets.midcast[spellMap]
        else
            midcastSet = sets.midcast["Enhancing Magic"]
        end

        if (spellMap == "Refresh" and spell.target.name == player.name) then
            midcastSet = set_combine(midcastSet, sets.RefreshSelfDuration)
        end

    elseif (spell.skill == "Enfeebling Magic") then
        ------------------------
        --  Enfeebling Magic  --
        ------------------------
        midcastSet = sets.midcast["Enfeebling Magic"]

    elseif (spell.skill == "Elemental Magic" or spell.skill == "Dark Magic") then
        ------------------------------
        --  Elemental & Dark Magic  --
        ------------------------------
        if (sets.midcast[spell.name]) then
            midcastSet = sets.midcast[spell.name]
        elseif (sets.midcast[spellMap]) then
            midcastSet = sets.midcast[spellMap]
        elseif (sets.midcast[spell.skill]) then
            midcastSet = sets.midcast[spell.skill]
        else
            --  Shouldn't get here, but just in case
            midcastSet = sets.midcast["Elemental Magic"]
        end

        --  If there is a weather or day match
        if (elementMatch) then
            midcastSet = set_combine(midcastSet, sets.midcast.Potency)
        end

        --  If Casting Moade is Magic Burst
        if (state.CastingMode.current == "MagicBurst") then
            midcastSet = set_combine(midcastSet, sets.MagicBurst)
        end

        --  Check for Potency (Ebullience)
        if buffactive['Ebullience'] then
            midcastSet = set_combine(midcastSet, sets.RaptureEbullience)
        end

        --  If Klimaform is active
        if (buffactive["Klimaform"]) then
            midcastSet = set_combine(midcastSet, sets.Klimaform)
        end
    end

    equip(midcastSet)
end

--  ----------------------------------------------------------------------------------------------------
--  AFTERCAST
--  ----------------------------------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell == "Snenk" or spell == "Invisible") and not spell.interrupted then
       local tempIdle = set_combine(customize_idle_set(), sets.movement)
       equip(tempIdle)
       eventArgs.handled = true
       return
    end
end

--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set()
    local idleSet = sets.idle[state.IdleMode.current]

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
    if buffactive["Sublimation: Activated"] and state.IdleMode.current ~= "MagicEvasion" then
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
--  Job specific ability changes, mostly here to handle Sublimation
function job_buff_change(buff, gain, eventArgs)
    -- add_to_chat(123, buff)
    if buff == "Sublimation: Activated" or buff == "Sublimation: Complete" then
        equip(customize_idle_set())
    elseif buff == "sleep" and primeStaff then  --  The string 'sleep' needs to be completely in lower case
        if gain then
            equip(sets.slept)
            melee_equip_lock()
            if buffactive["Stoneskin"] then
                windower.ffxi.cancel_buff(37)  --  Cancels stoneskin
            end
        else
            melee_equip_unlock()
            equip(customize_idle_set())
        end
    elseif (buff == "Sneak" or buff == "Invisible") then
        if gain then
            equip(sets.movement)
        else
            equip(customize_idle_set())
        end
    elseif buff == 'silence' and gain then
        remove_silence()
    end
end

--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    local actionString = cmdParams[1]:lower()

    if (actionString == 'reraise') then
        --  Make Reraise easy to handle
        cast_highest_available_reraise()

    elseif (actionString == 'raise') then
        --  Make Raise easy to handle
        cast_highest_available_raise()

    elseif (actionString == 'convert') then
        convert()

    elseif (actionString == 'slept') then
        --  Wake if slept
        --  Cancel Stoneskin if active
        if buffactive["Stoneskin"] then
            windower.ffxi.cancel_buff(37)   --  Cancels stoneskin
        end
        --  Equip Prime weapon to wake
        equip(sets.slept)

    elseif (level_2_skillchains:contains(actionString) or three_step_skillchains:contains(actionString)) then
        --  Self skillchain
        self_skillchain(actionString)

    elseif cmdParams[1]:lower() == 'twofusion' then
        self_skillchain_two_step_fusion()
    end
end

--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)    --  Jason
    send_command('wait 2; input /lockstyleset 001')
end

--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
function convert()
    local input_str = ''

    input_str = input_str .. 'input /ja Convert <me>;'
    input_str = input_str .. 'wait 1.2;'

    if buffactive['Light Arts'] or buffactive['Addendum: Light'] then
        input_str = input_str .. 'input /ja Rapture <me>;'
        input_str = input_str .. 'wait 1.2;'
    end

    input_str = input_str .. 'input /ma "Cure IV" <me>;'

    send_command(input_str)
end

--  ----------------------------------------------------------------------------------------------------
--                      Self Skillchains
--  ----------------------------------------------------------------------------------------------------
function self_skillchain(skillchain_type)
    if buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
        --  2-Step Skillchains
        if (skillchain_type == 'fragmentation') then
            self_sc_fragmentation()
        elseif (skillchain_type == 'fusion') then
            self_sc_fusion()
        elseif (skillchain_type == 'distortion') then
            self_sc_distortion()
        elseif (skillchain_type == 'gravitation') then
            self_sc_gravitation()

        --  3-Step Skillchains
        elseif (skillchain_type == '3fragmentation') then
            self_sc_three_step_fragmentation()
        elseif (skillchain_type == '3fusion') then
            self_sc_three_step_fusion()
        elseif (skillchain_type == '3distortion') then
            self_sc_three_step_distortion()
        elseif (skillchain_type == '3gravitation') then
            self_sc_three_step_gravitation()
        end
    else
        add_to_chat(121, "Cancelling self-skillchain: Dark Arts not activated")
    end
end

--  ------------------------------------------------------------------
--  Skillchains: 2-Step
--  ------------------------------------------------------------------
--  Fragmentation (Aero/Thunder)
function self_sc_fragmentation()
    local input_str = '' ..

    'input /p Self-skillchain: Fragmentation (Aero/Thunder);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Blizzard" <t>;' ..
    'wait 4;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Hydrohelix" <t>;' ..
    'input /p Closing Fragmentation;' ..
    'timer create "Skillchain Window Open" 8 down;'

    send_command(input_str)
end

--  Fusion (Light/Fire)
function self_sc_fusion()
    local input_str = '' ..

    'input /p Self-skillchain: Fusion (Light/Fire);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Fire" <t>;' ..
    'wait 4;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Ionohelix" <t>;' ..
    'input /p Closing Fusion;' ..
    'timer create "Skillchain Window Open" 8 down;'

    send_command(input_str)
end

--  Distortion (Water/Blizzard)
function self_sc_distortion()
    local input_str = '' ..

    'input /p Self-skillchain: Distortion (Water/Blizzard);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Luminohelix" <t>;' ..
    'wait 6.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Geohelix" <t>;' ..
    'input /p Closing Distortion;' ..
    'timer create "Skillchain Window Open" 8 down;'

    send_command(input_str)
end

--  Gravitation (Dark/Stone)
function self_sc_gravitation()
    local input_str = '' ..

    'input /p Self-skillchain: Gravitation (Dark/Stone);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Aero" <t>;' ..
    'wait 4;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Noctohelix" <t>;' ..
    'input /p Closing Gravitation;' ..
    'timer create "Skillchain Window Open" 8 down;'

    send_command(input_str)
end

--  ------------------------------------------------------------------
--  Skillchains: 3-Step
--  Only Fusion is really worth it, but the rest are here just in case
--  ------------------------------------------------------------------
--  Liquefaction (Fire) -> Fusion (Light/Fire)
function self_sc_three_step_fusion()
    local input_str = '' ..

    'input /p Self-skillchain: 3-Step Liquefaction (Fire) to Fusion (Fire/Light);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Stone" <t>;' ..
    'wait 6;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.5;' ..
    'input /ma "Pyrohelix" <t>;' ..
    'input /p Closing Liquefaction;' ..
    'wait 5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2.5;' ..
    'input /ma "Ionohelix II" <t>;' ..
    'input /p Closing Fusion;'

    send_command(input_str)
end

--  Detonation (Wind) -> Gravitation (Stone/Darkness)
function self_sc_three_step_gravitation()
    local input_str = '' ..

    'input /p Self-skillchain: 3-Step Detonation (Wind) to Gravitation (Stone/Darkness);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Thunder" <t>;' ..
    'wait 6;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.5;' ..
    'input /ma "Anemohelix" <t>;' ..
    'input /p Closing Detonation;' ..
    'wait 5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2.5;' ..
    'input /ma "Noctohelix II" <t>;' ..
    'input /p Closing Gravitation;'

    send_command(input_str)
end

--   Induration (Ice) -> Fragmentation (Aero/Thunder)
function self_sc_three_step_fragmentation()
    local input_str = '' ..

    'input /p Self-skillchain: 3-Step Induration (Ice) to Fragmentation (Aero/Thunder);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Water" <t>;' ..
    'wait 6;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.5;' ..
    'input /ma "Cryohelix" <t>;' ..
    'input /p Closing Induration;' ..
    'wait 5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2.5;' ..
    'input /ma "Hydrohelix II" <t>;' ..
    'input /p Closing Fragmentation;'

    send_command(input_str)
end

--   Transfixion (Light) -> Distortion (Water/Blizzard)
function self_sc_three_step_distortion()
    local input_str = '' ..

    'input /p Self-skillchain: 3-Step Transfixion (Light) to Distortion (Water/Blizzard);' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.2;' ..
    'input /ma "Noctohelix" <t>;' ..
    'wait 6;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 1.5;' ..
    'input /ma "Luminohelix" <t>;' ..
    'input /p Closing Transfixion;' ..
    'wait 5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2.5;' ..
    'input /ma "Geohelix II" <t>;' ..
    'input /p Closing Distortion;'

    send_command(input_str)
end



--  ----------------------------------------------------------------------------------------------------
--                      Misc functions
--  ----------------------------------------------------------------------------------------------------
--  Unlocks rings when zoning. The idea is that my lua locks specific rings when they are equipped
windower.register_event(
    'zone change',
    function()
        if not pocketMode then
            equip(customize_idle_set())
        end
    end
)