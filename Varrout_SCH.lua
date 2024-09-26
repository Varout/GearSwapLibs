
-- function get_sets()
--     mote_include_version = 2

--     -- Load and initialize the include file.
--     include('Mote-Include.lua')
-- end

-- function user_setup()
--     state.CP = M(false, "Capacity Points Mode")
--     send_command('bind @c gs c toggle CP')
-- end

-- function user_unload()
--     send_command('unbind @c')
-- end

-- function init_gear_sets()

--[[ ******************************************************
 Equip functions - put on the sets we defined above, and
echo a note to our chat log so we know it worked.
****************************************************** --]]

-- equip our idle set
-- function equip_idle()
--     idleSet = sets.Idle
--     idleString = "********** [Idle] "

--     if buffactive["Sublimation: Activated"] then
--         idleSet = set_combine(idleSet, sets.Sublimation )
--         idleString = idleString .. "[Sublimation Charging] "
--     elseif buffactive["Sublimation: Complete"] then
--         idleString = idleString .. "[Sublimation Complete] "
--     end

--     if toau_zones:contains(world.zone) then
--         idleSet = set_combine( idleSet, sets.IdleToAU)
--         idleString = idleString .. "[ToAU] "
--     end

--     windower.add_to_chat(8, idleString .. "**********")
--     equip(idleSet)
-- end



-- --  MIDCAST
-- function midcast(spell, action)

--     -- spell_element_match = spell.element == world.weather_element or spell.element == world.day_element
--     -- windower.add_to_chat(10, tostring(spell_element_match))
--     -- windower.add_to_chat(10, spell.element)

--     ---------------------
--     --  Healing Magic  --
--     ---------------------
--     if spell.skill == "Healing Magic" then
--         if string.find(spell.english,'Cure') then
--             if "Light" == world.weather_element or "Light" == world.day_element then
--                 windower.add_to_chat(8, "Cure Boost Active")
--                 equip(set_combine(sets.Midcast.Cure,sets.Midcast.LightWeather))
--             else
--                 equip(sets.Midcast.Cure)
--                 windower.add_to_chat(8, "No Cure Boost")
--             end
--         elseif string.find(spell.english,"Curaga") then
--             if spell.element == world.weather_element or spell_element == world.day_element then
--                 -- equip(set_combine(sets.Midcast.Curaga,sets.Midcast.LightWeather))
--                 equip(set_combine(sets.Midcast.Cure,sets.Midcast.LightWeather))
--             else
--                 -- equip(sets.Midcast.Curaga)
--                 equip(sets.Midcast.Cure)
--             end
--         elseif spell.english == "Cursna" then
--             equip(sets.Midcast.Cursna)
--             windower.add_to_chat(8, "Cursna Set")
--         else
--             equip(sets.Midcast.NASpell)
--             windower.add_to_chat(8, "NASpell Set")
--         end
--     end

--     -----------------------
--     --  Enhancing Magic  --
--     -----------------------
--     if spell.skill == "Enhancing Magic" then
--         if spell.english == "Stoneskin" then
--             equip(sets.Midcast.Stoneskin)
--             windower.add_to_chat(8, "Stoneskin Set")
--         elseif string.find(spell.english,"Regen") then
--             equip(sets.Midcast.Regen)
--             windower.add_to_chat(8, "Regen Set")
--         elseif spell.english == "Aquaveil" then
--             equip(sets.Midcast.Aquaveil)
--             windower.add_to_chat(8, "Aquaveil Set")
--         elseif barSpells:contains(spell.english) then
--             equip(sets.Midcast.BarSpell)
--             windower.add_to_chat(8, "Barspell Set")
--         else
--             equip(sets.Midcast.Enhancing)
--             windower.add_to_chat(8, "Enhancing Set")
--         end
--     end

--     ------------------------
--     --  Enfeebling Magic  --
--     ------------------------
--     if spell.skill == "Enfeebling Magic" then
--         if "Light" == spell.element then
--             if "Light" == world.weather_element or "Light" == world.day_element then
--                 equip(set_combine(sets.Midcast.Enfeebling,sets.Midcast.LightWeather))
--             end
--         -- elseif enfeebling_light:contains(spell.english) then
--         -- elseif enfeebling_dark:contains(spell.english) then
--         else
--             equip(sets.Midcast.Enfeebling)
--         end
--     end

