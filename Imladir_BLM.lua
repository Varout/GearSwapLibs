function get_sets()
    mote_include_version = 2

    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')

    equipment_unlock_all()
    send_command('wait 4; input /lockstyleset 1')
end

function job_setup()
    --  Black Magic Specific
    state.Buff.ElementalSeal = buffactive['Elemental Seal'] or false
end

function user_setup()
    select_default_macro_book()

    state.CP = M(false, "CP Mode")                      --  CP Mode: WHM is mastered, so likely won't need this anymore
    state.Dynamis = M(false, "Dynamis Mode")            --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.MagicBurst = M(false, "MaigcBurst Mode")      --  Debug Mode: Helpful for outputting information in the LUA. Not set up

    send_command('bind @c gs c toggle CP')              --  Windows Key + C: Toggle CP Mode
    send_command('bind @x gs c toggle Dynamis')         --  Windows Key + X: Toggle Dynamis Mode
    send_command('bind @m gs c toggle MagicBurst')      --  Windows Key + M: Toggle MagicBurst Mode

    add_to_chat(200, "Hello Imladir. Welcome to your GearSwap.")
    add_to_chat(200, "Your menu options are as follows:")
    add_to_chat(200, "* Windows Key + C: Toggle CP Lock Mode")
    add_to_chat(200, "* Windows Key + X: Toggle Dynamis Exp Mode")
    add_to_chat(200, "* Windows Key + M: Toggle MagicBurst Mode")
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @m')
end

function init_gear_sets()

    --  **************************************************************************************  --
    --                                    GENERAL SETS                                          --
    --  **************************************************************************************  --
    sets.CP = {
        back = "Aptitude Mantle"
    }

    sets.JSENeck = {
        "Sorcerer's Stole"
    }
    sets.idle = {
        main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Ischemia Chasu.",
        hands="Psycloth Manillas",
        legs="Assid. Pants +1",
        feet="Hippomenes Socks",
        neck="Bathy Choker",
        waist="Fucho-no-Obi",
        left_ear="Friomisi Earring",
        right_ear="Goetia Earring",
        left_ring="Strendu Ring",
        right_ring="Shiva Ring",
        back="Toro Cape",
    }
    sets.latentRefresh = {
        wasit = 'Fucho-no-Obi'
    }
    sets.weatherBoost = {}


    --  **************************************************************************************  --
    --                                    JOB ABILITIES                                         --
    --  **************************************************************************************  --
    sets.precast = {}




    --  **************************************************************************************  --
    --                                    SPELL CASTING                                         --
    --  **************************************************************************************  --
    --                                      PRE-CAST                                            --
    --  **************************************************************************************  --





    --  **************************************************************************************  --
    --                                    SPELL CASTING                                         --
    --  **************************************************************************************  --
    --                                      MID-CAST                                            --
    --  **************************************************************************************  --


    sets.precast["Trust"] = {}

    sets.precast["Manafont"] = { body = "Archmage's Coat", }

    sets.precast.FC = {
        main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Merlinic Jubbah",
        hands="Psycloth Manillas",
        legs="Orvail Pants +1",
        feet="Regal Pumps +1",
        neck="Bathy Choker",
        waist="Fucho-no-Obi",
        left_ear="Loquac. Earring",
        right_ear="Goetia Earring",
        left_ring="Strendu Ring",
        right_ring="Shiva Ring",
        back="Veela Cape",
    }

    sets.precast["Enhancing Magic"] = set_combine(sets.precast.FC, {

    })
    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
        legs = "Querkening Brais",
    })
    sets.precast["Dark Magic"] = set_combine(sets.precast.FC, {

    })
    sets.precast["Enfeebling Magic"] = set_combine(sets.precast.FC, {

    })
    sets.precast["Elemental Magic"] = set_combine(sets.precast.FC, {
        head="Wicce Petasos",
        feet="Spaekona's Sabots +1",
        neck="Stoicheion Medal",
    })

    sets.midcast.FC = {         --  Magic Accuracy focus
        main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Helios Band",
        body="Merlinic Jubbah",
        hands="Psycloth Manillas",
        legs={ name="Arch. Tonban", augments={'Increases Elemental Magic debuff time and potency',}},
        feet="Mallquis Clogs",
        neck="Sorcerer's Stole",
        waist="Aswang Sash",
        left_ear="Gwati Earring",
        right_ear="Goetia Earring",
        left_ring="Strendu Ring",
        right_ring="Shiva Ring",
        back="Toro Cape",
    }
    sets.midcast["Enhancing Magic"] = set_combine(sets.midcast.FC, {
        back = "Perimede Cape",
        feet = "Regal Pumps +1",
    })
    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {

    })
    sets.midcast["Regen"] = set_combine(sets.midcast["Enhancing Magic"], {
        main = "Bolelabunga",
        sub = "Culminus",
    })
    sets.midcast["Dark Magic"] = set_combine(sets.midcast.FC, {
        hands = "Archmages' Gloves"
    })
    sets.midcast["Drain"] = set_combine(sets.midcast["Dark Magic"], {
        left_ear = "Hirudinea Earring",
        right_ear = "Gwati Earring",
        waist = "Fucho-no-Obi"
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
    sets.midcast["Enfeebling Magic"] = set_combine(sets.midcast.FC, {

    })
    sets.midcast["Elemental Magic"] = {
        main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Helios Band",
        body="Merlinic Jubbah",
        hands="Psycloth Manillas",
        legs="Spaekona's Tonban",
        feet="Spaekona's Sabots +1",
        neck="Deviant Necklace",
        waist="Aswang Sash",
        left_ear="Friomisi Earring",
        right_ear="Moldavite Earring",
        left_ring="Strendu Ring",
        right_ring="Shiva Ring",
        back="Toro Cape",
    }
    sets.midcast.MagicBurst = {
        neck = "Mizukage-no-Kubikazari",
        hands = "Ea Cuffs",
        feet = "Ea Pigaches",
    }

    sets.midcast["Headling Magic"] = {
        main = "Chatoyant Staff",
        sub = "Enki Strap",
        ammo = "Mana Ampulla",
        head = "Befouled Crown",
        neck = "Deviant Necklance",
        left_ear = "Gwati Earring",
        right_ear = "Zennaroi Earring",
        body = "Merlinic Jubbah",
        hands = "Ea Cuffs",
        left_ring = "Hale Ring",
        right_ring = "Tamas Ring",
        back = "Altruistic Cape",
        waist = "Witch Sash",
        legs = "Assiduity Pants +1",
        feet = "Regal Pumps +1",
    }
    sets.midcast["Cure"] = set_combine(sets.midcast["Headling Magic"], {})
end

function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    local equipSet

    if spell.skill == "Elemental Magic" then
        equipSet = sets.midcast["Elemental Magic"]
        if state.MagicBurst.current == "on" then
            equipSet = set_combine(equipSet, sets.midcast.MagicBurst)
            -- add_to_chat(200, "Magic BURST")
        end
        eventArgs.handled = true
        equip(equipSet)
        return
    end
end

function customize_idle_set(idleSet)
    check_special_ring_equipped()

    --  Checking special states
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latentRefresh)
    end

    return idleSet
end

-- function sub_job_change(newSubjob, oldSubjob)
-- end

function select_default_macro_book()
    -- Default macro set/book
    -- set_macro_page(1, 4)
end