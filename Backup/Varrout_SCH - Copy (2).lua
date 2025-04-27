--[[ *************************************************************
 Wren's SCH gearswap .lua for SuperNova FFXI
 Save as windower/addons/GearSwap/data/SCH.lua

  2016-07-24 OC  - First version. Commented to help newbies. :)
  2016-08-01 OC  - Hachirin-no-Obi, Rostrum Pumps
 2016-08-25 OC  - Sea Capes
 2016-12-02 OC  - Loquac. Earring, Stone Gorget
************************************************************* --]]
toau_zones =
S{
    "Leujaoam Sanctum",             --  Assault
    "Mamool Ja Training Grounds",   --  Assault
    "Lebros Cavern",                --  Assault
    "Periqia",                      --  Assault
    "Ilrusi Atoll",                 --  Assault
    "Nyzul Isle",                   --  Assault
    "Bhaflau Remnants",             --  Salvage
    "Arrapago Remnants",            --  Salvage
    "Silver Sea Remnants",          --  Salvage
    "Zhayolm Remnants",             --  Salvage
    -- "Aht Urhgan Whitegate",         --  Test
}

 --[[ ******************************************************
  Gearsets - define the various sets of gear we'll wear.
 Note that I am using Claustrum, so have no main swaps.
****************************************************** --]]
enfeebling_light =
S{
    "Paralyze",
    "Slow",
    "Silence",
    "Dia",
    "Dia II",
    "Diaga"
}

enfeebling_dark =
S{
    "Poison",
    "Poison II",
    "Blind",
    "Gravity",
    "Sleep",
    "Sleep II",
    "Break",
    "Bind",
    "Dispel"
}

naSpells =
S{
    "Poisona",
    "Paralyna",
    "Blindna",
    "Silena",
    "Stona",
    "Viruna"
}

barSpells =
S{
    "Barstone",
    "Barstonra",
    "Barwater",
    "Barwatera",
    "Baraero",
    "Baraera",
    "Barfire",
    "Barfira",
    "Barblizzard",
    "Barblizzara",
    "Barthunder",
    "Barthundra",
    "Barsleep",
    "Barsleepra",
    "Barpoison",
    "Barpoisonra",
    "Barparalyze",
    "Barparalyzra",
    "Barblind",
    "Barblindra",
    "Barsilence",
    "Barsilencera",
    "Barpetrify",
    "Barpetra",
    "Barvirus",
    "Barrira",
    "Baramnesia",
    "Baramnesra",
}

