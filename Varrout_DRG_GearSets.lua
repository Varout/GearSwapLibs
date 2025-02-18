--  ----------------------------------------------------------------------------------------------------
--   Job Specific Armour
--  ----------------------------------------------------------------------------------------------------
gear.ArtefactHead      = "Vishap Armet +2"
gear.ArtefactBody      = "Vishap Mail +2"
gear.ArtefactHands     = "Vishap Finger Gauntlets +3"
gear.ArtefactLegs      = "Vishap Brais +3"
gear.ArtefactFeet      = "Vishap Greaves +2"

gear.RelicHead         = "Pteroslaver Armet +3"
gear.RelicBody         = "Pteroslaver Mail +3"
gear.RelicHands        = "Pteroslaver Finger Gauntlets +3"
gear.RelicLegs         = "Pteroslaver Brais +3"
gear.RelicFeet         = "Pteroslaver Geaves +3"

gear.EmpyreanHead      = "Peltast's Mezail +3"
gear.EmpyreanBody      = "Peltast's Plackart +3"
gear.EmpyreanHands     = "Peltast's Vambraces +3"
gear.EmpyreanLegs      = "Peltast's Cuissots +3"
gear.EmpyreanFeet      = "Peltast's Schynbalds +3"

gear.EmpyreanEarring   = "Peltast's Earring +1"
gear.DynamisNeck       = "Dragoon's Collar +2"

--  REMA Weapons
gear.WeaponRelic       = "Gungnir"
gear.WeaponMythic      = "Ryunohige"
gear.WeaponEmpyrean    = ""
gear.WeaponAeonic      = "Trishula"
-- gear.WeaponPrime       = "Gae Buide"

