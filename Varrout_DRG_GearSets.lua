--  ----------------------------------------------------------------------------------------------------
--   Job Specific Armour
--  ----------------------------------------------------------------------------------------------------
gear.ArtefactHead  = "Vishap Armet +2"
gear.ArtefactBody  = "Vishap Mail +2"
gear.ArtefactHands = "Vishap Finger Gauntlets +2"
gear.ArtefactLegs  = "Vishap Brais +2"
gear.ArtefactFeet  = "Vishap Greaves +2"

gear.RelicHead  = "Pteroslaver Armet +3"
gear.RelicBody  = "Pteroslaver Mail +3"
gear.RelicHands = "Pteroslaver Finger Gauntlets +3"
gear.RelicLegs  = "Pteroslaver Brais +3"
gear.RelicFeet  = "Pteroslaver Geaves +3"

gear.EmpyreanHead  = "Peltast's Mezail +1"
gear.EmpyreanBody  = "Peltast's Plackart +1"
gear.EmpyreanHands = "Peltast's Vambraces +1"
gear.EmpyreanLegs  = "Peltast's Cuissots +1"
gear.EmpyreanFeet  = "Peltast's Schynbalds +1"

gear.EmpyreanEarring = "Peltast's Earring"
gear.DynamisNeck     = ""

--  REMA Weapons
gear.WeaponRelic    = "Gungnir"
gear.WeaponMythic   = "Ryunohige"
gear.WeaponEmpyrean = ""
gear.WeaponAeonic   = "Trishula"
gear.WeaponPrime    = ""

--  Ambuscade Capes
gear.AmbuscadeCapeTP = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
gear.AmbuscadeCapeWS = ""
gear.AmbuscadeCapeFC = { name="Brigantia's Mantle", augments={'Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
gear.AmbuscadeCapeDT = { name="Brigantia's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
gear.AmbuscadeCapeJump = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}

--  ----------------------------------------------------------------------------------------------------
--   Town Sets
--  ----------------------------------------------------------------------------------------------------

--  ----------------------------------------------------------------------------------------------------
--   Idle Sets
--  ----------------------------------------------------------------------------------------------------
sets.idle = {
    ammo="Voluspa Tathlum",
    head="Hjarrandi Helm",
    body=gear.ArtefactBody,
    hands="Sulev. Gauntlets +2",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bathy Choker +1",
    waist="Plat. Mog. Belt",
    left_ear="Infused Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring="Sheltered Ring",
    back=gear.AmbuscadeCapeDT,
}

sets.idle.DT = {
    ammo="Voluspa Tathlum",
    head="Hjarrandi Helm",
    body=gear.ArtefactBody,
    hands=gear.RelicHands,
    legs=gear.RelicLegs,
    feet="Sulev. Leggings +2",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Plat. Mog. Belt",
    left_ear="Infused Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring="Sheltered Ring",
    back=gear.AmbuscadeCapeDT,
}

sets.idle.Refresh = {
    head={ name="Valorous Mask", augments={'VIT+4','DEX+2','"Refresh"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    right_ear = "Moonshade Earring"
}
sets.idle.RefreshToAU = {right_ring = "Balrahn's Ring"}

--  ----------------------------------------------------------------------------------------------------
--   Engaged Sets
--  ----------------------------------------------------------------------------------------------------
sets.engaged = {
    ammo="Voluspa Tathlum",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Asperity Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Sherida Earring",
    right_ear="Digni. Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back=gear.AmbuscadeCapeTP,
}


--  ----------------------------------------------------------------------------------------------------
--   Precast Sets
--  ----------------------------------------------------------------------------------------------------
sets.precast = {}
sets.precast.JA = {}
sets.precast.WS = {}

sets.precast.JA['Ancient Circle'] = {legs=gear.ArtefactLegs,}
sets.precast.JA['Angon'] = {
    ammo     = "Angon",
    hands=gear.RelicHands,
    left_ear = "Dragoon's Earring",
}
sets.precast.JA['Call Wyvern'] = {body=gear.RelicBody,}
sets.precast.JA['Deep Breathing'] = {head=gear.RelicHead,}
sets.precast.JA['Spirit Surge'] = {body=gear.RelicBody,}
sets.precast.JA['Spirit Link'] = {
    head=gear.ArtefactHead,
    hands=gear.EmpyreanHands,
    -- right_ear="Pratick Earring",
}

sets.precast.JA['Jump'] = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Sulevia's Mask +2",
    body=gear.RelicBody,
    hands=gear.ArtefactHands,
    legs=gear.RelicLegs,
    feet=gear.ArtefactFeet,
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Sherida Earring",
    right_ear="Digni. Earring",
    left_ring="Flamma Ring",
    right_ring="Regal Ring",
    back=gear.AmbuscadeCapeJump,
}
sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {legs=gear.RelicLegs,})
sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {legs=gear.EmpyreanLegs, feet=gear.EmpyreanFeet,})
sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {legs=gear.EmpyreanLegs,})

