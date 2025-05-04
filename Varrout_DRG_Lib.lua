--  Varrout GitHub: https://github.com/Varout/GearSwapLibs
--  Gear sets inspired from: https://www.bg-wiki.com/ffxi/Dragoon_Guide_By_Kaius

include('Mote-Globals.lua')
include('Lib_DRG.lua')

characterPocketMode = false

function init_gear_sets()
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
    gear.WeaponPrime       = "Gae Buide"

    --  Ambuscade Capes
    gear.AmbuscadeCapeTP    = { name = "Brigantia's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.AmbuscadeCapeWSDmg = { name = "Brigantia's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.AmbuscadeCapeWSDa  = { name = "Brigantia's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.AmbuscadeCapeFC    = { name = "Brigantia's Mantle", augments = {'Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
    gear.AmbuscadeCapeDT    = { name = "Brigantia's Mantle", augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
    gear.AmbuscadeCapeJump  = { name = "Brigantia's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}

    --  Nyame
    gear.NyameHead         = { name = "Nyame Helm", augments = {'Path: B',}}
    gear.NyameBody         = { name = "Nyame Mail", augments = {'Path: B',}}
    gear.NyameHands        = { name = "Nyame Gauntlets", augments = {'Path: B',}}
    gear.NyameLegs         = { name = "Nyame Flanchard", augments = {'Path: B',}}
    gear.NyameFeet         = { name = "Nyame Sollerets", augments = {'Path: B',}}

    --  Gleti's
    gear.GletiHead = "Gleti's Mask"
    gear.GletiBody = { name="Gleti's Cuirass", augments={'Path: A',}}
    gear.GletiHands = "Gleti's Gauntlets"
    gear.GletiLegs = "Gleti's Breeches"
    gear.GletiFeet = "Gleti's Boots"

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
    sets.Movement = {
        legs = "Carmine Cuisses +1"
    }

    sets.Refresh = {
        head        = { name     = "Valorous Mask",
                        augments = {'VIT+4','DEX+2','"Refresh"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
        left_ear    = "Moonshade Earring",
        left_ring="Gurebu's Ring",
    }

    sets.RefreshToAU = {
        right_ring  = "Balrahn's Ring",
    }

    sets.idle = {}
    sets.idle["Normal"] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head=gear.GletiHead,
        body=gear.GletiBody,
        hands=gear.GletiHands,
        legs=gear.GletiLegs,
        feet=gear.GletiFeet,
        neck="Bathy Choker +1",
        waist="Null Belt",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear=gear.EmpyreanEarring,
        left_ring="Gurebu's Ring",
        right_ring="Defending Ring",
        back=gear.AmbuscadeCapeDT,
    }

    sets.idle["DT"] = {
        ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm",
        body="Hjarrandi Breast.",
        hands=gear.NyameHands,
        legs=gear.GletiLegs,
        feet=gear.GletiFeet,
        neck=gear.DynamisNeck,
        waist="Null Belt",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear=gear.EmpyreanEarring,
        left_ring="Gurebu's Ring",
        right_ring="Defending Ring",
        back=gear.AmbuscadeCapeDT,
    }

    --  ----------------------------------------------------------------------------------------------------
    --   Engaged Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.engaged = {}

    sets.engaged["Normal"] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head="Hjarrandi Helm",
        body=gear.GletiBody,
        hands=gear.EmpyreanHands,
        legs=gear.GletiLegs,
        feet="Flam. Gambieras +2",
        neck="Vim Torque +1",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Sroda Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Dreki Ring",
        back=gear.AmbuscadeCapeTP,
    }

    sets.engaged['GlassCannon'] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head="Flam. Zucchetto +2",
        body=gear.EmpyreanBody,
        body=gear.GletiBody,
        legs=gear.RelicLegs,
        feet="Flam. Gambieras +2",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Sroda Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Dreki Ring",
        back=gear.AmbuscadeCapeTP,
    }

    sets.engaged['HighDT'] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head=gear.NyameHead,
        body=gear.NyameBody,
        hands=gear.EmpyreanHands,
        legs=gear.NyameLegs,
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Sroda Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Dreki Ring",
        back=gear.AmbuscadeCapeTP,
    }

    sets.engaged['Fencer'] = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head="Flam. Zucchetto +2",
        body=gear.GletiBody,
        hands=gear.EmpyreanHands,
        legs=gear.GletiLegs,
        feet="Flam. Gambieras +2",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Sroda Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Dreki Ring",
        back=gear.AmbuscadeCapeTP,
    }

    sets.TelosEarring = {
        right_ear = 'Telos Earring',
    }

    --  ----------------------------------------------------------------------------------------------------
    --   Precast Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.precast = {}

    --  ----------------------------------------------------------------------------------------------------
    --   Precast Sets: Weapon Skill (WS)
    --  ----------------------------------------------------------------------------------------------------
    sets.precast.WS = {}
    sets.precast.WS['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.NyameBody,
        hands=gear.EmpyreanHands,
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring", --  Sroda Ring
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg, --  Double Attack instead of WS Damage
    }
    sets.precast.WS['HighBuff'] = set_combine(sets.precast.WS['Normal'], {
        head = gear.EmpyreanHead,
        body = gear.EmpyreanBody,
        hands = gear.GletiHands,
        legs = gear.GletiLegs,
        feet = gear.GletiFeet,
        -- left_Ring = "Sroda Ring",
    })

    sets.precast.WS['Drakesbane'] = {}
    sets.precast.WS['Drakesbane']['Normal'] = {
        ammo="Knobkierrie",
        -- head="Blistering Sallet +1",
        head=gear.GletiHead,
        body="Hjarrandi Breast.",
        body=gear.GletiBody,
        legs=gear.EmpyreanLegs,
        feet=gear.GletiFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg, --  Crit %
    }
    sets.precast.WS['Drakesbane']['HighBuff'] = set_combine(sets.precast.WS['Drakesbane']['Normal'], {
        head = gear.GletiHead,
        body = gear.GletiBody,
        hands = gear.GletiHands,
        legs = gear.GletiLegs,
        feet = gear.GletiFeet,
        -- left_Ring = "Sroda Ring",
    })

    sets.precast.WS['Camlann\'s Torment'] = {}
    sets.precast.WS['Camlann\'s Torment']['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.NyameBody,
        hands=gear.RelicHands,   --  Nyame
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg,
    }
    sets.precast.WS['Camlann\'s Torment']['HighBuff'] = set_combine(sets.precast.WS['Camlann\'s Torment']['Normal'], {
        body = gear.GletiBody,
        legs = gear.GletiLegs,
        -- left_Ring = "Sroda Ring",
    })

    sets.precast.WS['Stardiver'] = {}
    sets.precast.WS['Stardiver']['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.NyameBody,
        hands=gear.EmpyreanHands,
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck="Shadow Gorget",   --  Fotia Gorget
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring", --  Sroda Ring
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg, --  Double Attack instead of WS Damage
    }
    sets.precast.WS['Stardiver']['HighBuff'] = set_combine(sets.precast.WS['Stardiver']['Normal'], {
        body = gear.GletiBody,
        hands = gear.GletiHands,
        legs = gear.GletiLegs,
        feet = gear.GletiFeet,
    })

    sets.precast.WS['Geirskogul'] = {}
    sets.precast.WS['Geirskogul']['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.NyameBody,
        hands=gear.RelicHands,   --  Nyame
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck="Light Gorget",    --  Fotia Gorget
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear="Sherida Earring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg, -- DEX
    }
    sets.precast.WS['Geirskogul']['HighBuff'] = set_combine(sets.precast.WS['Geirskogul']['Normal'], {
        body=gear.GletiBody,
        neck=gear.DynamisNeck,
        right_ear = gear.EmpyreanEarring,
        -- left_ring = "Epaminondas's Ring",
    })

    sets.precast.WS['Diarmuid'] = {}
    sets.precast.WS['Diarmuid']['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.NyameBody,
        hands=gear.RelicHands,   --  Nyame
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        -- right_ring = "Epaminondas's Ring",
        back=gear.AmbuscadeCapeWSDmg,
    }
    sets.precast.WS['Diarmuid']['HighBuff'] = set_combine(sets.precast.WS['Diarmuid']['Normal'], {
        -- left_Ring = "Sroda Ring",
    })

    sets.precast.WS['Impulse Drive'] = {}
    sets.precast.WS['Impulse Drive']['Normal'] = set_combine(sets.precast.WS['Impulse Drive'], {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.GletiBody,
        hands=gear.RelicHands,   --  Nyame
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear=gear.EmpyreanEarring,
        -- left_Ring = "Sroda Ring",
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        back=gear.AmbuscadeCapeWSDmg,
    })
    sets.precast.WS['Impulse Drive']['HighBuff'] = set_combine(sets.precast.WS['Impulse Drive'], {
        hands = '',
        legs = '',
    })

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

    sets.precast.WS['Savage Blade'] = {}
    sets.precast.WS['Savage Blade']['Normal'] = {
        ammo="Knobkierrie",
        head=gear.EmpyreanHead,
        body=gear.EmpyreanBody,
        hands=gear.RelicHands,   --  Nyame
        legs=gear.ArtefactLegs, --  Nyame
        feet=gear.NyameFeet,
        neck=gear.DynamisNeck,
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Thrud Earring",
        right_ear=gear.EmpyreanEarring,
        left_ring="Regal Ring",
        right_ring="Niqmaddu Ring",
        -- right_ring = "Epaminondas's Ring",
        back=gear.AmbuscadeCapeWSDmg,
    }
    sets.precast.WS['Savage Blade']['HighBuff'] = set_combine(sets.precast.WS['Savage Blade']['Normal'], {
        body        = gear.EmpyreanBody,
        -- left_Ring = "Sroda Ring",
    })

    --  ----------------------------------------------------------------------------------------------------
    --   Precast Sets: Job Ability (JA)
    --  ----------------------------------------------------------------------------------------------------
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
        body        = gear.GletiBody,
        hands       = gear.ArtefactHands,
        legs        = gear.GletiLegs,
        feet        = gear.GletiFeet,
        neck        = "Lancer's Torque",
        waist       = "Glassblower's Belt",
        left_ear    = "Infused Earring",
        right_ear   = "Dragoon's Earring",
        left_ring   = "Defending Ring",
        right_ring  = "Dreki Ring",
        back        = gear.AmbuscadeCapeWSDmg,
    }
end
