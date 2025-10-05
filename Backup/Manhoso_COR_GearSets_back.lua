--  ----------------------------------------------------------------------------------------------------
--   Job Specific Armour
--  ----------------------------------------------------------------------------------------------------
gear.ArtefactHead  = "Laksamana's Tricorne +4"
gear.ArtefactBody  = "Laksamana's Frac +4"
gear.ArtefactHands = "Laksamana's Gants +4"
gear.ArtefactLegs  = "Laksamana's Trews +4"
gear.ArtefactFeet  = "Laksamana's Bottes +4"

gear.RelicHead  = "Lanun Tricorne +4"
gear.RelicBody  = "Lanun Frac +3"
gear.RelicHands = "Lanun Gants +4"
gear.RelicLegs  = "Lanun Trews +3"
gear.RelicFeet  = "Lanun Bottes +4"

gear.EmpyreanHead  = "Chasseur's Tricorne +3"
gear.EmpyreanBody  = "Chasseur's Frac +3"
gear.EmpyreanHands = "Chasseur's Gants +3"
gear.EmpyreanLegs  = "Chasseur's Culottes +3"
gear.EmpyreanFeet  = "Chasseur's Bottes +3"

gear.EmpyreanEarring = "Chasseur's Earring +1"
gear.DynamisNeck     = "Commodore Charm +2"

--  REMA Weapons
gear.WeaponMythic   = "Death Penalty"   -- Not Completed
gear.WeaponEmpyrean = "Armageddon"
gear.WeaponAeonic   = "Fomalhaut"
gear.WeaponPrime    = "Earp"            -- Not yet

