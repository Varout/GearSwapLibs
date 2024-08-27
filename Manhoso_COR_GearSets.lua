--  ----------------------------------------------------------------------------------------------------
--   Job Specific Armour
--  ----------------------------------------------------------------------------------------------------
gear.ArtefactHead  = "Laksamana's Tricorne +2"
gear.ArtefactBody  = "Laksamana's Frac +3"
gear.ArtefactHands = "Laksamana's Gants +2"
gear.ArtefactLegs  = "Laksamana's Trews +2"
gear.ArtefactFeet  = "Laksamana's Bottes +2"

gear.RelicHead  = "Launun Tricorne +2"
gear.RelicBody  = "Launun Frac +3"
gear.RelicHands = "Launun Gants +2"
gear.RelicLegs  = "Launun Trews +3"
gear.RelicFeet  = "Launun Bottes +3"

gear.EmpyreanHead  = "Chasseur's Tricorne +2"
gear.EmpyreanBody  = "Chasseur's Frac +2"
gear.EmpyreanHands = "Chasseur's Gants +2"
gear.EmpyreanLegs  = "Chasseur's Culottes +2"
gear.EmpyreanFeet  = "Chasseur's Bottes +2"

gear.EmpyreanEarring = { name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}}
gear.DynamisNeck     = "Commodore Charm"

