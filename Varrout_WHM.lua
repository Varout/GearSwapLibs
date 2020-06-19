-- -- Local Settings, setting the zones prior to use
include('common_lists.lua')
special_ring_equipped = false

abilityCancel = 
S{
    "Addendum: White",
}

abilityNothing = S{
    "Light Arts",
    "Dark Arts",
    "Afflatus Misery",
    "Afflatus Solace",
    "Accession",
    "Penury",
    "Celerity",
    "Sublimation",
    "Asylum",
    "Sacrosanctity",
    "Martyr",
    "Echo Drops",
    "Remedy",
    "Divine Caress",
    "Divine Seal",
    "Addendum: Black",
}

function get_sets()

    sets.Trust = 
    {
        main    = "Bolelabunga",
        sub     = "Ammurapi Shield",
        ranged  = "",
        ammo    = "Homiliary",
        head    = "Inyanga Tiara +2",
        body    = "INyanga Jubbah +2",
        hands   = "Inyanga Dastanas +2",
        legs    = "Inyanga Shalwar +2",
        feet    = "Inyanga Crackows +2"
    }

    sets.Idle = 
    {
        main    = "Bolelabunga",
        sub     = "Ammurapi Shield",
        ammo    = "Homiliary",
        head    = "Inyanga Tiara +2",
        neck    = "Loricate Torque +1",
        ear1    = "Infused Earring",
        ear2    = "Moonshade Earring",
        body    = "Theophany Briault +3",
        hands   = "Inyanga Dastanas +2",
        ring1   = "Defending Ring",
        ring2   = "Inyanga Ring",
        back    = { name        = "Alaunus's Cape",
                    augments    = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
        waist   = "Fucho-no-obi",
        legs    = "Inyanga Shalwar +2",
        feet    = "Inyanga Crackows +2"
    }

    sets.Resting = 
    {
        main    = "Boonwell Staff",      -- +18
        sub     = "Ariesian Grip",       -- +1
        ammo    = "Mana Ampulla",        -- +2
        head    = "Orvail Corona +1",    -- +4
        neck    = "Eidolon Pendant +1",  -- +6
        ear1    = "Glorious Earring",    -- +0
        ear2    = "Moonshade Earring",   -- +0
        body    = "Chelona Blazer",      -- +8   (Nice to have +1)
        hands   = "Nares Cuffs",         -- +4
        ring1   = "Star Ring",           -- +1
        ring2   = "Angha Ring",          -- +2
        back    = "Felicitas Cape",      -- +3
        waist   = "Austerity Belt",      -- +4
        legs    = "Nisse Slacks",        -- +4
        feet    = "Chelona Boots"        -- +5   (Nice to have +1)
    }
    
--  Setting the base set: Precast   
    sets.Precast = {}

--  --------------------
--  AF/Relic JA Sets
--  --------------------
    sets.Precast.Devotion    = { head = "Piety Cap +3" }
    sets.Precast.Benediction = { body = "Piety Briault +3" }
    
    --  Total fast cast for this set is 63%.  Not sure what the cap is.
    sets.Precast.FastCast =
    {
        main    = "Grioavolr",                          -- FC +04%
        sub     = "Clerisy Strap",                      -- FC +02%
        ammo    = "Incantor Stone",                     -- FC +02%
        head    = "Revealer's Crown",                   -- FC +05%
        neck    = "Cleric's Torque",                    -- FC +06%
        ear1    = "Loquac. Earring",                    -- FC +02%
        ear2    = "Infused Earring",                    -- Regen +1, Evasion +10
        body    = "Inyanga Jubbah +2",                  -- FC +14%
        hands   = "Fanatic Gloves",                     -- FC +07%
        ring1   = "Evanescence Ring",                   -- Spell Interruption down 05%
        ring2   = "Kishar Ring",                        -- FC +04%
        back    = { name        = "Alaunus's Cape",     -- FC +10%, Spell Interruption down 10%
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist   = "Witful Belt",                        -- FC +03%, Quickcast +3%
        legs    = { name="Kaykaus Tights",              -- FC +06%, Spell Interruption down 10%
                    augments    = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet    = "Regal Pumps +1"                      -- FC +04% - +06%       (Nice to have +1)
    }

    sets.Precast.Enhancing = set_combine(sets.Precast.FastCast,
    {
        head    = "Umuthi Hat",
        waist   = "Siegel Sash"
    })

    sets.Precast.Stoneskin = set_combine(sets.Precast.Enhancing,
    {
        head    = "Umuthi Hat",              --  Stoneskin Cast Time -15%
        hands   = "Carapacho Cuffs"          --  Stoneskin Cast Time -15%
    })

    sets.Precast.Cure = set_combine(sets.Precast.FastCast,
    {
        main    = "Ababinili +1",            --  Cure Cast Time -11%
        sub     = "Clerisy Strap",           --  FC +02%
        head    = "Piety Cap +3",            --  Cure Cast Time -15%, Haste +6%
        ear1    = "Nourishing Earring +1",   --  Cure Cast Time -4%
        ear2    = "Mendicant's Earring",     --  Cure Cast Time -5%, Conserve MP +3
        body    = "Heka's Kalasiris",        --  Cure Cast Time -15%
        feet    = "Hygieia Clogs +1"         --  Cure Cast Time -18%, Haste +3%, Conserve MP +5
    })
    
    sets.Precast.NASpell = set_combine(sets.Precast.FastCast,
    {
        legs    = "Ebers Pantaloons +1"      --  Healing Magic Cast Time -13%
    })
    --------------------
    --  Midcast Sets  --
    --------------------
    sets.Midcast = {}
    
    --  The Twilight Cape gives an extra 5% on matched day/weather effect
    --  This may or may not work with the current cure set depending on
    --  which pieces are being used to hit the Cure Pot. I cap of 50%.
    sets.Midcast.WeatherBoost =
    {
        back  = "Twilight Cape",
        waist = "Hachirin-no-Obi"
    }
    
    -- It seems as though Job Point Gifts don't affect the immediate cure potency cap.
    -- So the goal is to try and hit the 50% cap for normal cure without using slots
    -- that have Cure Pot. II available in them.

    --  Boost Order: Cure%, Healing Magic, MND, VIT
    --  Cure Pot. I: 50%, Cure Pot. II: 13%, Healing Magic +120 (Total: 599), MND +177 (Game is saying +180???) (Total: 292)
    sets.Midcast.Cure = 
    {
        main    = "Queller Rod",                             --  Cure +10%, Cure Pot. II +2%, Healing Magic +15, MND +6, Enmity -10
        sub     = "Sors Shield",                             --  Cure +3%, Cure Cast Time -5%, Enmity -5
        ammo    = "Quartz Tathlum +1",                       --  MND +4
        head    = "Vanya Hood",                              --  Cure +10%, Healing Magic +20, MND +27, Haste +6%
        neck    = "Colossus's Torque",                       --  Healing Magic +7 (Lightsday +10.  There is a torque which gives +10 to all magic skills)
        ear1    = "Glorious Earring",                        --  Cure Pot. II +2%, MP +30, Enmity -5
        ear2    = "Mendicant's Earring",                     --  Cure +5%, Conserve MP +2
        -- body    = "Ebers Bliaud +1", 	                 --  Allfatus Solace +14
        body    = "Theophany Briault +3",                    --  Cure Pot. II +6%, MND +39, Haste +3%, Enmity -6
        hands   = "Theophany Mitts +3",                      --  Cure Pot. II +4%, Healing Magic +21, MND +48, Haste +3%, Enmity -7
        ring1   = "Janniston Ring",                          --  Cure Pot. II +5%, Enmity -7                        (Nice to have +1)
        ring2   = "Menelaus's Ring",                         --  Cure +5%, Healing Magic +15, Cursna +20
        back    = { name        = "Alaunus's Cape",          --  Cure +10%, MND +30
                    augments    = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
        waist   = "Bishop's Sash",                           --  Healing Magic +5
        legs    = "Ebers Pantaloons +1",                     --  MND +33, Haste +5%, Convert 6% Cure HP to MP
        feet    = { name        = "Vanya Clogs",             --  Path A Augment: Cure +12%, Healing Magic +20, MND +19, Haste +3%, Enmity -6
                    augments    = {'MP+50','"Cure" potency +7%','Enmity-6',}}
    }

    sets.Midcast.CureBonus = 
    {
        main        = { name        = "Queller Rod", 
                        augments    = {'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
        sub         = "Sors Shield",
        ammo        = "Quartz Tathlum +1",
        head        = "Ebers Cap +1",
        body        = "Theo. Briault +3",
        hands       = "Theophany Mitts +3",
        legs        = "Ebers Pantaloons +1",
        feet        = { name        = "Kaykaus Boots", 
                        augments    = {'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
        neck        = "Cleric's Torque",
        waist       = "Hachirin-no-Obi",
        left_ear    = "Glorious Earring",
        right_ear   = "Mendi. Earring",
        left_ring   = "Janniston Ring",
        right_ring  = "Menelaus's Ring",
        back        = "Twilight Cape",
    }

--  Boost Order: Cure%, MND, Healing Magic, VIT.
--  NEED TO UPDATE
    -- sets.Midcast.Curaga = set_combine(sets.Midcast.Cure,
    -- {
    --     head="Theophany Cap +3",
    --     neck="Colossus's Torque",
    --     ear1="Beatific Earring",
    --     ear2="Lifestorm Earring",
    --     body="Ebers Bliaud +1",
    --     hands="Bokwus Gloves",
    --     ring1="Ephedra Ring",
    --     ring2="Sirona's Ring",
    --     back="Altruistic Cape",
    --     waist="Bishop's Sash",
    --     legs="Ebers Pantaloons +1",
    --     feet="Piety Duckbills"
    -- })
    
    --  Healing Magic: 625
    sets.Midcast.NASpell =
    {
        main    = "Yagrush",                --  AoE Status Removal
        sub     = "Sors Shield",            --  Nothing special, just some extra defense and evasion
        ammo    = "Incantor Stone",         --  Healing Magic +00
        head    = "Ebers Cap +1",           --  Healing Magic +00, Divine Veil +22%
        neck    = "Colossus's Torque",      --  Healing Magic +07 (Lightsday +10.  There is a torque which gives +10 to all magic skills)
        ear1    = "Beatific Earring",       --  Healing Magic +04
        ear2    = "Healing Earring",        --  Healing Magic +03
        body    = "Ebers Bliaud +1",        --  Healing Magic +24
        hands   = "Theophany Mitts +3",     --  Healing Magic +21
        ring1   = "Sirona's Ring",          --  Healing Magic +10
        ring2   = "Menelaus's Ring",        --  Cure +5%, Healing Magic +15, Cursna +20
        back    = "Altruistic Cape",        --  Healing Magic +05
        waist   = "Bishop's Sash",          --  Healing Magic +05
        legs    = "Ebers Pantaloons +1",    --  Healing Magic +00, Divine Benison +2
        feet    = { name        = "Vanya Clogs",        --  Healing Magic +40, Cursna +5
                    augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}                 
    }

    sets.Midcast.Caress = set_combine(sets.Midcast.NASpell,
    {
        hands="Ebers Mitts +1"              --  Divine Caress +1
    })

    --  Slot missing: Main - Gambanteinn i119 III: Cursna +100
    --  Totals:
    --  ** Healing Magic    620
    --  ** Cursna          +116
    sets.Midcast.Cursna = set_combine(sets.Midcast.NASpell,
    {
        -- main="Gambanteinn",                          --  Cursna +100 (Very very nice to have.  Goals.  But would I really use this in place of a Yagrush?)
        head    = "Vanya Hood",                         --  Healing Magic +20, Cursna +0
        neck    = "Debilis Medallion",                  --  Healing Magic +00, Cursna +15
        hands   = "Fanatic Gloves",                     --  Healing Magic +10, Cursna +15
        ring1   = "Haoma's Ring",                       --  Healing Magic +08, Cursna +15
        ring2   = "Menelaus's Ring",                    --  Healing Magic +15, Cursna +20
        back    = { name        = "Alaunus's Cape",     --  Healing Magic +00, Cursna +25
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        legs    = "Theophany Pantaloons +3",            --  Healing Magic +00, Cursna +21
        feet    = { name        = "Vanya Clogs",        --  Healing Magic +40, Cursna +5
                    augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}        -- Gendewitha Galoshes +1: +10 Cursna.  Not sure if it'll be better than what I already have                     
    })
    
    sets.Midcast.Enhancing = 
    {
        main    = "Beneficus",                  --  Enhancing Maigc +15
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        ammo    = "Hydrocera",                  --  Enhancing Maigc +0
        head    = "Befouled Crown",             --  Enhancing Maigc +16
        neck    = "Colossus's Torque",          --  Enhancing Maigc +7
        ear1    = "Augmenting Earring",         --  Enhancing Maigc +3
        ear2    = "Andoaa Earring",             --  Enhancing Maigc +5
        body    = "Anhur Robe",                 --  Enhancing Maigc +12
        hands   = "Inyanga Dastanas +2",        --  Enhancing Maigc +20
        ring1   = "Stikini Ring",               --  All magic +5
        ring2   = "Stikini Ring",               --  All magic +5
        back    = "Fi Follet Cape",             --  Enhancing Maigc +8
        waist   = "Olympus Sash",               --  Enhancing Maigc +5
        legs    = "Piety Pantaloons +3",        --  Enhancing Maigc +26
        feet    = "Theophany Duckbills +3"      --  Enhancing Magic +21, Enhancing Magic Duration +10%
    }

    sets.Midcast.EnhancingDuration = set_combine(sets.Midcast.Enhancing, 
    {
        main    = "Beneficus",                  --  Enhancing Maigc +15
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        hands   = { name        = "Telchine Gloves", 
                    augments    = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        feet    = "Theophany Duckbills +3",     --  Enhancing Magic +21, Enhancing Magic Duration +10%
    })

    sets.Midcast.Barspell = set_combine(sets.Midcast.Enhancing,
    {
        head    = "Ebers Cap +1",               --  Set: Occationally negates damage with correct barpsell
        body    = "Ebers Bliaud +1",            --  Set: Occationally negates damage with correct barpsell
        hands   = "Ebers Mitts +1",             --  Set: Occationally negates damage with correct barpsell
        legs    = "Piety Pantaloons +3",        --  Barspell +36
        feet    = "Ebers Duckbills +1"          --  Set: Occationally negates damage with correct barpsell
    })
    
    sets.Midcast.Stoneskin = set_combine(sets.Midcast.Enhancing,
    {
        neck    = "Nodens Gorget",              --  Stoneskin +30
        ear1    = "Earthcry Earring",           --  Stoneskin +10
        waist   = "Siegel Sash",                --  Stoneskin +20
        legs    = "Haven Hose"                  --  Stoneskin +20
        -- legs    = "Shedir Seraweels"         --  Stoneskin +35
    })
    
    --  Regen Potency/Duration set
    --  +46 Duration
    --  +76% Potency from gear
    sets.Midcast.Regen = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Bolelabunga",                --  Regen Potency +10%
        head    = "Inyanga Tiara +2",           --  Regen Potency +14%
        body    = "Piety Briault +3",           --  Regen Potency +52%
        hands   = "Ebers Mitts +1",             --  Regen Duration +22
        legs    = "Theophany Pantaloons +3"     --  Regen Duration +24
    })
    
    sets.Midcast.ShellraV = set_combine(sets.Midcast.Enhancing,
    {
        ring1   = "Sheltered Ring",             --  Enhances Protect & Shell
    })

    sets.Midcast.ProtectraV = set_combine(sets.Midcast.Enhancing,
    {
        ring1   = "Sheltered Ring",             --  Enhances Protect & Shell
    })

    sets.Midcast.Auspice = set_combine(sets.Midcast.Enhancing,
    {
        feet    = "Ebers Duckbills +1"          --  Auspice +15
    })

    sets.Midcast.Aquaveil = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Vadose Rod"                  --  Aquaveil +1
        -- legs    = "Shedir Seraweels"         --  Enhances Aquaveil
    })

    sets.Midcast.Erase = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Yagrush",
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        neck    = "Cleric's Torque"             --  Erase +1        (Nice to have +1 or 2)
    })

    sets.Midcast.MagicAcc =
    {
        main    = "Blurred Staff",                          --  +20 Magic Accuracy, +228 Magic Accuracy Skill
        sub     = "Enki Strap",                             --  +10 Magic Accuracy
        ammo    = "Hydrocera",                              --  +06 Magic Accuracy
        head    = "Inyanga Tiara +2",                       --  +44 Magic Accuracy
        neck    = "Erra Pendant",                           --  +17 Magic Accuracy
        -- neck    = "Incanter's Torque",                   --  +10 All magic (Synergy from 10 Escha - Ru'Aun NM drops)
        ear1    = "Psystorm Earring",                       --  +12 Magic Accuracy: Set
        ear2    = "Lifestorm Earring",                      --  +12 Magic Accuracy: Set
        body    = "Inyanga Jubbah +2",                      --  +46 Magic Accuracy
        hands   = "Inyanga Dastanas +2",                    --  +43 Magic Accuracy, +20 All magic
        ring1   = "Stikini Ring",                           --  +08 Magic Accuracy, +05 All magic
        ring2   = "Stikini Ring",                           --  +08 Magic Accuracy, +05 All magic
        back    = { name        = "Alaunus's Cape",         --  +20 Magic Accuracy
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist   = "Aswang Sash",                            --  +03 Magic Accuracy
        legs    = "Inyanga Shalwar +2",                     --  +45 Magic Accuracy
        feet    = "Piety Duckbills +3"                      --  +36 Magic Accuracy
    }
    
    sets.Midcast.Enfeebling = set_combine(sets.Midcast.MagicAcc,
    {
        body    = "Theophany Briault +3",
        ring2   = "Kishar Ring",
        waist   = "Casso Sash",
        legs    = { name        = "Chironic Hose", 
                    augments    = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })
    
    sets.Midcast.Divine = set_combine(sets.Midcast.MagicAcc,
    {
        hands   = "Piety Mitts +3",
        waist   = "Bishop's Sash",
        legs    = "Theophany Pantaloons +3"
    })

    sets.Midcast.Banish = set_combine(sets.Midcast.Divine,
    {
        neck    = "Sanctity Necklace",          --  +10 Magic Accuracy, +10 Magic Attack Bonus
        ear1    = "Dignitary's Earring",        --  +10 Magic Accuracy
        ear2    = "Hecate's Earring",           --  +06 Magic Attack Bonus, +3% Magic Crit. Hit
        back    = "Disperser's Cape",           --  Potency of Banish vs. Undead +7
        waist   = "Aswang Sash",                --  +03 Magic Attack Bonus
        legs    = { name        = "Chironic Hose", 
                    augments    = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })
end

-- --------------------
-- Spell Triggers
-- --------------------
function precast(spell,action)
    check_special_ring_equipped()
    if spell.type == "Trust" then
        windower.add_to_chat(6, "Casting trust")
    end

    --  If exp rings are on, disable the slot so they aren't changed
    -- ring_slot = check_special_ring_equipped()
    -- if ring_slot != '' then
    --     windower.add_to_chat(5, "Disabling " .. ring_slot .. " because of special ring")
    --     disable(ring_slot)
    -- end

    if spell.action_type == 'Magic' and buffactive['Silence'] then
        cancel_spell()
        if player.inventory['Echo Drops'] ~= nil then
            send_command('input /item "Echo Drops" <me>')
			send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Echo Drops'].count..' Left !!*')
        elseif player.inventory['Remedy'] ~= nil then
            send_command('input /item "Remedy" <me>')
			send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Remedy'].count..' Left !!*')
        end
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    elseif spell.name == "Sublimation" and buffactive['Weakness'] then
        cancel_spell()
    elseif abilityNothing:contains(spell.name) then
            --  Do Nothing
    elseif spell.name == "Dia" then
    	cancel_spell()
    	send_command('@input /ma "Dia II" <t>')
    elseif spell.name == "Reraise" then
        cancel_spell()
        send_command('@input /ma "Reraise IV" <me>')
    elseif abilityCancel:contains(spell.name) then
        cancel_spell()
    elseif spell.english == "Devotion" then
        equip(sets.Precast.Devotion)
    elseif spell.english == "Benediction" then
        equip(sets.Precast.Benediction)
    else
        if string.find(spell.english,'Cure') then
            equip(sets.Precast.Cure)
        elseif naSpellsNoCursna:contains(spell.english) or spell.name == "Cursna" then
            equip(sets.Precast.NASpell)
        elseif spell.name == "Stoneskin" then
            equip(sets.Precast.Stoneskin)
        elseif string.find(spell.skill,"Enhancing") then
            equip(sets.Precast.Enhancing)
        else
            equip(sets.Precast.FastCast)
        end
    end
end

function midcast(spell, action)

    if spell.type == "Trust" then
        equip(sets.Trust)
    end

    ---------------------
    --  Healing Magic  --
    ---------------------
    if spell.skill == "Healing Magic" then
        if string.find(spell.english,'Cure') then
            if get_weather_day_match(spell.element) then
                equip(set_combine(sets.Midcast.Cure,sets.Midcast.WeatherBoost))
                windower.add_to_chat(8, "Cure Boost Active")
            else
                equip(sets.Midcast.CureBonus)
                windower.add_to_chat(8, "No Cure Boost Active")
            end
        elseif string.find(spell.english,"Curaga") then
            if get_weather_day_match(spell.element) then
                equip(sets.Midcast.CureBonus)
            else
                -- equip(sets.Midcast.Curaga)
                equip(sets.Midcast.Cure)
            end
        elseif spell.english == "Cursna" then
            equip(sets.Midcast.Cursna)
        elseif buffactive == "Divine Caress" then
            equip(sets.Midcast.Caress)
        else
            equip(sets.Midcast.NASpell)
        end
    end
    
    -----------------------
    --  Enhancing Magic  --
    -----------------------
    if spell.skill == "Enhancing Magic" then
        if resSpells:contains(spell.english) then
            equip(sets.Midcast.Barspell)
        elseif spell.english == "Stoneskin" then
            equip(sets.Midcast.Stoneskin)
        elseif string.find(spell.english,"Regen") then
            equip(sets.Midcast.Regen)
        elseif spell.english == "Protectra V" then
            equip(sets.Midcast.ProtectraV)
        elseif  spell.english == "Shellra V" then
            equip(sets.Midcast.ShellraV)
        elseif spell.english == "Aquaveil" then
        	equip(sets.Midcast.Aquaveil)
        elseif spell.english == "Erase" then
            equip(sets.Midcast.Erase)
        else
            equip(sets.Midcast.Enhancing)
        end
    end
    
    --------------------
    --  Divine Magic  --
    --------------------
    if spell.skill == "Divine Magic" then
        if string.find(spell.english, "Banish") or string.find(spell.english, "Holy") then
            equip(sets.Midcast.Banish)
        elseif get_weather_day_match(spell.element) then
            equip(set_combine(sets.Midcast.Divine,sets.Midcast.WeatherBoost))
        else
            equip(sets.Midcast.Divine)
        end
    end
    
    ------------------------
    --  Enfeebling Magic  --
    ------------------------
    if spell.skill == "Enfeebling Magic" then
        if get_weather_day_match(spell.element) then
            equip(set_combine(sets.Midcast.Enfeebling, sets.Midcast.WeatherBoost))
        else
            equip(sets.Midcast.Enfeebling)
        end
    end
end

--  Check if the spell element matches the current day, weather, or SCH storm
--  @param  String: The string of the spell element to check
function get_weather_day_match(element)
    isMatchWeather = world.weather_element == element
    isMatchDay = world.day_element == element

    -- windower.add_to_chat(3, string.format("Weather Match: " .. "%s", tostring(isMatchWeather)))
    -- windower.add_to_chat(3, string.format("Day Match: " .. "%s", tostring(isMatchDay)))
    if (isMatchDay or isMatchWeather) then
        windower.add_to_chat(1, "Weather or Day Match")
    else
        windower.add_to_chat(10, "No Weather or Day Match")
    end

    return (isMatchDay or isMatchWeather)
end

--  Locks the correct ring slot if a listed ring is equipped
--  Unlocks the slot if the ring is no longer detected
function check_special_ring_equipped()
    if exp_rings:contains(player.equipment.ring1) then
        windower.add_to_chat(9, "Ring1 locked")
        special_ring_equipped = true
        disable("ring1")
    elseif exp_rings:contains(player.equipment.ring2) then
        windower.add_to_chat(9, "Ring2 locked")
        special_ring_equipped = true
        disable("ring2")
    elseif special_ring_equipped then
        windower.add_to_chat(9, "Unlocking rings")
        special_ring_equipped = false
        enable('ring1')
        enable('ring2')
    end
end

function aftercast(spell,action)
    if toau_zones:contains(world.area) then
        equip(sets.Idle,{ ring1 = "Balrahn's Ring" })   
    else
        equip(sets.Idle)
    end
end

function status_change(new,tab)
    check_special_ring_equipped()
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle)
    end
end

function sub_job_change(new, old)
    if melee_sub_jobs:contains(player.sub_job) then
        disable('main')
        disable('sub')
        disable('ranged')
        disable('ammo')
    else
        enable('main')
        enable('sub')
        enable('ranged')
        enable('ammo')
    end
end

function select_default_macro_book()
    set_macro_page(1, 4)

    send_command('wait 3; input /lockstyleset 003')
end