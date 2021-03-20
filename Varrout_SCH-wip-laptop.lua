
player_tp_lock = 700
--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
    include("common_lists.lua")
end

--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()

    --  Scholar Specific
    state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
    state.Buff["Sublimation: Complete"]  = buffactive["Sublimation: Complete"]  or false
    state.Buff["Tabula Rasa"] = buffactive["Tabula Rasa"] or false
    state.Buff["Klimaform"] = buffactive["Klimaform"] or false
    state.Buff["Enlightenment"] = buffactive["Enlightenment"] or false


    --  Scholar Specific: Light Arts
    state.Buff["Altruism"] = buffactive["Altruism"] or false
    state.Buff["Penury"] = buffactive["Penury"] or false
    state.Buff["Perpetuance"] = buffactive["Perpetuance"] or false
    state.Buff["Rapture"] = buffactive["Rapture"] or false
    state.Buff["Tranquility"] = buffactive["Tranquility"] or false

    --  Scholar Specific: Dark Arts
    state.Buff["Ebullience"] = buffactive["Ebullience"] or false
    state.Buff["Immanence"] = buffactive["Immanence"] or false
    state.Buff["Parsimony"] = buffactive["Parsimony"] or false
    state.Buff["Focalization"] = buffactive["Focalization"] or false
    state.Buff["Equanimity"] = buffactive["Equanimity"] or false

    --  White mage Specific
    state.Buff["Divine Seal"] = buffactive["Divine Seal"] or false

    --  Black Magic Specific
    state.Buff.["Elemental Seal"] = buffactive["Elemental Seal"] or false
end

--  ----------------------------------------------------------------------------------------------------
--
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options("Normal")
    state.HybridMode:options("Normal")
    state.CastingMode:options("Normal")
    state.IdleMode:options("Normal")

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    state.CP = M(false, "CP Mode")              --  CP Mode: SCH is mastered, so likely won"t need this anymore
    state.Dynamis = M(false, "Dynamis Mode")    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.Debug = M(false, "Debug Mode")        --  Debug Mode: Helpful for outputting information in the LUA. Not set up
    state.MB = M(false, "MB Mode")              --  MB Mode: Focusing nukes to be magic bursts

    --  Where @ is the Windows Key
    send_command("bind @c gs c toggle CP")      --  Windows Key + C: Toggle CP Mode
    send_command("bind @x gs c toggle Dynamis") --  Windows Key + X: Toggle Dynamis Mode
    send_command("bind @m input /map")          --  Windows Key + M: Show map, because I"m lazy af
    send_command("bind @z gs c toggle Debug")   --  Windows Key + Z: Toggle Debug Mode
    send_command("bind @b gs c toggle MB")      --  Windows Key + B: Toggle MB Mode

    --  Set up lockstyle set
    -- randomise_lockstyle()
end

function user_unload()
    send_command("unbind @c")
    send_command("unbind @x")
    send_command("unbind @m")
    send_command("unbind @z")
    send_command("unbind @b")
end