--  REMA Weapons
gear.WeaponMythic   = "Death Penalty"   -- Not yet
gear.WeaponEmpyrean = "Armageddon"      -- Not completed
gear.WeaponAeonic   = "Fomalhaut"
gear.WeaponPrime    = "Earp"            -- Not yet
--  Other Weapons
gear.WeaponTPBonus  = { name = "Ataktos",     augments = {'Delay:+60','TP Bonus +1000',}}
gear.WeaponPhantom  = { name = "Compensator", augments = {'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}}    -- Phantom Roll Duration +20

--  Special Ammo
gear.BulletMA = "Chrono Bullet"
gear.BulletQD = "Animikii Bullet"
gear.BulletRA = "Chrono Bullet"
gear.BulletWS = "Chrono Bullet"

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
gear.AmbuscadeDT = gear.AmbuscadeMeleeAcc
gear.AmbuscadeFC            = { name     = "Camulus's Mantle",
                                augments = {'"Fast Cast"+10','Damage taken-5%',}},



--  ----------------------------------------------------------------------------------------------------
--   Town Sets
--  ----------------------------------------------------------------------------------------------------

--  ----------------------------------------------------------------------------------------------------
--   Idle Sets
--  ----------------------------------------------------------------------------------------------------
sets.resting = {}

-- Idle sets
sets.idle = {
    ammo= gear.RAbullet,
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Elite Royal Collar",
    waist="Platinum Moogle Belt",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Sheltered Ring",
    back=gear.AmbuscadeMeleeAcc,
}

sets.idle.refresh = set_combine(sets.idle,
{
    head="Rawhide Mask",
    legs= { name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
})


--  ----------------------------------------------------------------------------------------------------
--   Engaged Sets
--  ----------------------------------------------------------------------------------------------------
-- No Magic Haste (72% DW to cap)
sets.engaged.Normal = {
    ammo=gear.RAbullet,
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Malignance Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
    neck="Asperity Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Petrov Ring",
    right_ring="Epona's Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

sets.engaged.Hybrid = {
    ammo= gear.RAbullet,
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring="Epona's Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}


--  ----------------------------------------------------------------------------------------------------
--   Precast Sets
--  ----------------------------------------------------------------------------------------------------
sets.precast = {}

sets.precast.JA['Triple Shot'] = {
    body        = gear.EmpyreanBody
}
sets.precast.JA['Snake Eye'] = {
    legs        = gear.RelicLegs
}
sets.precast.JA['Wild Card'] = {
    feet        = gear.RelicFeet
}
sets.precast.JA['Random Deal'] = {
    body        = gear.RelicBody
}

sets.precast.RA = {
    head=gear.EmpyreanHead,
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs=gear.EmpyreanLegs,
    feet="Malignance Boots",
    neck=gear.DynamisNeck,
    waist="Kwahu Kachina Belt",
    left_ear="Beyla Earring",
    right_ear="Enervating Earring",
    left_ring="Dingir Ring",
    right_ring="Ephramad's Ring",
    back=gear.AmbuscadeRangedAcc,
}

sets.precast.CorsairRoll = {
    head        =  gear.RelicHead,
    body        = "Malignance Tabard",
    hands       = gear.EmpyreanHands,
    legs={ name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
    feet        = "Malignance Boots",
    neck        = "Elite Royal Collar",
    waist       = "Kwahu Kachina Belt",
    left_ear    = "Odnowa Earring +1",
    right_ear   = "Tuisto Earring",
    left_ring   = "Barataria Ring",
    right_ring  = "Luzaf's Ring",
    back={ name="Gunslinger's Cape", augments={'Enmity-3','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5','Weapon skill damage +1%',}},
}

sets.precast["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
    head        = gear.EmpyreanHead
})
sets.precast["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
    body        = gear.EmpyreanBody
})
sets.precast["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {
    hand        = gear.EmpyreanHands
})
sets.precast["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
    legs        = gear.EmpyreanLegs
})
sets.precast["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
    feet        = gear.EmpyreanFeet
})

sets.precast.QuickDraw = {
    head        = gear.ArtefactHead,
    body        = gear.RelicBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.EmpyreanLegs,
    feet        = gear.EmpyreanFeet,
    neck        = gear.DynamisNeck,
    waist       = "Eschan Stone",
    left_ear    = "Friomisi Earring",
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Dingir Ring",
    right_ring  = "Adoulin Ring",
    back        = { name     = "Camulus's Mantle",
                    augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
}

sets.precast.WS = {
    ammo= gear.BulletWS,
    head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
    body="Laksa. Frac +3",
    hands="Chasseur's Gants +2",
    legs={ name="Herculean Trousers", augments={'Accuracy+27','Weapon skill damage +5%','AGI+8',}},
    feet="Lanun Bottes +3",
    neck={ name="Commodore Charm", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Ilabrat Ring",
    right_ring="Ephramad's Ring",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

sets.precast.WS.Melee = {}
--  Melee: Dagger
sets.precast.WS['Eviscerationn'] = set_combine(sets.precast.WS, {})
--  Melee: Sword
sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

sets.precast.WS.Ranged = {}
--  Ranged: Marksmanship
--  Elemental info: Light/Fire Belt, Light/Flame Gorget
sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
    ammo= gear.WSbullet,
    head="Lanun Tricorne +2",
    body="Laksa. Frac +3",
    hands={ name="Herculean Gloves", augments={'Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+11',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Commodore Charm", augments={'Path: A',}},  --"Fotia Gorget"
    waist="Kwahu Kachina Belt",  --"Fotia Belt"
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
})

--  Elemental info:
sets.precast.WS['Wildfire'] = {
    ammo= gear.WSbullet,  --Orichalcum or Living Bullet
    head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands="Chasseur's Gants +2",
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Commodore Charm", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Enervating Earring",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

sets.precast.WS['Leaden Salute'] = {
    head="Pixie Hairpin +1",
    body=gear.RelicBody,
    hands=gear.EmpyreanBody,
    legs="Malignance Tights",
    feet=gear.RelicFeet,
    neck=gear.DynamisNeck,
    waist="Svelt. Gouriz +1",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",
    right_ring="Adoulin Ring",
    back=gear.AmbuscadeRangedWSMagic,
}

sets.precast.FC = {
    head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    feet="Malignance Boots",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Infused Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

--  ----------------------------------------------------------------------------------------------------
--   Midcast Sets
--  ----------------------------------------------------------------------------------------------------
sets.midcast = {}

--  ----------------------------------------------------------------------------------------------------
--   Misc Sets
--  ----------------------------------------------------------------------------------------------------
    -- Defense sets
    sets.defense.PDT =
    {
        -- head="Meghanada Visor +2", --?/0
        -- body="Meg. Cuirie +2", --7/0
        -- hands="Meg. Gloves +2", --3/0
        -- legs="Meg. Chausses +2", --5/0
        -- feet="Meg. Jam. +2", --4/0
        -- neck="Loricate Torque +1", --6/6
        -- ear2="Odnowa Earring +1", --0/2
        -- ring1="Defending Ring", --10/10
        -- waist="Flume Belt +1", --4/0
    }

    sets.defense.MDT = sets.defense.PDT
    sets.Kiting = {}
