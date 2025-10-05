include('Mote-Globals.lua')
include('Lib_COR.lua')

-- Define sets and vars used by this job file.
function init_gear_sets()
    --  ----------------------------------------------------------------------------------------------------
    --   Job Specific Armour
    --  ----------------------------------------------------------------------------------------------------
    gear.ArtefactHead  = "Laksa. Tricorne +4"
    gear.ArtefactBody  = "Laksa. Frac +4"
    gear.ArtefactHands = "Lak. Gants +4"
    gear.ArtefactLegs  = "Laksa. Trews +4"
    gear.ArtefactFeet  = "Laksa. Bottes +4"

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
    gear.WeaponTPBonus     = { name = "Ataktos",     augments = {'Delay:+60','TP Bonus +1000',}}
    gear.WeaponPhantom     = { name = "Compensator", augments = {'DMG:+15','Rng.Atk.+15','"Mag.Atk.Bns."+15',}}    -- Phantom Roll Duration +20

    gear.DaggerPhantomRoll = { name = "Rostam",      augments = {'Path: C',}}   --  Phantom Roll Duration +60, Phantom Roll +8
    gear.DaggerTPBonus     = { name = "Lanun Knife", augments = {'Path: A',}}   --  Dobule damage chance +40%, Store TP +20
    gear.DaggerRangedBonus = { name = "Kustawi +1",  augments = {'Path: A',}}
    gear.DaggerBlurred     = 'Blurred Knife +1'
    gear.Naegling          = 'Naegling'
    gear.NuskuShield       = 'Nusku Shield'

    --  Special Ammo
    gear.BulletRA       = "Chrono Bullet"
    gear.BulletWSAttack = "Chrono Bullet"
    gear.BulletWSMagic  = "Devastating Bullet"
    gear.BulletQDAcc    = "Devastating Bullet"
    gear.BulletQDHyb    = "Animikii Bullet"
    gear.BulletQDAtt    = "Hauksbok Bullet"
    gear.DoNotShoot     = S{"Animikii Bullet", "Hauksbok Bullet"}

    --  Ambuscade Back Pieces
    -- gear.AmbuscadeMeleeAccNIN   = { name = "Camulus's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}} --  Needs with Double Attack
    gear.AmbuscadeMeleeAccDNC   = { name = "Camulus's Mantle", augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}

    gear.AmbuscadeRangedAcc     = { name = "Camulus's Mantle", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
    gear.AmbuscadeRangedCrit    = gear.AmbuscadeRangedAcc
    gear.AmbuscadeSharpShot     = { name = "Camulus's Mantle", augments = {'"Snapshot"+10',}}

    gear.AmbuscadeMeleeWSStr    = { name = "Camulus's Mantle", augments = {'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.AmbuscadeMeleeWSMnd    = gear.AmbuscadeMeleeWSStr      --  New cape needed
    gear.AmbuscadeMeleeWSDex    = gear.AmbuscadeMeleeWSStr      --  New cape needed
    gear.AmbuscadeMeleeWSInt    = gear.AmbuscadeMeleeWSStr      --  New cape needed

    gear.AmbuscadeRangedWSPhys  = { name = "Camulus's Mantle", augments = {'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    gear.AmbuscadeRangedWSMagic = { name = "Camulus's Mantle", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}

    gear.AmbuscadeQuickDraw     = { name = "Camulus's Mantle", augments = {'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Occ. inc. resist. to stat. ailments+10',}}

    gear.AmbuscadeDT            = { name = "Camulus's Mantle", augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}
    gear.AmbuscadeFC            = AmbuscadeDT

    --  Other Capes
    gear.GunslingerCape         = { name     = "Gunslinger's Cape", augments = {'Enmity-3','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5','Weapon skill damage +1%',}}

    gear.MoonshadeEarring       = { name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}}

    --  Carmine Set
    gear.CarmineHands           = { name     = "Carmine Fin. Ga. +1",
                                    augments = {'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.CarmineLegs            = { name     = "Carmine Cuisses +1",
                                    augments = {'Accuracy+20','Attack+12','"Dual Wield"+6',}}

    --  Herculean Head
    gear.HerculeanHead          = { name     = "Herculean Helm",
                                    augments = {'Attack+12','Weapon skill damage +5%',}}

    --  Herculean Legs
    gear.HerculeanLegs = {}
    gear.HerculeanLegs.WsMAB    = { name     = "Herculean Trousers",
                                    augments = {'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}}
    gear.HerculeanLegs.WsPhys   = { name     = "Herculean Trousers",
                                    augments = {'Accuracy+27','Weapon skill damage +5%','AGI+8',}}

    --  Herculean Feet
    gear.HerculeanFeet = {}
    gear.HerculeanFeet.AccTA = { name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}}

    --  Adhemar Set
    gear.Adhemar = {}
    --  Head
    gear.Adhemar.HeadA = { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}

    --  Body
    gear.Adhemar.BodyA = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}

    --  Hands
    gear.Adhemar.HandsA = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar.HandsB = '

    --  Legs
    gear.Adhemar.LegsC = { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
    -- gear.Adhemar.LegsD =

    --  Feet
    -- gear.Adhemar.FeetB =

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
    sets.movement = {
        legs        = gear.CarmineLegs,
    }

    sets.town = set_combine(sets.movement ,{
        head        = gear.ArtefactHead,
        body        = gear.ArtefactBody,
        hands       = gear.ArtefactHands,
        feet        = gear.ArtefactFeet,
        neck        = "Elite Royal Collar",
        waist       = "Null Belt",
        left_ear    = "Infused Earring",
        right_ear   = { name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring   = { name="Murky Ring", augments={'Path: A',}},
        right_ring  = "Sheltered Ring",
        back        = "Null Shawl",
    })

    --  ----------------------------------------------------------------------------------------------------
    --   Idle Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.idle = {}
    sets.idle['Normal'] = {
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

    -- -26% Physical DT, -23% DT, + 352 Magic Evasion
    sets.idle['Regen'] = {
        head        = "Meghanada Visor +2",
        body        = "Meg. Cuirie +2",
        hands       = "Meg. Gloves +2",
        legs        = "Meg. Chausses +2",
        feet        = "Meg. Jam. +2",
        neck        = "Elite Royal Collar",
        waist       = "Null Belt",
        left_ear    = "Infused Earring",
        right_ear   = { name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring   = { name="Murky Ring", augments={'Path: A',}},
        right_ring  = "Sheltered Ring",
        back        = gear.AmbuscadeDT,
    }

    sets.idle['Refresh']  = {
        head        = "Rawhide Mask",
        legs        = { name     = "Rawhide Trousers",
                        augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    }

    sets.idle['MagicEvasion'] = {
        head        = gear.EmpyreanHead,
        body        = gear.EmpyreanBody,
        hands       = gear.RelicHands,
        legs        = gear.EmpyreanLegs,
        feet        = gear.RelicFeet,
        neck        = "Warder's Charm",     --   Warder's Charm +1
        waist       = "Null Belt",
        left_ear    = "Hearty Earring",
        right_ear   = { name = "Odnowa Earring +1", augments = {'Path: A',}},
        left_ring   = { name = "Murky Ring", augments = {'Path: A',}},
        right_ring  = "Sheltered Ring",     --  Shadow Ring
        back        = gear.AmbuscadeDT,
    }

    --  ----------------------------------------------------------------------------------------------------
    --   Weapon Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.melee = {}
    sets['Naegling'] = {
        main        = gear.Naegling,
        sub         = gear.NuskuShield
    }

    sets['Phantom'] = {
        main        = gear.DaggerPhantomRoll
    }


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
        back        = gear.AmbuscadeMeleeAccNIN,
    }
    sets.engaged['Hybrid'] = set_combine(sets.engaged, {
        neck        = { name = "Loricate Torque +1", augments = {'Path: A',}},
        left_ring   = { name = "Murky Ring", augments = {'Path: A',}},
    })
    -- sets.engaged.LowAcc = set_combine(sets.engaged, {})
    -- sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})
    -- sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})

    -- -- 15% Magic Haste (66% DW to cap), 55-65% (40% Gear)
    sets.engaged['LowHaste'] = set_combine(sets.engaged, {

    })
    sets.engaged['LowHaste']['Hybrid'] = set_combine(sets.engaged['LowHaste'], {
        head        = "Malignance Chapeau",
        neck        = { name = "Loricate Torque +1", augments = {'Path: A',}},
        left_ring   = { name = "Murky Ring", augments = {'Path: A',}},
    })
    -- sets.engaged.LowHaste.LowAcc = set_combine(sets.engaged.LowHaste, {})
    -- sets.engaged.LowHaste.MidAcc = set_combine(sets.engaged.LowHaste.LowAcc, {})
    -- sets.engaged.LowHaste.HighAcc = set_combine(sets.engaged.LowHaste.MidAcc, {})
    -- sets.engaged.LowHaste.Fodder = set_combine(sets.engaged.LowHaste, {})

    -- -- 30% Magic Haste (55% DW to cap), 49-59% (34% Gear)
    sets.engaged['MidHaste'] = set_combine(sets.engaged, {
        head        = gear.Adhemar.HeadA,
        body        = gear.Adhemar.BodyA,
        hands       = gear.Adhemar.HandsA,
        -- legs        = "Samnuha Tights",
        -- feet        = "Taeon Boots",
        neck        = "Iskur Gorget",
        -- waist       = "Reiki Yotai",
        -- left_ear    = "Eabani Earring",
        -- right_ear   = "Suppanomimi"
        left_ring   = "Petrov Ring",
        right_ring  = "Epona's Ring",
        back        = gear.AmbuscadeMeleeAccDNC,
    })
    sets.engaged['MidHaste']['Hybrid'] = set_combine(sets.engaged['MidHaste'], {
        head        = "Malignance Chapeau",
        hands       = "Malignance Gloves",
        legs        = gear.EmpyreanLegs,
        neck        = { name = "Loricate Torque +1", augments = {'Path: A',}},
        left_ear    = { name = "Odnowa Earring +1", augments = {'Path: A',}},
        left_ring   = { name = "Murky Ring", augments = {'Path: A',}},
    })
    -- sets.engaged.MidHaste.LowAcc = set_combine(sets.engaged.MidHaste, {})
    -- sets.engaged.MidHaste.MidAcc = set_combine(sets.engaged.MidHaste.LowAcc, {})
    -- sets.engaged.MidHaste.HighAcc = set_combine(sets.engaged.MidHaste.MidAcc, {})
    -- sets.engaged.MidHaste.Fodder = set_combine(sets.engaged.MidHaste, {})

    -- -- 47% Magic Haste (36% DW to cap), 24-34% (9% Gear)
    sets.engaged['MaxHaste'] = set_combine(set.engaged, {
        head        = gear.Adhemar.HeadA,
        body        = gear.Adhemar.BodyA,
        hands       = gear.Adhemar.HandsA,
        legs        = "Meg. Chausses +2",
        feet        = gear.HerculeanFeet.AccTA,
        neck        = "Iskur Gorget",
        waist       = { name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear    = "Brutal Earring",     --  Telos Earring
        right_ear   = "Cessance Earring",   --  Suppanomimi
        left_ring   = "Petrov Ring",
        right_ring  = "Epona's Ring",
        back        = gear.AmbuscadeMeleeAccDNC,
    })
    sets.engaged['MaxHaste']['Hybrid'] = set_combine(sets.engaged['MaxHaste'], {
        head        = "Malignance Chapeau",
        body        = "Malignance Tabard",
        hands       = "Malignance Gloves",
        legs        = gear.EmpyreanLegs,
        feet        = "Malignance Boots",
        left_ear    = { name = "Odnowa Earring +1", augments = {'Path: A',}},
        left_ring   = { name = "Murky Ring", augments = {'Path: A',}},
    })
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

    --  Combine with the Magic Evasion/DT Set
    --  "Phantom Roll" ability delay -10, No enhanced duration
    sets.precast.CorsairRollBase = set_combine(sets.idle['MagicEva'], {
        legs        = { name     = "Desultor Tassets",
                        augments = {'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
        left_ring   = "Luzaf's Ring",
        back        = gear.GunslingerCape,
    })

    --  Adds 150 seconds to Phantom Roll duration
    sets.precast.CorsairRoll = set_combine(sets.precast.CorsairRollBase, {
        head        = gear.RelicHead,       --  Duration +50
        hands       = gear.EmpyreanHands,   --  Duration +60
        neck        = "Regal Necklace",     --  Duration +20
        back        = gear.AmbuscadeDT,     --  Duration +30
    })

    sets.precast["Allies' Roll"]     = set_combine(sets.precast.CorsairRoll, { hand = gear.EmpyreanHands})
    sets.precast["Blitzer's Roll"]   = set_combine(sets.precast.CorsairRoll, { head = gear.EmpyreanHead})
    sets.precast["Caster's Roll"]    = set_combine(sets.precast.CorsairRoll, { legs = gear.EmpyreanLegs})
    sets.precast["Courser's Roll"]   = set_combine(sets.precast.CorsairRoll, { feet = gear.EmpyreanFeet})
    sets.precast["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = gear.EmpyreanBody})
    sets.precast["Bolter's Roll"]    = sets.precast.CorsairRollBase

    --  Quickdraw
    sets.precast.CorsairShot = {}
    sets.precast.CorsairShot['Attack'] = {
        ammo        = gear.BulletQDAtt,
        head        = "Nyame Helm",             -- Ikenga
        body        = gear.RelicBody,
        hands       = gear.CarmineHands,
        legs        = gear.HerculeanLegs.WsMAB, --  Nyame: Path C
        feet        = gear.RelicFeet,
        neck        = gear.DynamisNeck,
        waist       = "Eschan Stone",           --  Skrymir Cord +1
        left_ear    = "Friomisi Earring",
        right_ear   = "Hecate's Earring",       --  Crematio Earring
        left_ring   = "Dingir Ring",
        right_ring  = "Adoulin Ring",           --  Fenrir Ring +1 (maybe a new limbus ring?)
        back        = gear.AmbuscadeQuickDraw,
    }
    sets.precast.CorsairShot['Hybrid'] = set_combine(sets.precast.CorsairShot['Normal'], {
        ammo        = gear.BulletQDHyb,
    })

    sets.precast.CorsairShot["Accuracy"] = {
        ammo        = gear.BulletQDAtt,
        head        = gear.ArtefactHead,
        body        = "Malignance Tabard",      --  Ikenga
        hands       = gear.ArtefactHands,
        legs        = "Malignance Tights",      --  Ikenga
        feet        = gear.ArtefactFeet,
        neck        = gear.DynamisNeck,
        waist       = "Kwahu Kachina Belt",     --  K. Kchina Belt +1
        left_ear    = "Dedition Earring",       -- Crespecular Earring
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Mummu Ring",             --  Regal Ring
        right_ring  = "Stikini Ring",           --  Stikini Ring +1
        back        = gear.AmbuscadeQuickDraw,
    }
    sets.precast.CorsairShot["Dark Shot"]  = sets.precast.CorsairShot["Accuracy"]
    sets.precast.CorsairShot["Light Shot"] = sets.precast.CorsairShot["Accuracy"]

    sets.precast.RA = set_combine(sets.idle['MagicEva'], {
        ammo        = gear.BulletRA,
        head        = "Chass. Tricorne +3",
        body        = "Laksa. Frac +4",         --  Oshosi Vest +1
        hands       = gear.CarmineHands,
        legs        = gear.Adhemar.LegsC,       --  Need Path D
        feet        = "Meg. Jam. +2",
        neck        = gear.DynamisNeck,
        waist       = "Ponente Sash",           --  Impulse Belt
        -- left_ring   = "Crepuscular Ring",
        back        = gear.AmbuscadeSharpShot,
    })

    sets.precast.FC = set_combine(sets.idle['MagicEva'], {
        -- head        = "Carmine Mask +1",
        -- body        = "Taeon Tabard",
        -- hands       = "Leyline Gloves",
        legs        = { name     = "Rawhide Trousers",
                        augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        -- feet        = "Carmine Greaves +1",
        -- neck        = "Orunmila's Torque",
        -- left_ear    = "Enchntr. Earring +1",
        right_ear   = "Loquac. Earring",
        left_ring   = "Kishar Ring",
        -- right_ring  = "Rahab Ring",
        back        = gear.AmbuscadeFC,
    })

    -- sets.precast.Waltz = {
    --     head        = "Mummu Bonnet +2",
    --     body        = gear.ArtefactBody,
    --     hands       = gear.ArtefactHands,
    --     legs        = { name     = "Desultor Tassets",
    --                     augments = {'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
    --     feet        = { name     = "Rawhide Boots",
    --                     augments = {'STR+8','Attack+11','"Store TP"+4',}},
    --     neck        = "Elite Royal Collar",
    --     waist       = "Chaac Belt",
    --     left_ear    = { name     = "Odnowa Earring +1",
    --                     augments = {'Path: A',}},
    --     right_ear   = "Tuisto Earring",
    --     left_ring   = "Murky Ring",
    --     right_ring  = "Petrov Ring",
    --     back        = gear.AmbuscadeFC,
    -- }
    -- sets.precast['Curing Waltz'] = sets.precast.Waltz
    -- sets.precast['Divine Waltz'] = sets.precast.Waltz

    --  ----------------------------------------------------------------------------------------------------
    --   Precast Sets - Weapon Skills
    --  ----------------------------------------------------------------------------------------------------
    --  Elemental WS Acc Set
    sets.ElementalWSAcc = {
        head        = "Nyame Helm",
        neck        = gear.DynamisNeck,
        waist       = "Eschan Stone",
        -- left_ear    = "Hermetic Earring",
        right_ear   = gear.EmpyreanEarring,
    }

    sets.precast.WS = {
        head        = gear.HerculeanHead,
        body        = gear.ArtefactBody,
        hands       = gear.EmpyreanHands,
        legs        = gear.HerculeanLegs.WsPhys,
        feet        = gear.RelicFeet,
        neck        = gear.DynamisNeck,
        waist       = "Sailfi Belt +1",
        left_ear    = "Ishvara Earring",
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Ilabrat Ring",
        right_ring  = "Ephramad's Ring",
    }
    sets.precast.WS['Normal'] = sets.precast.WS
    sets.precast.WS['Accuracy'] = set_combine(sets.precast.WS['Normal'], {})

    sets.precast.WS.Melee = set_combine(sets.precast.WS, { back = gear.AmbuscadeMeleeWSStr, })

    --  Melee: Dagger
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head        = gear.Adhemar.HandsB,          --  Needs path B
        body        = "Meg. Cuirie +2",
        hands       = gear.Adhemar.HandsA,          --  Needs path B
        legs        = "Meg. Chausses +2",           --  Zoar Subligar +1
        feet        = "Mummu Gamash. +2",           --  Adhemar Gamashes +1
        neck        = "Fotia Gorget",
        waist       = "Soil Belt",                  --  Fotia Belt
        left_ear    = "Odr Earring",
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Ephramad's Ring",
        right_ring  = "Ilabrat Ring",
        back        = gear.AmbuscadeMeleeWSDex,
    })
    sets.precast.WS['Evisceration']['Normal'] = sets.precast.WS['Evisceration']
    sets.precast.WS['Evisceration']['Accuracy'] = set_combine(sets.precast.WS['Evisceration']['Normal'], {})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head        = "Nyame Helm",
        body        = gear.RelicBody,
        hands       = "Nyame Gauntlets",
        legs        = gear.HerculeanLegs.WsMAB,     --  Nyame
        feet        = gear.EmpyreanFeet,
        neck        = "Sanctity Necklace",          --  Baetyl Pendant
        waist       = "Eschan Stone",               --  Orpheus's Sash
        left_ear    = "Friomisi Earring",
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Adoulin Ring",               --  WSD Ring
        right_ring  = "Dingir Ring",
        back        = gear.AmbuscadeMeleeWSInt,
    })
    sets.precast.WS['Aeolian Edge']['Normal'] = sets.precast.WS['Aeolian Edge']
    sets.precast.WS['Aeolian Edge']['Accuracy'] = set_combine(sets.precast.WS['Aeolian Edge']['Normal'], sets.ElementalWSAcc)

    --  Melee: Sword
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head        = gear.HerculeanHead,           --  Nyame
        body        = gear.ArtefactBody,            --  Nyame
        hands       = gear.EmpyreanHands,
        legs        = gear.HerculeanLegs.WsPhys,    --  Nyame
        feet        = gear.RelicFeet,               --  Nyame
        neck        = "Fotia Gorget",               --  Caro Necklace
        waist       = { name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear    = gear.MoonshadeEarring,
        right_ear   = "Ishvara Earring",
        left_ring   = "Ephramad's Ring",
        right_ring  = "Rufescent Ring",             --  Regal Ring
        back        = gear.AmbuscadeMeleeWSStr,     --  Needs: STR/Att/Acc/WDS
    })
    sets.precast.WS['Savage Blade']['Normal'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Savage Blade']['Accuracy'] = set_combine(sets.precast.WS['Savage Blade']['Normal'], {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        head        = gear.HerculeanHead,           --  Nyame
        body        = gear.ArtefactBody,            --  Nyame
        hands       = gear.EmpyreanHands,           --  Nyame
        legs        = gear.HerculeanLegs.WsPhys,    --  Nyame
        feet        = gear.RelicFeet,               --  Nyame
        neck        = "Fotia Gorget",
        waist       = "Soil Belt",                  --  Fotia Belt
        left_ear    = "Cessance Earring",           --  Telos Earring
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Ephramad's Ring",
        right_ring  = "Rufescent Ring",
        back        = gear.AmbuscadeMeleeWSMnd,
    })
    sets.precast.WS['Requiescat']['Normal'] = sets.precast.WS['Requiescat']
    sets.precast.WS['Requiescat']['Accuracy'] = set_combine(sets.precast.WS['Requiescat']['Normal'], {
        -- body        = "Ikenga's Vest",
        -- feet        = "Ikenga's Clogs",
    })

    --  Ranged: Marksmanship
    sets.precast.WS.Ranged = set_combine(sets.precast.WS, { back = gear.AmbuscadeRangedWSPhys, })

    --  Elemental info: Light/Fire Belt, Light/Flame Gorget
    sets.precast.WS['Last Stand'] = {
        ammo        = gear.BulletWSAttack,
        head        = gear.RelicHead,
        body        = gear.ArtefactBody,            --  Ikenga
        hands       = gear.EmpyreanHands,
        legs        = gear.HerculeanLegs.WsMAB,
        feet        = gear.RelicFeet,
        neck        = "Fotia Gorget",
        waist       = "Light Belt",                 --  Fotia Belt
        left_ear    = "Ishvara Earring",
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Ephramad's Ring",
        right_ring  = "Dingir Ring",
        back        = gear.AmbuscadeRangedWSPhys,
    }
    sets.precast.WS['Last Stand']['Normal'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Last Stand']['Accuracy'] = set_combine(sets.precast.WS['Last Stand']['Normal'], {
        -- head={ name="Ikenga's Hat", augments={'Path: A',}},
        -- hands="Ikenga's Gloves",
        -- legs="Ikenga's Trousers",
        -- feet="Ikenga's Clogs",
    })

    --  Elemental info: Fire (Karin Obi)
    sets.precast.WS['Wildfire'] = {
        ammo        = gear.BulletWSMagic,
        head        = gear.HerculeanHead,           --  Nyame
        body        = gear.RelicBody,
        hands       = gear.EmpyreanHands,           --  Nyame
        legs        = gear.HerculeanLegs.WsMAB,
        feet        = gear.RelicFeet,
        neck        = gear.DynamisNeck,
        waist       = "Eschan Stone",               --  Skrymir Cord +1
        left_ear    = "Friomisi Earring",
        right_ear   = "Hecate's Earring",
        left_ring   = "Ephramad's Ring",
        right_ring  = "Dingir Ring",
        back        = gear.AmbuscadeRangedWSMagic,
    }
    sets.precast.WS['Wildfire']['Normal'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Wildfire']['Accuracy'] = set_combine(sets.precast.WS['Wildfire']['Normal'], sets.ElementalWSAcc)

    --  Elemental info: Dark (Anrin Obi)
    sets.precast.WS['Leaden Salute'] = {
        ammo        = gear.BulletWSMagic,
        head        = "Pixie Hairpin +1",
        body        = gear.RelicBody,
        hands       = gear.EmpyreanHands,           --  Nyame
        legs        = gear.HerculeanLegs.WsMAB,     --  Nyame
        feet        = gear.RelicFeet,
        neck        = gear.DynamisNeck,
        waist       = "Svelt. Gouriz +1",
        left_ear    = "Friomisi Earring",
        right_ear   = gear.MoonshadeEarring,
        left_ring   = "Archon Ring",
        right_ring  = "Dingir Ring",
        back        = gear.AmbuscadeRangedWSMagic,
    }
    sets.precast.WS['Leaden Salute']['Normal'] = sets.precast.WS['Leaden Salute']
    sets.precast.WS['Leaden Salute']['Accuracy'] = set_combine(sets.precast.WS['Leaden Salute']['Normal'], sets.ElementalWSAcc)

    -- sets.precast.WS['Hot Shot'] = {
    --     head        = "Pixie Hairpin +1",
    --     body        = gear.RelicBody,
    --     hands       = gear.EmpyreanHands,           --  Nyame
    --     legs        = gear.HerculeanLegs.WsMAB,     --  Nyame
    --     feet        = gear.RelicFeet,
    --     neck        = gear.DynamisNeck,
    --     waist       = "Svelt. Gouriz +1",
    --     left_ear    = "Friomisi Earring",
    --     right_ear   = gear.MoonshadeEarring,
    --     left_ring   = "Archon Ring",
    --     right_ring  = "Dingir Ring",
    --     back        = gear.AmbuscadeRangedWSMagic,
    -- }
    -- sets.precast.WS['Hot Shot']['Normal'] = sets.precast.WS['Hot Shot']
    -- sets.precast.WS['Hot Shot']['Accuracy'] = set_combine(sets.precast.WS['Hot Shot']['Normal'], sets.ElementalWSAcc)


    --  ----------------------------------------------------------------------------------------------------
    --   Midcast Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.midcast = {}

    sets.midcast.RA = set_combine(sets.precast.RA, {
        head        = gear.EmpyreanHead,        --  Ikenga
        body        = gear.EmpyreanBody,        --  Ikenga
        hands       = gear.EmpyreanHands,       --  Ikenga
        legs        = gear.EmpyreanLegs,
        feet        = gear.EmpyreanFeet,        --  Ikenga
        neck        = "Iskur Gorget",
        waist       = "Kwahu Kachina Belt",     --  Ymaya Belt
        left_ear    = "Beyla Earring",          --  Telos Earring
        right_ear   = "Enervating Earring",     --  Crepuscular Earring
        left_ring   = "Ilabrat Ring",
        right_ring  = "Ephramad's Ring",        --  Crepuscular Ring
        back        = gear.AmbuscadeRangedAcc,
    })

    --  Focus on Critical Hit Rate
    sets.midcast.RA['Armageddon'] = {}
    sets.midcast.RA['Armageddon']['Aftermath'] = {
        head        = "Meghanada Visor +2",
        body        = "Meg. Cuirie +2",
        hands       = gear.EmpyreanHands,
        legs        = "Mummu Kecks +2",         --  Darraigner's Brais
        feet        = "Mummu Gamash. +2",       --  Osh. Leggings +1
        neck        = "Iskur Gorget",
        waist       = "Kwahu Kachina Belt",     --  K. Kachina Belt +1
        left_ear    = "Odr Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Dingir Ring",
        right_ring  = "Ephramad's Ring",
        back        = gear.AmbuscadeRangedCrit,
    }

    sets.midcast["Triple Shot"] = {
        -- head        = 'Oshosi Mask +1',
        body        = gear.EmpyreanBody,
        hands       = gear.RelicHands,
        -- legs        = 'Osh. Trousers +1',
        -- feet        = 'Osh. Leggings +1',
    }

    sets.midcast["True Shot"] = {
    }
end