function init_gear_sets()

    --  Gear sets for specific conditions and commands
    --  Neck equipment to lock in while in dynamis
    sets.JSENeck = {
        neck       = ""
    }

    --  Equipment that enhances the charge rate of Sublimation
    sets.Sublimation = {
        head = "Academic's Mortarboard +2",
        body = { name = "Pedagogy Gown +3",
                 augments = {"Enhances "Enlightenment" effect",}},
        ear2 = "Savant's Earring",
        waist = "Embla Sash"
    }

    --  Equipment only active during reives
    sets.Reives = {
        neck = "Arciela's Grace +1"
    }

    --  Set for summoning Trusts. All iLevel 119
    sets.trust = {}

    sets.idle = {}

    sets.resting = {}

    --------------------
    --  precast Sets  --
    --------------------
    sets.precast = {}

    sets.precast.FC = {}

    sets.precast["Enhancing Magic"] = set_combine(sets.precast.FC, {})

    sets.precast["Stoneskin"] = set_combine(sets.precast["Enhancing Magic"], {})

    sets.precast["Healing Magic"] = set_combine(sets.precast.FC, {})

    sets.precast["Cure"] = set_combine(sets.precast["Healing Magic"], {})

    sets.precast["Dark Magic"] = set_combine(sets.precast.FC, {})

    sets.precast["Elemental Magic"] = set_combine(sets.precast.FC, {})

    --------------------
    --  midcast Sets  --
    --------------------
    sets.midcast = {}

    --  The Twilight Cape gives an extra 5% on matched day/weather effect
    --  Hachirin-no-Obi gives 10% on matched day/weather effect
    sets.midcast.WeatherBoost = {
        main = "",
        back = "Twilight Cape",
        waist = "Hachirin-no-Obi",
    }

    --  Complete different sets for base cure potency, and set for day/weather match
    sets.midcast.Cure = {
    }

    sets.midcast.CureBonus = {
    }

    sets.midcast.NASpell = {
    }

    sets.midcast.Cursna = set_combine(sets.midcast.NASpell, {
    })

    sets.midcast["Enhancing Magic"] = {
    }

    sets.midcast.Barspell = set_combine(sets.midcast["Enhancing Magic"], {
    })

    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
    })

    sets.midcast["Regen"] = set_combine(sets.midcast["Enhancing Magic"], {
    })

    sets.midcast["Shell"] = set_combine(sets.midcast["Enhancing Magic"], {
        left_ring  = "Sheltered Ring",
    })

    sets.midcast["Protect"] = set_combine(sets.midcast["Enhancing Magic"], {
        left_ring  = "Sheltered Ring",
    })

    sets.midcast["Aquaveil"] = set_combine(sets.midcast["Enhancing Magic"], {
        main       = "Vadose Rod",
    })

    --  Base set for magic accuracy for Divine and Enfeebling
    sets.midcast["Enfeebling Magic"] = {}

    sets.midcast["Divine Magic"] = {}

    sets.midcast["Elemental Magic"] = {}

    sets.midcast["Dark Magic"] = {}

    sets.midcast.MB = {}

    --  Melee sets
    sets.engaged = {}

    sets.melee.WS = {}
end


function job_precast(spell, action, spellMap, eventArgs)
    if player.tp > player_tp_lock then
        melee_equip_lock()
    end

    check_special_ring_equipped()

    if spell.action_type == "Magic" and buffactive["Silence"] then
        -- If silenced, use what"s available to remove it
        cancel_spell()
        if player.inventory["Catholicon"] ~= nil then
            send_command("input /item "Catholicon" <me>")
            send_command("input /echo *!! Silenced ~ Using Catholicon @ "..player.inventory["Catholicon"].count.." Left !!*")
        elseif player.inventory["Echo Drops"] ~= nil then
            send_command("input /item "Echo Drops" <me>")
            send_command("input /echo *!! Silenced ~ Using Echo Drops @ "..player.inventory["Echo Drops"].count.." Left !!*")
        elseif player.inventory["Remedy"] ~= nil then
            send_command("input /item "Remedy" <me>")
            send_command("input /echo *!! Silenced ~ Using Remedy @ "..player.inventory["Remedy"].count.." Left !!*")
        else
            send_command("input /echo *!! Silenced ~ No items to remove it !!*")
        end
        eventArgs.cancel = true
        return
    elseif spell.name == "Sublimation" and buffactive["Weakness"] then
        --  If weakend, don"t waste your Sublimation
        cancel_spell()
        send_command("input /echo *!! Weakend ~ Cancelling Sublimation !!*")
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    end
end