--  Other Weapons
gear.WeaponTPBonus  = { name = "Ataktos",     augments = {'Delay:+60','TP Bonus +1000',}}
gear.WeaponPhantom  = { name = "Compensator", augments = {'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}}    -- Phantom Roll Duration +20

--  Special Ammo
gear.BulletRA       = "Chrono Bullet"
gear.BulletWSAttack = "Chrono Bullet"
gear.BulletWSMagic  = "Devastating Bullet"
gear.BulletQDAcc    = "Devastating Bullet"
gear.BulletQDAtt    = "Animikii Bullet"
gear.DoNotShoot     = S{"Animikii Bullet", "Hauksbok Bullet"}

--  Ambuscade Back Pieces
gear.AmbuscadeMeleeAcc      = { name     = "Camulus's Mantle",
                                augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
gear.AmbuscadeMeleeWS       = { name     = "Camulus's Mantle",
                                augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
gear.AmbuscadeRangedAcc     = { name     = "Camulus's Mantle",
                                augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
gear.AmbuscadeRangedWSPhys  = { name     = "Camulus's Mantle",
                                augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
gear.AmbuscadeRangedWSMagic = { name     = "Camulus's Mantle",
                                augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
gear.AmbuscadeMagicAcc      = gear.AmbuscadeRangedAcc   --  No magic acc yet, needs to be made
gear.AmbuscadeFC            = { name     = "Camulus's Mantle",
                                augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}
gear.AmbuscadeDT            = gear.AmbuscadeFC

--  Other Capes
gear.GunslingerCape         = { name     = "Gunslinger's Cape",
                                augments = {'Enmity-3','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5','Weapon skill damage +1%',}}

--  Herc Legs
gear.HerculeanLegs = {}
gear.HerculeanLegs.WsMAB    = { name     = "Herculean Trousers",
                                augments = {'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}}
gear.HerculeanLegs.WsPhys   = { name     = "Herculean Trousers",
                                augments = {'Accuracy+27','Weapon skill damage +5%','AGI+8',}}

--  Elemental Obis
gear.ObiDark = { waist = "Anrin Obi" }
gear.ObiFire = { waist = "Karin Obi" }
gear.ObiAll  = { waist = "Hachirin-no-Obi" }

-- Elemental Belts
gear.BeltFire = { waist = "Flame Belt" }
gear.BeltAll  = { waist = "Fotia Belt" }

--  Elemental Gorgets
gear.GorgetFire = { neck = "Flame Gorget" }
gear.GorgetAll  = { neck = "Fotia Gorget" }

--  ----------------------------------------------------------------------------------------------------
--   Town Sets
--  ----------------------------------------------------------------------------------------------------

--  ----------------------------------------------------------------------------------------------------
--   Idle Sets
--  ----------------------------------------------------------------------------------------------------
-- Idle sets
sets.idle = {
    ammo        =  gear.RAbullet,
    head        = "Malignance Chapeau",
    body        = "Malignance Tabard",
    hands       = "Malignance Gloves",
    legs        = "Malignance Tights",
    feet        = "Malignance Boots",
    neck        = "Elite Royal Collar",
    waist       = "Platinum Moogle Belt",
    left_ear    = "Infused Earring",
    right_ear   = "Odnowa Earring +1",
    left_ring   = "Murky Ring",
    right_ring  = "Sheltered Ring",
    back        = gear.AmbuscadeDT,
}

sets.idle.refresh = set_combine(sets.idle, {
    head        = "Rawhide Mask",
    legs        = { name     = "Rawhide Trousers",
                    augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
})

sets.idle = {}
sets.idle['Normal'] = {
    ammo        =  gear.RAbullet,
    head        = "Malignance Chapeau",
    body        = "Malignance Tabard",
    hands       = "Malignance Gloves",
    legs        = "Malignance Tights",
    feet        = "Malignance Boots",
    neck        = "Elite Royal Collar",
    waist       = "Platinum Moogle Belt",
    left_ear    = "Infused Earring",
    right_ear   = "Odnowa Earring +1",
    left_ring   = "Murky Ring",
    right_ring  = "Sheltered Ring",
    back        = gear.AmbuscadeDT,
}
sets.idle['Refresh']  = set_combine(sets.idle['Normal'],{
    head        = "Rawhide Mask",
    legs        = { name     = "Rawhide Trousers",
                    augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
})
sets.idle['Hybrid']   = {}
sets.idle['MagicEva'] = {}


--  ----------------------------------------------------------------------------------------------------
--   Engaged Sets
--  ----------------------------------------------------------------------------------------------------
-- No Magic Haste (72% DW to cap)
sets.engaged = {
    ammo        = gear.RAbullet,
    head        = gear.EmpyreanHead,
    body        = gear.EmpyreanBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.EmpyreanLegs,
    feet        = gear.EmpyreanFeet,
    neck        = "Asperity Necklace",
    waist       = { name     = "Sailfi Belt +1",
                    augments = {'Path: A',}},
    left_ear    = "Cessance Earring",
    right_ear   = "Brutal Earring",
    left_ring   = "Petrov Ring",
    right_ring  = "Epona's Ring",
    back        = gear.AmbuscadeMeleeAcc,
}
-- sets.engaged.Normal = sets.engaged

-- sets.engaged.Hybrid = {
--     ammo        =  gear.RAbullet,
--     head        = "Malignance Chapeau",
--     body        = "Malignance Tabard",
--     hands       = "Malignance Gloves",
--     legs        = "Malignance Tights",
--     feet        = "Malignance Boots",
--     neck        = { name     = "Loricate Torque +1",
--                     augments = {'Path: A',}},
--     waist       = { name     = "Sailfi Belt +1",
--                     augments = {'Path: A',}},
--     left_ear    = "Cessance Earring",
--     right_ear   = { name     = "Odnowa Earring +1",
--                     augments = {'Path: A',}},
--     left_ring   = "Murky Ring",
--     right_ring  = "Epona's Ring",
--     back        = gear.AmbuscadeMeleeAcc,
-- }

-- sets.engaged.LowAcc = set_combine(sets.engaged, {})
-- sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})
-- sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})

-- -- 15% Magic Haste (66% DW to cap)
-- sets.engaged.LowHaste = set_combine(sets.engaged, {}) -- 55-65% (40% Gear)
-- sets.engaged.LowHaste.LowAcc = set_combine(sets.engaged.LowHaste, {})
-- sets.engaged.LowHaste.MidAcc = set_combine(sets.engaged.LowHaste.LowAcc, {})
-- sets.engaged.LowHaste.HighAcc = set_combine(sets.engaged.LowHaste.MidAcc, {})
-- sets.engaged.LowHaste.Fodder = set_combine(sets.engaged.LowHaste, {})

-- -- 30% Magic Haste (55% DW to cap)
-- sets.engaged.MidHaste = set_combine(sets.engaged, {}) -- 49-59% (34% Gear)
-- sets.engaged.MidHaste.LowAcc = set_combine(sets.engaged.MidHaste, {})
-- sets.engaged.MidHaste.MidAcc = set_combine(sets.engaged.MidHaste.LowAcc, {})
-- sets.engaged.MidHaste.HighAcc = set_combine(sets.engaged.MidHaste.MidAcc, {})
-- sets.engaged.MidHaste.Fodder = set_combine(sets.engaged.MidHaste, {})

-- -- 35% Magic Haste (50% DW to cap)
-- sets.engaged.HighHaste = set_combine(set.engaged, {}) -- 38-48% (23% Gear)
-- sets.engaged.HighHaste.LowAcc = set_combine(sets.engaged.HighHaste, {})
-- sets.engaged.HighHaste.MidAcc = set_combine(sets.engaged.HighHaste.LowAcc, {})
-- sets.engaged.HighHaste.HighAcc = set_combine(sets.engaged.HighHaste.MidAcc, {})
-- sets.engaged.HighHaste.Fodder = set_combine(sets.engaged.HighHaste, {})

-- -- 47% Magic Haste (36% DW to cap)
-- sets.engaged.MaxHaste = set_combine(set.engaged, {}) -- 24-34% (9% Gear)
-- sets.engaged.MaxHaste.LowAcc = set_combine(sets.engaged.HighHaste, {})
-- sets.engaged.MaxHaste.MidAcc = set_combine(sets.engaged.MaxHaste.LowAcc, {})
-- sets.engaged.MaxHaste.HighAcc = set_combine(sets.engaged.MaxHaste.MidAcc, {})
-- sets.engaged.MaxHaste.Fodder = set_combine(sets.engaged.MaxHaste, {})


--  ----------------------------------------------------------------------------------------------------
--   Precast Sets
--  ----------------------------------------------------------------------------------------------------
sets.precast = {}

sets.precast.JA = {}
sets.precast.JA['Random Deal'] = { body  = gear.RelicBody }
sets.precast.JA['Snake Eye']   = { legs  = gear.RelicLegs }
sets.precast.JA['Triple Shot'] = { body  = gear.EmpyreanBody }
sets.precast.JA['Wild Card']   = { feet  = gear.RelicFeet }
sets.precast.FoldDoubleBust    = { hands = gear.RelicHands }

sets.precast.CorsairRoll.Base = {
    legs={ name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
    left_ring="Luzaf's Ring",
    back=gear.GunslingerCape,
}
sets.precast.CorsairRoll = set_combine(sets.precast.CorsairRoll.Base, {
    head=gear.RelicHead,-- Duration +50
    hands=gear.EmpyreanHands,-- Duration +55
    legs={ name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
    neck="Regal Necklace",
    left_ring="Luzaf's Ring",
    back=gear.AmbuscadeDT,
})

-- sets.precast.CorsairRoll = {
--     head        = gear.RelicHead,           -- Duration +50
--     body        = gear.EmpyreanBody,
--     hands       = gear.EmpyreanHands,       -- Duration +55
--     legs        = { name     = "Desultor Tassets",
--                     augments = {'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
--     feet        = "Malignance Boots",
--     neck        = "Elite Royal Collar",
--     waist       = "Plat. Mog. Belt",
--     left_ear    = { name     = "Odnowa Earring +1",
--                     augments = {'Path: A',}},
--     right_ear   = gear.EmpyreanEarring,
--     left_ring   = "Barataria Ring",         -- Phantom Roll effect +5
--     right_ring  = "Luzaf's Ring",           -- AoE Radius Increase
--     back        = { name     = "Gunslinger's Cape",
--                     augments = {'Enmity-3','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5','Weapon skill damage +1%',}},
-- }

sets.precast["Allies' Roll"]     = set_combine(sets.precast.CorsairRoll, { hand = gear.EmpyreanHands})
sets.precast["Blitzer's Roll"]   = set_combine(sets.precast.CorsairRoll, { head = gear.EmpyreanHead})
sets.precast["Caster's Roll"]    = set_combine(sets.precast.CorsairRoll, { legs = gear.EmpyreanLegs})
sets.precast["Courser's Roll"]   = set_combine(sets.precast.CorsairRoll, { feet = gear.EmpyreanFeet})
sets.precast["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = gear.EmpyreanBody})
sets.precast["Bolter's Roll"]    = sets.precast.CorsairRoll.Base

--  Quickdraw
sets.precast.CorsairShot = {
    -- ammo        = gear.BulletMA,
    -- head        = gear.ArtefactHead,
    -- body        = gear.RelicBody,
    -- hands       = gear.EmpyreanHands,
    -- legs        = gear.EmpyreanLegs,
    -- feet        = gear.EmpyreanFeet,
    -- neck        = gear.DynamisNeck,
    -- waist       = "Eschan Stone",
    -- left_ear    = "Friomisi Earring",
    -- right_ear   = gear.EmpyreanEarring,
    -- left_ring   = "Dingir Ring",
    -- right_ring  = "Adoulin Ring",
    -- back        = gear.AmbuscadeMagicAcc,
}

sets.precast.CorsairShot["Accuracy"] = {
    ammo=gear.BulletQDAcc
    head=gear.ArtefactHead,
    body="Malignance Tabard",   --  Ikenga's
    hands=gear.ArtefactHands,
    legs="Malignance Tights",
    feet=gear.ArtefactFeet,
    neck=gear.DynamisNeck,
    waist="Kwahu Kachina Belt",
    left_ear="Dedition Earring", -- Crespecular Earring
    right_ear=gear.EmpyreanEarring,
    left_ring="Mummu Ring",
    right_ring="Stikini Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

--  Nyame Path C
sets.precast.CorsairShot["Damage"] = {
    ammo=gear.BulletQDAtt,
    head="Nyame Helm",  -- Ikenga
    body=gear.RelicBody,
    hands="Nyame Gauntlets",    --  Carmine Finger Gauntlets +1
    legs="Nyame Flanchard",
    feet=gear.RelicFeet,
    neck=gear.DynamisNeck,
    waist="Eschan Stone",   --  Skrymir Cord +1
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",   --  Crematio Earring
    left_ring="Dingir Ring",
    right_ring="Adoulin Ring", --  Fenrir Ring +1 (maybe a new limbus ring?)
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}, --   AGI, Magic Acc, MAB

}

sets.precast.CorsairShot["Light Shot"] = set_combine(sets.precast.CorsairShot, {
    body        = gear.EmpyreanBody,
    left_ear    = "Beyla Earring",
    left_ring   = "Mummu Ring",
})

sets.precast.CorsairShot["Dark Shot"] = sets.precast.CorsairShot["Light Shot"]

sets.precast.RA = {
    ammo        = gear.BulletRA,
    head        = gear.EmpyreanHead,
    body        = "Malignance Tabard",
    hands       = "Malignance Gloves",
    legs        = gear.EmpyreanLegs,
    feet        = "Malignance Boots",
    neck        = gear.DynamisNeck,
    waist       = "Ponente Sash",
    left_ear    = "Beyla Earring",
    right_ear   = "Enervating Earring",
    left_ring   = "Dingir Ring",
    right_ring  = "Ephramad's Ring",
    back        = gear.AmbuscadeRangedAcc,
}

sets.precast.FC = {
    head        = { name     = "Herculean Helm",
                    augments = {'Attack+12','Weapon skill damage +5%',}},
    body        = "Malignance Tabard",
    hands       = "Malignance Gloves",
    legs        = { name     = "Rawhide Trousers",
                    augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    feet        = "Malignance Boots",
    neck        = { name     = "Loricate Torque +1",
                    augments = {'Path: A',}},
    waist       = { name     = "Sailfi Belt +1",
                    augments = {'Path: A',}},
    left_ear    = "Infused Earring",
    right_ear   = "Loquac. Earring",
    left_ring   = "Murky Ring",
    right_ring  = "Kishar Ring",
    back        = gear.AmbuscadeFC,
}

sets.precast.Waltz = {
    head        = "Mummu Bonnet +2",
    body        = gear.ArtefactBody,
    hands       = gear.ArtefactHands,
    legs        = { name     = "Desultor Tassets",
                    augments = {'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
    feet        = { name     = "Rawhide Boots",
                    augments = {'STR+8','Attack+11','"Store TP"+4',}},
    neck        = "Elite Royal Collar",
    waist       = "Chaac Belt",
    left_ear    = { name     = "Odnowa Earring +1",
                    augments = {'Path: A',}},
    right_ear   = "Tuisto Earring",
    left_ring   = "Murky Ring",
    right_ring  = "Petrov Ring",
    back        = gear.AmbuscadeFC,
}
sets.precast['Curing Waltz'] = sets.precast.Waltz
sets.precast['Divine Waltz'] = sets.precast.Waltz

--  ----------------------------------------------------------------------------------------------------
--   Precast Sets - Weapon Skills
--  ----------------------------------------------------------------------------------------------------
sets.precast.WS = {
    ammo        =  gear.BulletWS,
    head        = { name     = "Herculean Helm",
                    augments = {'Attack+12','Weapon skill damage +5%',}},
    body        = gear.ArtefactBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.HerculeanLegs.WsPhys,
    feet        = gear.RelicFeet,
    neck        = { name     = "Commodore Charm",
                    augments = {'Path: A',}},
    waist       = "Sailfi Belt +1",
    left_ear    = "Ishvara Earring",
    right_ear   = "Moonshade Earring",
    left_ring   = "Ilabrat Ring",
    right_ring  = "Ephramad's Ring",
}
sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

sets.precast.WS.Melee = set_combine(sets.precast.WS, { back = gear.AmbuscadeMeleeWS, })
--  Melee: Dagger
sets.precast.WS['Eviscerationn'] = set_combine(sets.precast.WS, {})
sets.precast.WS['Eviscerationn'].Acc = set_combine(sets.precast.WS['Eviscerationn'], {})
--  Melee: Sword
sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})

sets.precast.WS.Ranged = set_combine(sets.precast.WS, { back = gear.AmbuscadeRangedWSPhys, })
--  Ranged: Marksmanship
--  Elemental info: Light/Fire Belt, Light/Flame Gorget
sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
    head        = gear.RelicHead,
    body        = gear.ArtefactBody,
    hands       = { name     = "Herculean Gloves",
                    augments = {'Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+11',}},
    legs        = gear.HerculeanLegs.WsMAB,
    feet        = gear.RelicFeet,
    neck        = gear.DynamisNeck,     --"Elemental Gorget"
    waist       = "Kwahu Kachina Belt", --"Elemental Belt"
    left_ear    = "Ishvara Earring",
    right_ear   = "Moonshade Earring",
    left_ring   = "Dingir Ring",
    right_ring  = "Ilabrat Ring",
    back        = gear.AmbuscadeRangedWSPhys,
})
sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})

--  Elemental info: Fire (Karin Obi)
sets.precast.WS['Wildfire'] = {
    head        = { name     = "Herculean Helm",
                    augments = {'Attack+12','Weapon skill damage +5%',}},
    body        = gear.RelicBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.HerculeanLegs.WsMAB,
    feet        = gear.RelicFeet,
    neck        = gear.DynamisNeck,
    waist       = "Eschan Stone",
    left_ear    = "Friomisi Earring",
    right_ear   = "Enervating Earring",
    left_ring   = "Dingir Ring",
    right_ring  = "Ilabrat Ring",
    back        = gear.AmbuscadeRangedWSMagic,
}
sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})

--  Elemental info: Dark (Anrin Obi)
sets.precast.WS['Leaden Salute'] = {
    head        = "Pixie Hairpin +1",
    body        = gear.RelicBody,
    hands       = gear.EmpyreanHands,
    legs        = "Malignance Tights",
    feet        = gear.RelicFeet,
    neck        = gear.DynamisNeck,
    waist       = "Eschan Stone",
    left_ear    = "Friomisi Earring",
    right_ear   = { name     = "Moonshade Earring",
                    augments = {'Accuracy+4','TP Bonus +250',}},
    left_ring   = "Dingir Ring",
    right_ring  = "Archon Ring",
    back        = gear.AmbuscadeRangedWSMagic,
}
sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], {})


--  ----------------------------------------------------------------------------------------------------
--   Midcast Sets
--  ----------------------------------------------------------------------------------------------------
sets.midcast = {}

sets.midcast.RA = set_combine(sets.precast.RA, {
    waist       = "Kwahu Kachina Belt",
})

--  ----------------------------------------------------------------------------------------------------
--   Misc Sets
--  ----------------------------------------------------------------------------------------------------
-- Defense sets (physical / magical)
sets.defense.PDT = {
    head        = gear.EmpyreanHead,                -- 9/9
    body        = gear.EmpyreanBody,                -- 12/12
    hands       = "Malignance Gloves",              -- 5/5
    legs        = gear.EmpyreanLegs,                -- 11/11
    feet        = "Malignance Boots",               -- 4/4
    neck        = "Elite Royal Collar",             -- 5/5
    waist       = "Plat. Mog. Belt",                -- 3/3
    left_ear    = "Infused Earring",                -- 0/0, Regen +1
    right_ear   = { name     = "Odnowa Earring +1", -- 3/5
                    augments = {'Path: A',}},
    left_ring   = "Murky Ring",                 -- 10/10
    right_ring  = "Sheltered Ring",                 -- 0/0, Regen +1
    back        = gear.AmbuscadeDT,                 -- 5/5
}

sets.defense.MDT = sets.defense.PDT
sets.Kiting = {}
