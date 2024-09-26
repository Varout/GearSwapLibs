--  JSE Armour
gear.ArtefactHead  = "Theophany Cap +3"
gear.ArtefactBody  = "Theophany Bliaut +3"
gear.ArtefactHands = "Theophany Mitts +3"
gear.ArtefactLegs  = "Theophany Pantaloons +3"
gear.ArtefactFeet  = "Theophany Duckbills +3"

gear.RelicHead  = "Piety Cap +3"
gear.RelicBody  = "Piety Bliaut +3"
gear.RelicHands = "Piety Mitts +3"
gear.RelicLegs  = "Piety Pantaloons +3"
gear.RelicFeet  = "Piety Duckbills +3"

gear.EmpyreanHead  = "Ebers Cap +3"
gear.EmpyreanBody  = "Ebers Bliaut +3"
gear.EmpyreanHands = "Ebers Mitts +2"
gear.EmpyreanLegs  = "Ebers Pantaloons +3"
gear.EmpyreanFeet  = "Ebers Duckbills +2"

gear.EmpyreanEarring = "Ebers Earring +1"
gear.DynamisNeck     = "Cleric's Torque +2"

--  REMA Weapons
gear.ClubRelic    = "Mjollnir"
gear.ClubMythic   = "Yagrush"
gear.ClubEmpyrean = "Gambanteinn"
gear.ClubAeonic   = "Tishtrya"
gear.ClubPrime    = "Lorg Mor"

--  Gear sets for specific conditions and commands
--  Neck equipment to lock in while in dynamis
sets.JSENeck = {
    neck       = gear.DynamisNeck
}

--  Equipment that enhances the charge rate of Sublimation
sets.Sublimation = {
    waist      = "Embla Sash"                       -- Sublimation +3
}

sets.ToAURing = {
    right_ring = "Balrahn's Ring"
}

--  Equipment only active during reives
sets.Reives = {
    neck       = "Arciela's Grace +1"
}

--  Set for summoning Trusts. All iLevel 119
sets.Trust = {
    main       = gear.ClubEmpyrean,
    sub        = "Culminus",
    ammo       = "Homiliary",
    head       = gear.EmpyreanHead,
    body       = gear.EmpyreanBody,
    hands      = gear.EmpyreanHands,
    legs       = gear.EmpyreanLegs,
    feet       = gear.EmpyreanFeet
}

sets.town = {}