function job_post_midcast(spell, action, spellMap, eventArgs)

    if player.tp > player_tp_lock then
        melee_equip_lock()
    end

    if spell.action_type == "Magic" then
        spell_element_match = spell.element == world.weather_element or spell.element == world.day_element

        if spell.skill == "Enfeebling Magic" then
            equipSet = sets.midcast["Enfeebling Magic"]
        elseif spell.skill == "Divine Magic" then
            equipSet = sets.midcast["Divine Magic"]
        elseif spell.skill == "Elemental Magic" then
            equipSet = sets.midcast["Elemental Magic"]
        elseif spell.skill == "Dark Magic" then
            equipSet = setes.midcast["Dark Magic"]
        end

        --  Combine sets for matched day and/or weather to spell element
        if spell_element_match then
            equipSet = set_combine(equipSet, sets.midcast.WeatherBoost)
        end

        --  Magic Burst & Klimaform
        if spell.skill == "Elemental Magic" or spell.skill == "Dark Magic" then
            --  Combine sets for Magic Bursts
            if state.MB.current == "on" then
                equipSet = set_combine(equipSet, sets.midcast.MB)
            end

            --  Combine for Klimaform
            if state.Buff["Klimaform"] then
                equipSet = set_combine(equipSet, sets.midcast.Klimaform)
            end
        end
    end

    if spell.type == "Trust" then
        equip(sets.trust)
    end
end


function customize_idle_set(idleSet)
    -- if state.Debug.current == "on" then
    --    windower.add_to_chat(9, "Currently in: " .. world.area)
    -- end

    if player.tp < player_tp_lock then
        melee_equip_unlock()
    end
    check_special_ring_equipped()

    --  Checking special states
    if state.CP.current == "on" then
        equip(sets.CP)
        disable("back")
    else
        enable("back")
    end

    if state.Dynamis.current == "on" then
        equip(sets.JSENeck)
        disable("neck")
    else
        enable("neck")
    end

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
    if newStatus == "Engaged" then
        melee_equip_lock()
    elseif oldStatus == "Engaged" then
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

    -- if cmdParams[1]:lower() == "test" then
    --     add_to_chat(100, reraiseIV)
    -- end

    --  Make Reraise easy to handle
    if (string.find(cmdParams[1]:lower(), "rr")) and (not buffactive["Reraise"]) then
        local reraise_level = cmdParams[1]:gsub("rr", "")
        if reraise_level == "0" then
            send_command("@input /echo *** Cancelling: No reraise level stated. ***")
        elseif reraise_level == "1" then
            send_command("@input /ma "Reraise" <me>")
        elseif reraise_level == "2" then
            send_command("@input /ma "Reraise II" <me>")
        elseif reraise_level == "3" then
            send_command("@input /ma "Reraise III" <me>")
        else
            send_command("@input /echo *** Cancelling: Something weird happened. ***")
        end
        eventArgs.handled = true
        return
    elseif cmdParams[1]:lower() == "reraise" then
        send_command("@input /echo *** Cancelling: Reraise already active. ***")
        eventArgs.handled = true
        return
    end

    --  Make Raise easy to handle
    if cmdParams[1]:lower() == "raise" then
        local raise_level = cmdParams[2]
        if reraise_level == "nil" then
            send_command("@input /echo *** Cancelling. No Raise Level Stated. ***")
        elseif reraise_level == "1" then
            send_command("@input /ma "Raise" <me>")
        elseif reraise_level == "2" then
            send_command("@input /ma "Raise II" <me>")
        elseif reraise_level == "3" then
            send_command("@input /ma "Raise III" <me>")
        else
            send_command("@input /echo *** What are you even doing? ***")
        end
        eventArgs.handled = true
        return
    end
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
function check_special_ring_equipped()
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
        enable("left_ring")
        enable("right_ring")
    end
end

--  Lock weapon and sub slots
function melee_equip_lock()
    disable("main")
    disable("sub")
end

--  Unlock weapon and sub slots
function melee_equip_unlock()
    -- add_to_chat(30, "Unlocking melee")
    enable("main")
    enable("sub")
end