sets.precast.WS['Stardiver'] = {
    ammo="Knobkierrie",
    head="Flamma Zucchetto +2",
    neck="Shadow Gorget",
    ear1="Sherida Earring",
    ear2="Dignitary's Earring",
    body="Flamma Korazin +2",
    hands="Flamma Manopolas +2",
    ring1="Niqmaddu Ring",
    ring2="Pyrosoul Ring",
    back=gear.AmbuscadeCapeWS,
    waist="Fotia Belt",
    legs="Vishap Brais +2",
    feet="Sulevia's Leggings +2"
}

sets.precast.WS['Camlann\'s Torment'] = {
    ammo="Knobkierrie",
    head="Flamma Zucchetto +2",
    neck="Light Gorget",
    ear1="Sherida Earring",
    ear2="Ishvara Earring",
    body="Flamma Korazin +2",
    hands="Sulevia's Gauntlets +2",
    ring1="Niqmaddu Ring",
    ring2="Pyrosoul Ring",
    back=gear.AmbuscadeCapeWS,
    waist="Fotia Belt",
    legs="Vishap Brais +2",
    feet="Sulevia's Leggings +2"
}

sets.precast.WS['Drakesbane'] = {
    ammo="Knobkierrie",
    head="Valorous Mask",
    neck="Light Gorget",
    ear1="Sherida Earring",
    ear2="Dignitary's Earring",
    body="Flamma Korazin +2",
    hands="Flamma Manopolas +2",
    ring1="Niqmaddu Ring",
    ring2="Rajas Ring",
    back=gear.AmbuscadeCapeWS,
    waist="Fotia Belt",
    legs="Vishap Brais +2",
    feet="Sulevia's Leggings +2"
}

sets.precast.WS['Impulse Drive'] = {}

sets.precast.FC = {
    main={ name="Trishula", augments={'Path: A',}},
    sub="Utu Grip",
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Hjarrandi Helm",
    body="Sulevia's Plate. +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Baetyl Pendant",
    waist="Plat. Mog. Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Evanescence Ring",
    right_ring="Medada's Ring",
    back=gear.AmbuscadeCapeFC,
}

sets.precast.Trust = {
    head=gear.ArtefactHead,
    body=gear.ArtefactBody,
    hands=gear.ArtefactHands,
    legs=gear.ArtefactLegs,
    feet=gear.ArtefactFeet,
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
    ammo="Voluspa Tathlum",
    head=gear.RelicHead,
    body="Wyvern Mail",
    hands="Despair Fin. Gaunt.",
    legs=gear.ArtefactLegs,
    feet=gear.RelicFeet,
    neck="Lancer's Torque",
    waist="Glassblower's Belt",
    left_ear="Infused Earring",
    right_ear="Dragoon's Earring",
    left_ring="Defending Ring",
    right_ring="Dreki Ring",
    back={ name="Updraft Mantle", augments={'STR+4','Pet: Breath+10','Pet: Damage taken -2%','Weapon skill damage +2%',}},
}

sets.Pet.HealingBreathTrigger = {head=gear.ArtefactHead,}

sets.Pet["Restoring Breath"] = set_combine(sets.Pet.WyvernHP, {})
sets.Pet["Steady Wing"] = set_combine(sets.Pet.WyvernHP, {})
sets.Pet.ElementalBreath = {
    ammo="Voluspa Tathlum",
    head=gear.RelicHead,
    body="Gleti's Cuirass",
    hands=gear.ArtefactHands,
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Lancer's Torque",
    waist="Glassblower's Belt",
    left_ear="Infused Earring",
    right_ear="Dragoon's Earring",
    left_ring="Defending Ring",
    right_ring="Dreki Ring",
    back=gear.AmbuscadeCapeWS,
}