--  Ambuscade Capes
gear.AmbuscadeCapeTP   = { name = "Brigantia's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
gear.AmbuscadeCapeWS   = { name = "Brigantia's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
gear.AmbuscadeCapeFC   = { name = "Brigantia's Mantle", augments = {'Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
gear.AmbuscadeCapeDT   = { name = "Brigantia's Mantle", augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
gear.AmbuscadeCapeJump = { name = "Brigantia's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}


--  Nyame
-- gear.NyameHead         = { name = "Nyame Helm", augments = {'Path: B',}}
gear.NyameBody         = { name = "Nyame Mail", augments = {'Path: B',}}
-- gear.NyameHands        = { name = "Nyame Gauntlets", augments = {'Path: B',}}
-- gear.NyameLegs         = { name = "Nyame Flanchard", augments = {'Path: B',}}
gear.NyameFeet         = { name = "Nyame Sollerets", augments = {'Path: B',}}

--  ----------------------------------------------------------------------------------------------------
--   Town Sets
--  ----------------------------------------------------------------------------------------------------
sets.lockstyle = {
    head        = gear.ArtefactHead,
    body        = gear.ArtefactBody,
    hands       = gear.ArtefactHands,
    legs        = gear.ArtefactLegs,
    feet        = gear.ArtefactFeet,
}


--  ----------------------------------------------------------------------------------------------------
--   Idle Sets
--  ----------------------------------------------------------------------------------------------------
sets.idle = {
    ammo        = "Voluspa Tathlum",
    head        = "Hjarrandi Helm",
    body        = gear.ArtefactBody,
    hands       = "Sulev. Gauntlets +2",
    legs        = gear.EmpyreanLegs,
    feet        = "Gleti's Boots",
    neck        = "Bathy Choker +1",
    waist       = "Plat. Mog. Belt",
    left_ear    = { name     = "Odnowa Earring +1",
                    augments = {'Path: A',}},
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Defending Ring",
    right_ring  = "Dreki Ring",
    back        = gear.AmbuscadeCapeDT,
}

sets.idle.DT = {
    ammo        = "Voluspa Tathlum",
    head        = "Hjarrandi Helm",
    body        = gear.ArtefactBody,
    hands       = gear.RelicHands,
    legs        = gear.EmpyreanLegs,
    feet        = "Sulev. Leggings +2",
    neck        = { name     = "Loricate Torque +1",
                    augments = {'Path: A',}},
    waist       = "Plat. Mog. Belt",
    left_ear    = { name     = "Odnowa Earring +1",
                    augments = {'Path: A',}},
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Defending Ring",
    right_ring  = "Dreki Ring",
    back        = gear.AmbuscadeCapeDT,
}

sets.idle.Refresh = {
    head        = { name     = "Valorous Mask",
                    augments = {'VIT+4','DEX+2','"Refresh"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    left_ear    = "Moonshade Earring",
    left_ring  = "Gurebu-Ogurebu's Ring",
}

sets.idle.RefreshToAU = {
    right_ring  = "Balrahn's Ring",
}


--  ----------------------------------------------------------------------------------------------------
--   Engaged Sets
--  ----------------------------------------------------------------------------------------------------
-- sets.engaged = {
--     ammo        = "Coiste Bodhar",
--     head        = gear.EmpyreanHead,
--     body        = gear.EmpyreanBody,
--     hands       = gear.EmpyreanHands,
--     legs        = gear.EmpyreanLegs,
--     feet        = gear.EmpyreanFeet,
--     neck        = gear.DynamisNeck,
--     waist       = "Ioskeha Belt +1",
--     left_ear    = "Sherida Earring",
--     right_ear   = gear.EmpyreanEarring,
--     left_ring   = "Niqmaddu Ring",
--     right_ring  = "Dreki Ring",
--     back        = gear.AmbuscadeCapeTP,
-- }

sets.engaged = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Hjarrandi Helm",
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands="Pel. Vambraces +3",
    legs="Gleti's Breeches",
    feet="Flam. Gambieras +2",
    neck="Vim Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Sroda Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Dreki Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
}

sets.engaged['GlassCannon'] = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Hjarrandi Helm",
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands="Pel. Vambraces +3",
    legs="Gleti's Breeches",
    feet="Flam. Gambieras +2",
    neck="Vim Torque +1",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Sroda Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Dreki Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
}

sets.engaged['HighDT'] = sets.engaged

sets.engaged['Naegling'] = sets.engaged

--  ----------------------------------------------------------------------------------------------------
--   Precast Sets
--  ----------------------------------------------------------------------------------------------------
sets.precast = {}
sets.precast.JA = {}

sets.precast.JA['Ancient Circle'] = { legs = gear.ArtefactLegs, }
sets.precast.JA['Call Wyvern']    = { body = gear.RelicBody, }
sets.precast.JA['Deep Breathing'] = { head = gear.RelicHead, }
sets.precast.JA['Spirit Surge']   = { body = gear.RelicBody, }
sets.precast.JA['Spirit Link'] = {
    head        = gear.ArtefactHead,
    hands       = gear.EmpyreanHands,
    -- right_ear="Pratick Earring",
}
sets.precast.JA['Angon'] = {
    ammo        = "Angon",
    hands       = gear.RelicHands,
    left_ear    = "Dragoon's Earring",
}

sets.precast.JA['Jump'] = {
    ammo        = { name     = "Coiste Bodhar",
                    augments = {'Path: A',}},
    head        = "Sulevia's Mask +2",
    body        = gear.RelicBody,
    hands       = gear.ArtefactHands,
    legs        = gear.RelicLegs,
    feet        = gear.ArtefactFeet,
    neck        = "Shulmanu Collar",
    waist       = "Ioskeha Belt +1",
    left_ear    = "Sherida Earring",
    right_ear   = "Digni. Earring",
    left_ring   = "Flamma Ring",
    right_ring  = "Regal Ring",
    back        = gear.AmbuscadeCapeJump,
}
sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {
    legs        = gear.RelicLegs,
})
sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {
    legs        = gear.EmpyreanLegs,
    feet        = gear.EmpyreanFeet,
})
sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
    legs        = gear.EmpyreanLegs,
})

sets.precast.WS = {
    ammo        = "Knobkierrie",
    head        = gear.EmpyreanHead,
    neck        = gear.DynamisNeck,
    left_ear    = "Thrud Earring",
    right_ear   = "Ishvara Earring",
    body        = gear.NyameBody,
    hands       = gear.RelicHands,
    left_ring   = "Niqmaddu Ring",
    right_ring  = "Regal Ring",
    back        = gear.AmbuscadeCapeWS,
    waist       = "Sailfi Belt +1",
    legs        = gear.ArtefactLegs,
    feet        = "Sulevia's Leggings +2",
}

sets.precast.WS.STR = set_combine(sets.precast.WS, {})

sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS.STR, {
    neck        = "Shadow Gorget",
    waist       = "Fotia Belt",
})

sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS.STR, {
    body        = "Gleti's Cuirass",
    right_ear   = gear.EmpyreanEarring,
    neck        = "Light Gorget",
    waist       = "Fotia Belt",
})