enhancing_dark =
S{
    "Blaze Spikes",
    "Ice Spikes",
    "Shock Spikes",
}

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
function get_sets()
    --  Use after spells when sublimation isn't charging.
    --  Focuses on auto-refresh, auto-regen, and reducing damage taken
    sets.Idle =
    {
        main        = "Bolelabunga",
        sub         = "Genbu's Shield",
        ammo        = "Homiliary",
        head        = "Befouled Crown",
        body        = "Jhakri Robe +2",
        hands       = { name        = "Chironic Gloves",
                        augments    = {'"Mag.Atk.Bns."+9','Attack+1','"Refresh"+1','Accuracy+13 Attack+13','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
        legs        = "Assid. Pants +1",
        feet        = "Chironic Slippers",
        neck        = "Loricate Torque +1",
        waist       = "Fucho-no-Obi",
        left_ear    = { name        = "Moonshade Earring",
                        augments    = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = "Infused Earring",
        left_ring   = "Defending Ring",
        right_ring  = "Sheltered Ring",
        back        = "Solemnity Cape",
    }

    sets.IdleToAU =
    {
        left_ring  = "Balrahn's Ring",
    }

    sets.Resting =
    {
        main        = "Boonwell Staff",
        sub         = "Ariesian Grip",
        ammo        = "Mana Ampulla",
        head        = "Orvail Corona +1",
        body        = "Chelona Blazer",
        hands       = "Nares Cuffs",
        legs        = "Nisse Slacks",
        feet        = "Chelona Boots",
        neck        = "Eidolon Pendant +1",
        waist       = "Austerity Belt",
        left_ear    = { name        = "Moonshade Earring",
                        augments    = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = "Infused Earring",
        left_ring   = "Angha Ring",
        right_ring  = "Star Ring",
        back        = "Felicitas Cape",
    }

    --  **************************************************************************************  --
    --                                    JOB ABILITIES                                         --
    --  **************************************************************************************  --

    --  Use this set when sublimation is charging.
    sets.Sublimation =
    {
        head        = "Academic's Mortarboard +2",
        body        = { name        = "Pedagogy Gown +3",
                        augments    = {'Enhances "Enlightenment" effect',}},
        ear2        = "Savant's Earring",
        waist       = "Embla Sash"
    }

    sets.SublimationCharging = set_combine(sets.Idle, sets.Sublimation)
    sets.SublimationResting = set_combine(sets.Resting, sets.Sublimation)

    sets.RaptureEbullience      = { head  = "Arbatel Bonnet" }
    sets.PerpetuanceImmanence   = { hands = "Arbatel Bracers +1" }
    sets.PenuryParsimony        = { legs  = "Arbatel Pants +1" }
    sets.Klimaform              = { feet  = "Arbatel Loafers +1" }
    sets.AltruismFocalization   = { head  = "Pedagogy Mortaboard +2" }
    sets.Enlightenment          = { body  = "Pedagogy Gown +2" }
    sets.TranquilityEquanimity  = { hands = "Pedagogy Bracers +3" }
    sets.TabulaRasa             = { legs  = "Pedagogy Pants +1" }
    sets.Stormsurge             = { feet  = "Pedagogy Loafers +1" }

    --  **************************************************************************************  --
    --                                    SPELL CASTING                                         --
    --  **************************************************************************************  --
    --                                      PRE-CAST                                            --
    --  **************************************************************************************  --

    sets.FastCast =
    {
        main={ name="Mpaca's Staff", augments={'Path: A',}},
        sub="Clerisy Strap",
        ammo="Incantor Stone",
        head="Acad. Mortar. +3",
        body="Merlinic Jubbah",
        hands="Acad. Bracers +2",
        legs={ name="Kaykaus Tights", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet={ name="Peda. Loafers +3", augments={'Enhances "Stormsurge" effect',}},
        neck="Baetyl Pendant",
        waist="Embla Sash",
        left_ear="Malignance Earring",
        right_ear="Etiolation Earring",
        left_ring="Medada's Ring",
        right_ring="Kishar Ring",
        back="Perimede Cape",
    }

    sets.FastCast.Enhancing = set_combine( sets.FastCast, {
        waist       = "Siegel Sash",
    } )

    sets.FastCast.Stoneskin = set_combine( sets.Enhancing, {
        head        = "Umuthi Hat",
        hands       = "Carapacho Cuffs",
    } )

    sets.FastCast.Cure = set_combine( sets.FastCast, {
        main        = "Vadose Rod",
        sub         = "Sors Shield",
        head        = { name        = "Vanya Hood",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = "Heka's Kalasiris",
        feet        = { name        = "Vanya Clogs",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        right_ear   = "Mendi. Earring",
        back        = "Pahtli Cape",
    } )

    sets.FastCast.Healing = set_combine( sets.FastCast, {
        back        = "Disperser's Cape",
    } )


    --  **************************************************************************************  --
    --                                      MID-CAST                                            --
    --  **************************************************************************************  --

    sets.Midcast = {}

    -- heal set for getting the most of our cures.
    -- Cure Potency, Healing Magic, Haste, Mind.
    sets.Midcast.Cure =
    {
        main        = "Vadose Rod",
        sub         = "Sors Shield",
        ammo        = "Quartz Tathlum +1",
        head        = { name        = "Vanya Hood",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = { name        = "Kaykaus Bliaut",
                        augments    = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands       = { name        = "Peda. Bracers +3",
                        augments    = {'Enh. "Tranquility" and "Equanimity"',}},
        legs        = "Acad. Pants +2",
        feet        = { name        = "Vanya Clogs",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck        = "Colossus's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Mendi. Earring",
        left_ring   = "Janniston Ring",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }

    sets.Midcast.LightWeather =
    {
        back        = "Twilight Cape",
        waist       = "Hachirin-no-Obi",
    }

    sets.Midcast.NASpell =
    {
        main        = { name        = "Coeus",
                        augments    = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Clerisy Strap",
        ammo        = "Incantor Stone",
        head        = { name        = "Vanya Hood",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = { name        = "Pedagogy Gown +2",
                        augments    = {'Enhances "Enlightenment" effect',}},
        hands       = { name        = "Pedagogy Bracers +3",
                        augments    = {'Enh. "Tranquility" and "Equanimity"',}},
        legs        = "Academic's Pants +2",
        feet        = { name        = "Vanya Clogs",
                        augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck        = "Colossus's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Healing Earring",
        left_ring   = "Sirona's Ring",
        right_ring  = "Haoma's Ring",
        back        = "Altruistic Cape",
    }

    sets.Midcast.Cursna = set_combine(sets.Midcast.NASpell,
    {
        neck        = "Debilis Medallion",
        left_ring   = "Haoma's Ring",
        right_ring  = "Haoma's Ring",
        back        = "Oretan. Cape +1",
    })

    sets.Midcast.Enfeebling =
    {
        main        = { name        = "Coeus",
                        augments    = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Enki Strap",
        ammo        = "Quartz Tathlum +1",
        head        = "Jhakri Coronal +1",
        body        = "Jhakri Robe +2",
        hands       = "Jhakri Cuffs +2",
        legs        = "Arbatel Pants +1",
        feet        = "Jhakri Pigaches +1",
        neck        = "Erra Pendant",
        waist       = "Casso Sash",
        left_ear    = "Lifestorm Earring",
        right_ear   = "Psystorm Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Kishar Ring",
        back        = { name        = "Lugh's Cape",
                        augments    = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    sets.MidcastEnfeeblingLight = set_combine( sets.Midcast.Enfeebling,
    {
        body        = "Academic's Gown +2",
    })

    sets.MidcastEnfeeblingDark = set_combine( sets.Midcast.Enfeebling,
    {
        legs        = "Academic's Pants +2"
    })

    sets.Midcast.Enhancing =
    {
        main        = "Bolelabunga",
        sub         = "Ammurapi Shield",
        ammo        = "Savant's Treatise",
        head        = "Befouled Crown",
        body        = { name        = "Pedagogy Gown +2",
                        augments    = {'Enhances "Enlightenment" effect',}},    --  Enh. Mag. eff. dur. +8%
        hands       = { name        = "Telchine Gloves",
                        augments    = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        legs        = { name        = "Telchine Braconi",
                        augments    = {'Enh. Mag. eff. dur. +9',}},
        feet        = { name        = "Telchine Pigaches",
                        augments    = {'Enh. Mag. eff. dur. +6',}},
        neck        = "Colossus's Torque",
        waist       = "Olympus Sash",
        left_ear    = "Augment. Earring",
        right_ear   = "Andoaa Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Stikini Ring",
        back        = "Fi Follet Cape",
    }

    sets.Midcast.BarSpell = set_combine( sets.Midcast.Enhancing,
    {
        hands       = { name        = "Chironic Gloves",
                        augments    = {'AGI+4','Crit.hit rate+1','"Refresh"+1','Accuracy+1 Attack+1',}},
        legs        = "Acad. Pants +2",
        --  legs        = limbus legs with barspell +15
        feet        = { name        = "Kaykaus Boots",
                        augments    = {'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
    })

    sets.Midcast.Stoneskin = set_combine( sets.Midcast.Enhancing,
    {
        legs        = "Haven Hose",
        neck        = "Nodens Gorget",
        waist       = "Siegel Sash",
        left_ear    = "Earthcry Earring",
    })

    sets.Midcast.Regen = set_combine( sets.Midcast.Enhancing,
    {
        main        = { name        = "Coeus",
                        augments    = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Fulcio Grip",
        head        = "Arbatel Bonnet",
        legs        = { name        = "Telchine Braconi",
                        augments    = {'"Regen" potency+3',}},
        back        = { name        = "Lugh's Cape",
                        augments    = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    })

    sets.Midcast.Aquaveil = set_combine(sets.Midcast.Enhancing,
    {
        main        = "Vadose Rod",
        sub         = "Genbu's Shield",
    })

    sets.Midcast.ElementalAttack = {
        main        = { name        = "Akademos",
                        augments    = {'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub         = "Enki Strap",
        ammo        = "Hydrocera",
        head        = "Pedagogy Mortaboard +2",
        body        = "Jhakri Robe +2",
        hands       = { name        = "Pedagogy Bracers +3",
                        augments    = {'Enh. "Tranquility" and "Equanimity"',}},
        legs        = "Jhakri Slops +2",
        feet        = "Jhakri Pigaches +1",
        neck        = "Argute Sole",
        waist       = "Aswang Sash",
        left_ear    = "Barkarole Earring",
        right_ear   = "Hecate's Earring",
        left_ring   = "Mallquis Ring",
        right_ring  = "Jhakri Ring",
        back        = { name        = "Lugh's Cape",
                        augments    = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    }

    sets.Midcast.ElementalAcc = sets.Midcast.ElementalAttack

    sets.Midcast.DarkMagic = set_combine(sets.Midcast.ElementalAttack,
    {
        main        = { name        = "Rubicundity",
                        augments    = {'Mag. Acc.+3','"Mag.Atk.Bns."+3','Dark magic skill +5','"Conserve MP"+2',}},
        sub         = "",
        neck        = "Erra Pendant",
        left_ring   = "Evanescence Ring",
    })

    sets.Midcast.Draspir = set_combine( sets.Midcast.DarkMagic,
    {
        head        = "Appetence Crown",
        right_ear   = "Hirudinea Earring",
    })
end

--[[ ******************************************************
 Equip functions - put on the sets we defined above, and
echo a note to our chat log so we know it worked.
****************************************************** --]]

-- equip our idle set
function equip_idle()
    idleSet = sets.Idle
    idleString = "********** [Idle] "

    if buffactive["Sublimation: Activated"] then
        idleSet = set_combine(idleSet, sets.Sublimation )
        idleString = idleString .. "[Sublimation Charging] "
    elseif buffactive["Sublimation: Complete"] then
        idleString = idleString .. "[Sublimation Complete] "
    end

    if toau_zones:contains(world.zone) then
        idleSet = set_combine( idleSet, sets.IdleToAU)
        idleString = idleString .. "[ToAU] "
    end

    windower.add_to_chat(8, idleString .. "**********")
    equip(idleSet)
end

-- equip out hMP set
function equip_rest()
    restSet = sets.Resting
    restString = "********** [Resting] "

    if buffactive["Sublimation: Activated"] then
        restSet = set_combine( restSet, sets.Sublimation )
        restString = restString .. "[Sublimation Charging] "
    elseif buffactive["Sublimation: Complete"] then
        restString = restString .. "[Sublimation Complete] "
    end

    windower.add_to_chat(8, restString .. "**********")
    equip(restSet)
end

--  PRECAST
function precast(spell, action)
    if spell.type:contains('Magic') then
        equip(sets.FastCast)
    elseif spell == "Enlightenment" then
        equip(sets.Enlightenment)
    elseif spell == "Tabula Rasa" then
        equip(sets.TabulaRasa)
    elseif spell == "Aeolean Edge" then
        equip(sets.Midcast.ElementalAttack)
    end
end

--  MIDCAST
function midcast(spell, action)

    -- spell_element_match = spell.element == world.weather_element or spell.element == world.day_element
    -- windower.add_to_chat(10, tostring(spell_element_match))
    -- windower.add_to_chat(10, spell.element)

    ---------------------
    --  Healing Magic  --
    ---------------------
    if spell.skill == "Healing Magic" then
        if string.find(spell.english,'Cure') then
            if "Light" == world.weather_element or "Light" == world.day_element then
                windower.add_to_chat(8, "Cure Boost Active")
                equip(set_combine(sets.Midcast.Cure,sets.Midcast.LightWeather))
            else
                equip(sets.Midcast.Cure)
                windower.add_to_chat(8, "No Cure Boost")
            end
        elseif string.find(spell.english,"Curaga") then
            if spell.element == world.weather_element or spell_element == world.day_element then
                -- equip(set_combine(sets.Midcast.Curaga,sets.Midcast.LightWeather))
                equip(set_combine(sets.Midcast.Cure,sets.Midcast.LightWeather))
            else
                -- equip(sets.Midcast.Curaga)
                equip(sets.Midcast.Cure)
            end
        elseif spell.english == "Cursna" then
            equip(sets.Midcast.Cursna)
            windower.add_to_chat(8, "Cursna Set")
        else
            equip(sets.Midcast.NASpell)
            windower.add_to_chat(8, "NASpell Set")
        end
    end

    -----------------------
    --  Enhancing Magic  --
    -----------------------
    if spell.skill == "Enhancing Magic" then
        if spell.english == "Stoneskin" then
            equip(sets.Midcast.Stoneskin)
            windower.add_to_chat(8, "Stoneskin Set")
        elseif string.find(spell.english,"Regen") then
            equip(sets.Midcast.Regen)
            windower.add_to_chat(8, "Regen Set")
        elseif spell.english == "Aquaveil" then
            equip(sets.Midcast.Aquaveil)
            windower.add_to_chat(8, "Aquaveil Set")
        elseif barSpells:contains(spell.english) then
            equip(sets.Midcast.BarSpell)
            windower.add_to_chat(8, "Barspell Set")
        else
            equip(sets.Midcast.Enhancing)
            windower.add_to_chat(8, "Enhancing Set")
        end
    end

    ------------------------
    --  Enfeebling Magic  --
    ------------------------
    if spell.skill == "Enfeebling Magic" then
        if "Light" == spell.element then
            if "Light" == world.weather_element or "Light" == world.day_element then
                equip(set_combine(sets.Midcast.Enfeebling,sets.Midcast.LightWeather))
            end
        -- elseif enfeebling_light:contains(spell.english) then
        -- elseif enfeebling_dark:contains(spell.english) then
        else
            equip(sets.Midcast.Enfeebling)
        end
    end

    ------------------------
    --   Elemental Magic  --
    ------------------------
    if spell.skill == "Elemental Magic" then
        -- windower.add_to_chat(8, spell.element)
        -- windower.add_to_chat(8, 'Local weather: '.. world.weather_element)
        if buffactive["Klimaform"] and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(set_combine(sets.Midcast.ElementalAttack, set_combine(sets.Klimaform, {waist="Hachirin-no-obi"})))
            -- windower.add_to_chat(8, 'Klima | Weather/day match')
        elseif buffactive["Klimaform"] then
            equip(set_combine(sets.Midcast.ElementalAttack, sets.Klimaform))
            -- windower.add_to_chat(8, '********** [Klimaform Active] **********')
        elseif spell.element == world.weather_element or spell.element == world.day_element then
            equip(set_combine(sets.Midcast.ElementalAttack, {waist="Hachirin-no-obi"}))
            -- windower.add_to_chat(8, 'Weather/day match')
        else
            equip(sets.Midcast.ElementalAttack)
            -- windower.add_to_chat(8, 'No match')
        end
    end

    ------------------------
    --     Dark Magic     --
    ------------------------
    if spell.skill == "Dark Magaic" then
        if buffactive["Klimaform"] and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(set_combine(sets.Midcast.DarkMagic, set_combine(sets.Klimaform, {waist="Hachirin-no-obi"})))
        elseif buffactive["Klimaform"] then
            equip(set_combine(sets.Midcast.DarkMagic, sets.Klimaform))
        elseif spell.element == world.weather_element or spell.element == world.day_element then
            equip(set_combine(sets.Midcast.DarkMagic, {waist="Hachirin-no-obi"}))
        else
            equip(sets.Midcast.DarkMagic)
        end
    end
end

--  AFTER CAST
function aftercast()
    equip_idle()
end

--  STATUS CHANGE
function status_change(new,old)
    if new == 'Resting' then
        equip_rest()
    else
        equip_idle()
    end
end

function lockMain()
    disable('main')
    disable('sub')
end

function unlockMain()
    enable('main')
    enable('sub')
end