--     ------------------------
--     --   Elemental Magic  --
--     ------------------------
--     if spell.skill == "Elemental Magic" then
--         -- windower.add_to_chat(8, spell.element)
--         -- windower.add_to_chat(8, 'Local weather: '.. world.weather_element)
--         if buffactive["Klimaform"] and (spell.element == world.weather_element or spell.element == world.day_element) then
--             equip(set_combine(sets.Midcast.ElementalAttack, set_combine(sets.Klimaform, {waist="Hachirin-no-obi"})))
--             -- windower.add_to_chat(8, 'Klima | Weather/day match')
--         elseif buffactive["Klimaform"] then
--             equip(set_combine(sets.Midcast.ElementalAttack, sets.Klimaform))
--             -- windower.add_to_chat(8, '********** [Klimaform Active] **********')
--         elseif spell.element == world.weather_element or spell.element == world.day_element then
--             equip(set_combine(sets.Midcast.ElementalAttack, {waist="Hachirin-no-obi"}))
--             -- windower.add_to_chat(8, 'Weather/day match')
--         else
--             equip(sets.Midcast.ElementalAttack)
--             -- windower.add_to_chat(8, 'No match')
--         end
--     end

--     ------------------------
--     --     Dark Magic     --
--     ------------------------
--     if spell.skill == "Dark Magaic" then
--         if buffactive["Klimaform"] and (spell.element == world.weather_element or spell.element == world.day_element) then
--             equip(set_combine(sets.Midcast.DarkMagic, set_combine(sets.Klimaform, {waist="Hachirin-no-obi"})))
--         elseif buffactive["Klimaform"] then
--             equip(set_combine(sets.Midcast.DarkMagic, sets.Klimaform))
--         elseif spell.element == world.weather_element or spell.element == world.day_element then
--             equip(set_combine(sets.Midcast.DarkMagic, {waist="Hachirin-no-obi"}))
--         else
--             equip(sets.Midcast.DarkMagic)
--         end
--     end
-- end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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

    --  Job Ability Reminders
    --  Scholar Specific
    -- state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
    -- state.Buff["Sublimation: Complete"]  = buffactive["Sublimation: Complete"]  or false
    -- state.Buff["Tabula Rasa"]   = buffactive["Tabula Rasa"] or false
    -- state.Buff["Klimaform"]     = buffactive["Klimaform"] or false
    -- state.Buff["Enlightenment"] = buffactive["Enlightenment"] or false

    -- --  Scholar Specific: Light Arts
    -- state.Buff["Altruism"]    = buffactive["Altruism"] or false
    -- state.Buff["Penury"]      = buffactive["Penury"] or false
    -- state.Buff["Perpetuance"] = buffactive["Perpetuance"] or false
    -- state.Buff["Rapture"]     = buffactive["Rapture"] or false
    -- state.Buff["Tranquility"] = buffactive["Tranquility"] or false

    -- --  Scholar Specific: Dark Arts
    -- state.Buff["Ebullience"]   = buffactive["Ebullience"] or false
    -- state.Buff["Immanence"]    = buffactive["Immanence"] or false
    -- state.Buff["Parsimony"]    = buffactive["Parsimony"] or false
    -- state.Buff["Focalization"] = buffactive["Focalization"] or false
    -- state.Buff["Equanimity"]   = buffactive["Equanimity"] or false

    -- --  White mage Specific
    -- state.Buff["Divine Seal"] = buffactive["Divine Seal"] or false

    -- --  Black Magic Specific
    -- state.Buff.["Elemental Seal"] = buffactive["Elemental Seal"] or false
end