sets.precast.WS['Wheeling Thrust'] = sets.precast.WS.STR
sets.precast.WS['Camlann\'s Torment'] = sets.precast.WS.STR
sets.precast.WS['Impulse Drive'] = sets.precast.WS.STR

sets.precast.WS.Acc = {
    ammo        = "Voluspa Tathlum",
    head        = gear.EmpyreanHead,
    body        = gear.EmpyreanBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.EmpyreanLegs,
    feet        = gear.EmpyreanFeet,
    neck        = gear.DynamisNeck,
    waist       = "Ioskeha Belt +1",
    left_ear    = "Dignitary's Earring",
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Varar Ring +1",
    right_ring  = "Dreki Ring",
    back        = gear.AmbuscadeCapeJump,
}

sets.precast.WS['Geirskogul'] = sets.precast.WS.Acc

sets.precast.WS['Leg Sweep'] = {
    ammo        = "Pemphredo Tathlum",
    head        = gear.EmpyreanHead,
    body        = gear.EmpyreanBody,
    hands       = gear.EmpyreanHands,
    legs        = gear.EmpyreanLegs,
    feet        = gear.EmpyreanFeet,
    neck        = gear.DynamisNeck,
    waist       = "Fotia Belt",
    left_ear    = "Gwati Earring",
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Stikini Ring +1",
    right_ring  = "Flamma Ring",
    back        = gear.AmbuscadeCapeTP,
}

sets.precast.WS.Mab = {}

sets.precast.FC = {
    ammo        = { name     = "Coiste Bodhar",
                    augments = {'Path: A',}},
    head        = "Hjarrandi Helm",
    body        = "Sulevia's Plate. +2",
    hands       = { name     = "Leyline Gloves",
                    augments = {'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs        = "Sulev. Cuisses +2",
    feet        = "Sulev. Leggings +2",
    neck        = "Baetyl Pendant",
    waist       = "Plat. Mog. Belt",
    left_ear    = "Loquac. Earring",
    right_ear   = "Etiolation Earring",
    left_ring   = "Evanescence Ring",
    right_ring  = "Defending Ring",
    back        = gear.AmbuscadeCapeFC,
}

sets.precast.FC['Trust'] = {
    head        = gear.ArtefactHead,
    body        = gear.ArtefactBody,
    hands       = gear.ArtefactHands,
    legs        = gear.ArtefactLegs,
    feet        = gear.ArtefactFeet,
}

sets.precast.Waltz = {}


--  ----------------------------------------------------------------------------------------------------
--   Midcast Sets
--  ----------------------------------------------------------------------------------------------------
sets.midcast = {}


--  ----------------------------------------------------------------------------------------------------
--   Misc Sets
--  ----------------------------------------------------------------------------------------------------

sets.Pet = {}
sets.Pet.WyvernHP = {
    ammo        = "Voluspa Tathlum",
    head        = gear.RelicHead,
    body        = "Wyvern Mail",
    hands       = "Despair Fin. Gaunt.",
    legs        = gear.ArtefactLegs,
    feet        = gear.RelicFeet,
    neck        = gear.DynamisNeck,
    waist       = "Glassblower's Belt",
    left_ear    = "Dragoon's Earring",
    right_ear   = gear.EmpyreanEarring,
    left_ring   = "Defending Ring",
    right_ring  = "Dreki Ring",
    back        = { name     = "Updraft Mantle",
                    augments = {'STR+4','Pet: Breath+10','Pet: Damage taken -2%','Weapon skill damage +2%',}},
}

sets.Pet.HealingBreathTrigger = {head=gear.ArtefactHead,}

sets.Pet["Restoring Breath"] = set_combine(sets.Pet.WyvernHP, {})
sets.Pet["Steady Wing"] = set_combine(sets.Pet.WyvernHP, {})
sets.Pet.ElementalBreath = {
    ammo        = "Voluspa Tathlum",
    head        = gear.RelicHead,
    body        = "Gleti's Cuirass",
    hands       = gear.ArtefactHands,
    legs        = "Gleti's Breeches",
    feet        = "Gleti's Boots",
    neck        = "Lancer's Torque",
    waist       = "Glassblower's Belt",
    left_ear    = "Infused Earring",
    right_ear   = "Dragoon's Earring",
    left_ring   = "Defending Ring",
    right_ring  = "Dreki Ring",
    back        = gear.AmbuscadeCapeWS,
}