--  +15 Idle Refresh (+17 with latent effects)
sets.idle = {
    main        = { name     = "Mpaca's Staff",     -- Refresh +2
                    augments = {'Path: A',}},
    sub         = "Enki Strap",
    ammo        = "Homiliary",                      -- Refresh +1
    head        = { name     = "Chironic Hat",      -- Refresh +2
                    augments = {'Pet: Phys. dmg. taken -1%','"Dbl.Atk."+3','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    body        = gear.EmpyreanBody,                -- Refresh +3, Regen +4
    hands       = { name     = "Chironic Gloves",   -- Refresh +2
                    augments = {'Pet: MND+10','Attack+5','"Refresh"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    legs        = { name     = "Chironic Hose",     -- Refresh +2
                    augments = {'Accuracy+7','CHR+5','"Refresh"+2','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    feet        = { name     = "Chironic Slippers", -- Refresh +2
                    augments = {'Pet: DEX+15','VIT+8','"Refresh"+2','Accuracy+12 Attack+12',}},
    neck        = { name     = "Loricate Torque +1",
                    augments = {'Path: A',}},
    waist       = "Fucho-no-Obi",                   -- Latent: Refresh +1
    left_ear    = { name     = "Moonshade Earring", -- Latent: Refresh +1
                    augments = {'MP+25','Latent effect: "Refresh"+1',}},
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Stikini Ring +1",                -- Refresh +1
    right_ring  = "Defending Ring",
    back        = { name = "Alaunus's Cape",
                    augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
}

sets.resting = {
    main        = "Boonwell Staff",      -- +18
    sub         = "Ariesian Grip",       -- +1
    ammo        = "Mana Ampulla",        -- +2
    head        = "Orvail Corona +1",    -- +4
    neck        = "Eidolon Pendant +1",  -- +6
    left_ear    = { name     = "Moonshade Earring", -- Latent: Refresh +1
                    augments = {'MP+25','Latent effect: "Refresh"+1',}},
    right_ear   = "Infused Earring",     -- +0, Regen +1
    body        = "Chelona Blazer",      -- +8 (Nice to have +1)
    hands       = "Nares Cuffs",         -- +4
    left_ring   = "Star Ring",           -- +1
    right_ring  = "Angha Ring",          -- +2
    back        = "Felicitas Cape",      -- +3
    waist       = "Shinjutsu-no-Obi +1", -- +5
    legs        = "Nisse Slacks",        -- +4
    feet        = "Chelona Boots"        -- +5 (Nice to have +1)
}

--  Setting the base set: precast
sets.precast = {}

--  --------------------
--  AF/Relic JA Sets
--  --------------------
sets.precast["Devotion"]    = { head = gear.RelicHead }
sets.precast["Benediction"] = { body = gear.RelicBody }

--  Total fast cast for this set is: 83%.  Not sure what the cap is.
--  Extra Spell Interruption Down is: 54%
sets.precast.FC = {
    main        = "Oranyan",                        -- FC +7%
    sub         = "Clerisy Strap",                  -- FC +2%
    ammo        = "Incantor Stone",                 -- FC +2%
    head        = "Ebers Cap +2",                   -- FC +10%
    neck        = gear.DynamisNeck,                 -- FC +10%
    left_ear    = "Loquac. Earring",                -- FC +2%
    right_ear   = "Malignance Earring",             -- FC +4%
    body        = "Inyanga Jubbah +2",              -- FC +14%
    hands       = { name     = "Fanatic Gloves",    -- FC +7%
                    augments = {'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    left_ring   = "Evanescence Ring",               -- Spell Interruption Down 05%
    right_ring  = "Kishar Ring",                    -- FC +4%
    back        = { name     = "Alaunus's Cape",    -- FC +10%, Spell Interruption Down 10%
                    augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
    waist       = "Embla Sash",                     -- FC +5%
    legs        = { name     = "Kaykaus Tights",    -- FC +6%, Spell Interruption Down 10%
                    augments = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
    feet        = gear.ArtefactFeet                 -- Spell Interruption Down 29%
}

sets.precast['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist       = "Siegel Sash"                     -- Enhancing Magic cast time -8%
})

sets.precast['Stoneskin'] = set_combine(sets.precast['Enhancing Magic'], {
    head        = "Umuthi Hat",                     -- Stoneskin Cast Time -15%
    hands       = "Carapacho Cuffs"                 -- Stoneskin Cast Time -15%
})

sets.precast['Healing Magic'] = set_combine(sets.precast.FC, {
    main        = "Vadose Rod",                     -- Healing Magic cast time -5%
    sub         = "Culminus",                       -- Spelling Interruption Down 10%
    legs        = gear.EmpyreanLegs,                -- Healing Magic Cast Time -14%
    back        = "Disperser's Cape"                -- Healing Magic Cast Time -5%
})

sets.precast['Cure'] = set_combine(sets.precast['Healing Magic'], {
    main        = "Ababinili +1",                    -- Cure Cast Time -11%
    sub         = "Clerisy Strap",                   -- FC +02%
    head        = gear.RelicHead,                    -- Cure Cast Time -15%, Haste +6%
    left_ear    = "Nourishing Earring +1",           -- Cure Cast Time -4%
    right_ear   = "Mendicant's Earring",             -- Cure Cast Time -5%, Conserve MP +3
    body        = "Heka's Kalasiris",                -- Cure Cast Time -15%
    feet        = "Hygieia Clogs +1"                 -- Cure Cast Time -18%, Haste +3%, Conserve MP +5
})

--------------------
--  midcast Sets  --
--------------------
sets.midcast = {}

sets.midcast.Caress = {
    hands       = gear.EmpyreanHands                 -- Divine Caress +4
}

--  Equipment which increases spell potency when the day or weather match the spell element
sets.midcast.WeatherBoost = {
    back        = "Twilight Cape",                  -- Bonus +5%
    waist       = "Hachirin-no-Obi"                 -- Bonus +10%
}

--  Complete different sets for base cure potency, and set for day/weather match
--  Calculated in personalised Cure spreadsheet taking into account day/weather
sets.midcast.Cure = {
    main        = "Raetic Rod",
    sub         = "Sors Shield",
    ammo        = "Quartz Tathlum +1",
    head        = { name     = "Vanya Hood",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = "Theo. Bliaut +3",
    hands       = gear.ArtefactHands,
    legs        = "Ebers Pant. +2",
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck        = "Incanter's Torque",
    waist       = "Bishop's Sash",
    left_ear    = "Glorious Earring",
    right_ear   = { name     = gear.EmpyreanEarring,
                    augments = {'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
    left_ring   = "Janniston Ring +1",
    right_ring  = "Menelaus's Ring",
    back        = { name     = "Alaunus's Cape",
                    augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
}

sets.midcast.CureBonus = {
    main        = "Chatoyant Staff",
    ammo        = "Quartz Tathlum +1",
    head        = { name = "Vanya Hood",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = "Theo. Bliaut +3",
    hands       = gear.ArtefactHands,
    legs        = "Ebers Pant. +2",
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck        = { name     = "Clr. Torque +2",
                    augments = {'Path: A',}},
    waist       = "Hachirin-no-Obi",
    left_ear    = "Glorious Earring",
    right_ear   = { name     = gear.EmpyreanEarring,
                    augments = {'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
    left_ring   = "Janniston Ring +1",
    right_ring  = "Menelaus's Ring",
    back        = { name     = "Alaunus's Cape",
                    augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
}

--  Healing Magic: 700 (uncapped)
sets.midcast.NASpell = {
    main        = gear.ClubMythic,                  -- AoE Status Removal
    sub         = "Ammurapi Shield",
    ammo        = "Quartz Tathlum +1",              -- Healing Magic +00
    head        = { name     = "Vanya Hood",        -- Healing Magic +20
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = gear.EmpyreanBody,
    hands       = gear.ArtefactHands,               -- Healing Magic +21
    legs        = gear.EmpyreanLegs,                -- Divine Benison +3
    feet        = { name     = "Vanya Clogs",       -- Healing Magic +40, Cursna +5
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck        = "Incanter's Torque",              -- Healing Magic +10
    waist       = "Bishop's Sash",                  -- Healing Magic +05
    left_ear    = "Meili Earring",                  -- Healing Magic +10
    right_ear   = { name     = "Ebers Earring",     -- Healing Magic +10
                    augments = {'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
    left_ring   = "Sirona's Ring",                  -- Healing Magic +10
    right_ring  = "Menelaus's Ring",                -- Cure +5%, Healing Magic +15, Cursna +20
    back        = "Altruistic Cape",                -- Healing Magic +05
}

--  Cursna AoE
sets.CursnaAoE = {
    main = gear.ClubMythic,
}

--  Cursna Potency +100
sets.CursnaSingle = {
    main = gear.ClubEmpyrean,
}

sets.midcast.Cursna = set_combine(sets.midcast.NASpell, {
    main        = gear.ClubEmpyrean,                -- Cursna +100
    sub         = "Ammurapi Shield",
    neck        = "Debilis Medallion",              -- Healing Magic +00, Cursna +15
    hands       = "Fanatic Gloves",                 -- Healing Magic +10, Cursna +15
    left_ring   = "Haoma's Ring",                   -- Healing Magic +08, Cursna +15
    right_ring  = "Menelaus's Ring",                -- Healing Magic +15, Cursna +20
    back        = { name     = "Alaunus's Cape",    -- Healing Magic +00, Cursna +25
                    augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
    legs        = gear.ArtefactLegs,                -- Healing Magic +00, Cursna +21
    feet        = { name     = "Vanya Clogs",       -- Healing Magic +40, Cursna +5
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}        -- Gendewitha Galoshes +1: +10 Cursna.  Not sure if it'll be better than what I already have
})

--  Enhancing Magic: 585
sets.midcast['Enhancing Magic'] = {
    main        = "Beneficus",                      -- Enhancing Maigc +15
    sub         = "Ammurapi Shield",                -- Enhancing magic duration +10%
    ammo        = "Quartz Tathlum +1",
    head        = "Befouled Crown",                 -- Enhancing Maigc +16
    body        = "Anhur Robe",                     -- Enhancing Maigc +12
    hands       = { name     = "Telchine Gloves",   -- Enhancing magic duration +8%
                    augments = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
    legs        = gear.RelicLegs,                   -- Enhancing Maigc +26
    feet        = gear.ArtefactFeet,                -- Enhancing Magic +21, Enhancing Magic Duration +10%
    neck        = "Incanter's Torque",              -- Enhancing Maigc +10
    waist       = "Olympus Sash",                   -- Enhancing Maigc +5
    left_ear    = "Mimir Earring",                  -- Enhancing Maigc +10
    right_ear   = "Andoaa Earring",                 -- Enhancing Maigc +5
    left_ring   = "Stikini Ring +1",                -- All magic +8
    right_ring  = "Stikini Ring",                   -- All magic +5
    back        = "Fi Follet Cape"                  -- Enhancing Maigc +8
}

sets.midcast.Barspell = set_combine(sets.midcast['Enhancing Magic'], {
    head        = gear.EmpyreanHead,                -- Set: Occationally negates damage with correct barpsell
    body        = gear.EmpyreanBody,                -- Set: Occationally negates damage with correct barpsell
    hands       = gear.EmpyreanHands,               -- Set: Occationally negates damage with correct barpsell
    legs        = gear.RelicLegs,                   -- Barspell +36
    feet        = gear.EmpyreanFeet                 -- Set: Occationally negates damage with correct barpsell
})

sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
    neck        = "Nodens Gorget",                  -- Stoneskin +30
    left_ear    = "Earthcry Earring",               -- Stoneskin +10
    waist       = "Siegel Sash",                    -- Stoneskin +20
    legs        = "Shedir Seraweels"                -- Stoneskin +35
})

--  Regen Potency/Duration set
sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
    main        = "Bolelabunga",                    -- Regen Potency +10%
    sub         = "Ammurapi Shield",                -- Enhancing magic duration +10%
    head        = "Inyanga Tiara +2",               -- Regen Potency +14%
    body        = gear.RelicBody,                   -- Regen Potency +52%
    hands       = gear.EmpyreanHands,               -- Regen Duration +24
    legs        = gear.ArtefactLegs,                -- Regen Duration +24
    feet        = gear.ArtefactFeet                 -- Enhancing Magic Duration +10%
})

sets.midcast['Protect'] = set_combine(sets.midcast['Enhancing Magic'], {
    left_ring   = "Sheltered Ring",                 -- Enhances Protect & Shell
})

sets.midcast['Shell'] = sets.midcast['Protect']

sets.midcast['Auspice'] = set_combine(sets.midcast['Enhancing Magic'], {
    feet        = gear.EmpyreanFeet                 -- Auspice +17
})

sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
    main        = "Vadose Rod",                     -- Aquaveil +1
    head        = { name     = "Chironic Hat",      -- Aquaveil +1
                    augments = {'Pet: Phys. dmg. taken -1%','"Dbl.Atk."+3','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    -- hands       = "Regal Cuffs",                 -- Aquaveil +2
    legs        = "Shedir Seraweels",               -- Aquaveil +1
    waist       = "Emphatikos Rope"                 -- Aquaveil +1
})

sets.midcast['Erase'] = set_combine(sets.midcast['Enhancing Magic'], {
    main        = gear.ClubMythic,                  --  Grants area of effect
    sub         = "Ammurapi Shield",                --  Enhancing magic duration +10%
    neck        = gear.DynamisNeck                  --  Erase +1
})

--  Base set for magic accuracy for Divine and Enfeebling
sets.midcast.MagicAcc = {
    main        = { name     = "Mpaca's Staff",     -- +40 Magic Accuracy, +255 Magic Accuracy Skill
                    augments = {'Path: A',}},
    sub         = "Enki Strap",                     -- +10 Magic Accuracy
    ammo        = "Hydrocera",                      -- +06 Magic Accuracy
    head        = gear.EmpyreanHead,                -- +51 Magic Accuracy
    body        = gear.EmpyreanBody,                -- +54 Magic Accuracy
    hands       = gear.EmpyreanHands,               -- +52 Magic Accuracy
    legs        = gear.EmpyreanLegs,                -- +53 Magic Accuracy
    feet        = gear.EmpyreanFeet,                -- +50 Magic Accuracy
    neck        = "Erra Pendant",                   -- +17 Magic Accuracy
    waist       = "Luminary Sash",                  -- +10 Magic Accuracy
    left_ear    = "Gwati Earring",                  -- +8 Magic Accuracy
    right_ear   = { name     = "Ebers Earring",     -- +7 Magic Accuracy
                    augments = {'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
    left_ring   = "Stikini Ring +1",                -- +11 Magic Accuracy, +8 All magic
    right_ring  = "Medada's Ring",                  -- +20 Magic Accuracy
    back        = { name     = "Alaunus's Cape",    -- +20 Magic Accuracy
                    augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
}

sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MagicAcc, {
    body        = gear.ArtefactBody,                -- +50 Magic Accuracy, +21 Enfeeling Magic
    right_ear   = "Vor Earring",                    -- +10 Enfeebling Magic
    right_ring  = "Kishar Ring",                    -- Magic Accuracy +5, Enfeebling duration +10%
    legs        = { name     = "Chironic Hose",     -- +21 Magic Accuracy, +13 Enfeebling Magic, +1 Immunobreak
                    augments = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
})

sets.midcast['Divine Magic'] = set_combine(sets.midcast.MagicAcc, {
    hands       = gear.RelicHands,                  -- +38 Magic Accuracy, +26 Divine Magic
    legs        = gear.ArtefactLegs                 -- +49 Magic Accuracy, +21 Divine Magic
})

sets.midcast['Banish'] = set_combine(sets.midcast['Divine Magic'], {
    head        = "Ipoca Baret",                    -- Potency of Banish vs. Undead +25
    hands       = gear.RelicHands,                  -- Potency of Banish vs. Undead +30
    neck        = "Sanctity Necklace",              -- +10 Magic Accuracy, +10 Magic Attack Bonus
    left_ear    = "Dignitary's Earring",            -- +10 Magic Accuracy
    right_ear   = "Hecate's Earring",               -- +6 Magic Attack Bonus, +3% Magic Crit. Hit
    back        = "Disperser's Cape",               -- Potency of Banish vs. Undead +7
    waist       = "Aswang Sash",                    -- +3 Magic Attack Bonus
})

sets.midcast['Holy'] = sets.midcast['Banish']

--  Melee sets
sets.engaged = {
    ammo        = "Oshasha's Treatise",
    head        = gear.ArtefactHead,
    body        = gear.ArtefactBody,
    hands       = gear.ArtefactHands,
    legs        = gear.ArtefactLegs,
    feet        = gear.ArtefactFeet,
    neck        = "Asperity Necklace",
    waist       = "Cornelia's Belt",
    left_ear    = "Dignitary's Earring",
    right_ear   = "Brutal Earring",
    left_ring   = "Rajas Ring",
    right_ring  = "K'ayres Ring",
    back        = { name     = "Alaunus's Cape",
                    augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}

sets.precast.WS = {}
sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})    -- WS Quest:    30% STR, 70% MND [Fragmentation / Compression]
sets.precast.WS['Dagan'] = set_combine(sets.precast.WS, {})         -- Empyrean WS: Max HP & MP [None]
sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {})   -- Dope WS:     30% STR & MND [Fusion]
sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {})   -- Mythic WS:   30% STR, 70% MND [None]
sets.precast.WS['Randgrith'] = set_combine(sets.precast.WS, {})     -- Relic WS:    40% STR & MND [Light / Fragmentation]
sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})    -- Aeonic WS:   85% MND [Light / Fusion / Impaction]