--  ----------------------------------------------------------------------------------------------------
--  Information about custom commands
--  ----------------------------------------------------------------------------------------------------
function custom_instructions()
    add_to_chat(200, "Varrout's WHM Custom commands:")
    add_to_chat(200, "* Windows Key + 1: Raise Target")
    add_to_chat(200, "* Windows Key + 2: Reraise")
    add_to_chat(200, "* Windows Key + B: Toggle Magic Burst Mode (Default off)")
    add_to_chat(200, "* Windows Key + M: Show Map")
    add_to_chat(200, "* Windows Key + U: Unlock all equipment")
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
    -- state.DynamisLock = M(false, "Dynamis Neck Lock Mode")
    state.MagicBurst = M(false, "Magic Burst Mode")
    state.SixStepSc = M(false, "SixStepSc")


    --  Where @ is the Windows Key
    send_command('bind @b gs c toggle MagicBurst')      --  Windows Key + B: Toggle Magic Burst mode
    send_command('bind @m input /map')                  --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind @u gs c enable-all')             --  Windows Key + U: Unlock all equipment slots
    -- send_command('bind @x gs c toggle DynamisLock')  --  Windows Key + X: Activate Dynamis neck log mode
    send_command('bind @1 gs c raise')                  --  Windows Key + 1: Cast highest available Raise
    send_command('bind @2 gs c reraise')                --  Windows Key + 2: Cast highest available Reraise
    send_command('bind @3 gs c fragmentation')
    send_command('bind @4 gs c fusion')
    send_command('bind @5 gs c distortion')
    send_command('bind @6 gs c gravitation')
    send_command('bind @0 gs c six-step')
    

    custom_instructions()
end

function user_unload()
    send_command('unbind @b')
    send_command('unbind @m')
    send_command('unbind @u')
    -- send_command('unbind @x')
    send_command('unbind @1')
    send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
    send_command('unbind @6')
    send_command('unbind @0')
end

function init_gear_sets()
    include('Varrout_SCH_GearSets.lua')
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
    check_debuff_silenced(spell, eventArgs)
    check_weakened_sublimation(spell, eventArgs)
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
        if (spells_resistance:contains(spell.name)) then
            midcastSet = sets.midcast["Barspell"]
        elseif (sets.midcast[spell.name]) then
            midcastSet = sets.midcast[spell.name]
        elseif (sets.midcast[spellMap]) then
            midcastSet = sets.midcast[spellMap]
        else
            midcastSet = sets.midcast["Enhancing Magic"]
        end

    elseif (spell.skill == "Enfeebling Magic") then
        if (enfeebling_int:contains(spellMap)) then
            midcastSet = sets.midcast.EnfeeblingInt
        elseif (enfeebling_mnd:contains(spellMap)) then
            midcastSet = set.midcast.EnfeeblingMnd
        else
            midcastSet = set.midcast["Enfeebling Magic"]
        end

    elseif (spell.skill == "Elemental Magic") then
        midcastSet = sets.midcast["Elemental Magic"]

        --  If there is a weather or day match
        if (elementMatch) then
            midcastSet = set_combine(midcastSet, sets.midcast.Potency)
        end

        --  If Magic Burst mode is on
        if (state.MagicBurst.value) then
            midcastSet = set_combine(midcastSet, sets.midcast.MagicBurst)
        end

        --  If Klimaform is active
        if (buffactive["Klimaform"]) then
            midcastSet = set_combine(midcastSet, sets.Klimaform)
        end


    elseif (spell.skill == "Dark Magic") then
        if (sets.midcast[spell.name]) then
            midcastSet = sets.midcast[spell.name]
        elseif (sets.midcast[spellMap]) then
            midcastSet = sets.midcast[spellMap]
        else
            midcastSet = sets.midcast["Dark Magic"]
        end

        --  If there is a weather or day match
        if (elementMatch) then
            midcastSet = set_combine(midcastSet, sets.midcast.Potency)
        end

        --  If Magic Burst mode is on
        if (state.MagicBurst.value) then
            midcastSet = set_combine(midcastSet, sets.midcast.MagicBurst)
        end

        --  If Klimaform is active
        if (buffactive["Klimaform"]) then
            midcastSet = set_combine(midcastSet, sets.Klimaform)
        end
    end

    equip(midcastSet)
end


--  ----------------------------------------------------------------------------------------------------
--  IDLE
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
    idleSet = sets.idle

    --  If Player MP is less than 50%, equip latent refresh
    if player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.idle.RefreshLatent)
    end

    if not buffactive["Sublimation: Activated"] and areas.Cities:contains(world.area) then
        idleSet = sets.idle.Town
    end

    return get_custom_idle_set(idleSet)
end

function customize_resting_set(restingSet)
    return get_custom_idle_set(sets.resting)
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
    --  If there is a new Sublimation buff (active or complete), change
    --  idle gear to maximise charging or refresh
    if buff:contains("Sublimation") and gain then
        equip(get_custom_idle_set(sets.idle))
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

    --  Self skillchain
    elseif level_2_skillchains:contains(cmdParams[1]:lower()) or cmdParams[1]:lower() == 'six-step' then
        add_to_chat(123, "Self-Skillchain")
        self_skillchain(cmdParams[1]:lower())
        eventArgs.handled = true
        return

    elseif cmdParams[1]:lower() == 'enable-all' then
        add_to_chat(123, "Enabling all gear")
        equipment_unlock_all()
        equip(get_custom_idle_set(idleSet))
        state.SixStepSc:set(false)
        eventArgs.handled = true
        return

    else
        if cmdParams[1]:lower() ~= 'toggle' then
            add_to_chat(123, "Skipped")
        end
    end
end


--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)
    send_command('wait 2; input /lockstyle 001')
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
function get_custom_idle_set(currentSet)
    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        currentSet = set_combine(currentSet, sets.idle.ToAU)
    end

    --  If Sublimation is charging, equip gear to help charging
    if buffactive["Sublimation: Activated"] then
        currentSet = set_combine(currentSet, sets.idle.Sublimation)
    end

    return currentSet
end


--  ----------------------------------------------------------------------------------------------------
--                      Self Skillchains
--  ----------------------------------------------------------------------------------------------------
function self_skillchain(skillchain_type)
    add_to_chat(123, tostring(skillchain_type))
    if (skillchain_type == 'fragmentation') then
        self_skillchain_fragmentation()
    elseif (skillchain_type == 'fusion') then
        self_skillchain_fusion()
    elseif (skillchain_type == 'distortion') then
        self_skillchain_distortion()
    elseif (skillchain_type == 'gravitation') then
        self_skillchain_gravitation()
    elseif (skillchain_type == 'six-step') then
        self_skillchain_6_step()
    end
end

--  Fragmentation (Aero/Thunder)
function self_skillchain_fragmentation()
    local input_str = '' ..

    'input /p Self-skillchain: Fragmentation (Aero & Thunder);' ..
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
function self_skillchain_fusion()
    local input_str = '' ..

    'input /p Self-skillchain: Fusion (Fire & Light);' ..
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
function self_skillchain_distortion()
    local input_str = '' ..

    'input /p Self-skillchain: Distortion (Blizzard & Water);' ..
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
function self_skillchain_gravitation()
    local input_str = '' ..

    'input /p Self-skillchain: Gravitation (Darkness & Stone);' ..
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

--  Fire -> Stone -> Fire -> Stone -> Fire -> Stone
function self_skillchain_6_step()
    if not (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) or state.SixStepSc.value then
        return
    end

    equip(sets.precast.FC.SixStepSc)
    equipment_lock_all()
    add_to_chat(100, "Equipment locked!")

    state.SixStepSc:set(true)
    
    local input_str = '' ..

    'input /p Self-skillchain: 6-Step;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 32;' ..
    'input /ma "Fire" <t>;' ..
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Stone" <t>;' ..
    --  Skillchain 1: Scisson
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Fire" <t>;' ..
    --  Skillchain 2: Liquefaction
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Stone" <t>;' ..
    --  Skillchain 3: Scisson
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Fire" <t>;' ..
    --  Skillchain 4: Liquefaction
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Stone" <t>;' ..
    --  Skillchain 5: Scisson
    'wait 5.5;' ..
    'input /ja "Immanence" <me>;' ..
    'wait 2;' ..
    'input /ma "Fire" <t>;' ..
    --  Skillchain 6: Liquefaction
    'wait 4;' ..
    'input /echo Push Windows Key + U to enable equipment;'

    send_command(input_str)
end