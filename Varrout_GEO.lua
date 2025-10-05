include('Mote-Globals.lua')
include('Lib_GEO.lua')

characterPocketMode = false

function init_gear_sets()
    gear = {}
    --  ----------------------------------------------------------------------------------------------------
    --   Job Specific Armour
    --  ----------------------------------------------------------------------------------------------------
    gear.ArtefactHead  = "Geomancy Galero +2"
    gear.ArtefactBody  = "Geomancy Tunic +3"
    gear.ArtefactHands = "Geomancy Mitaines +4"
    gear.ArtefactLegs  = "Geomancy Pants +3"
    gear.ArtefactFeet  = "Geomancy Sandals +3"

    gear.RelicHead  = "Bagua Galero +4"
    gear.RelicBody  = "Bagua Tunic +3"
    gear.RelicHands = "Bagua Mitaines +3"
    gear.RelicLegs  = "Bagua Pants +3"
    gear.RelicFeet  = "Bagua Sandals +3"

    gear.EmpyreanHead  = "Azimuth Hood +3"
    gear.EmpyreanBody  = "Azimuth Coat +3"
    gear.EmpyreanHands = "Azimuth Gloves +3"
    gear.EmpyreanLegs  = "Azimuth Tights +3"
    gear.EmpyreanFeet  = "Azimuth Gaiters +3"

    gear.EmpyreanEarring = "Azimuth Earring +1"
    gear.DynamisNeck     = "Bagua Charm +2"

    gear.Idris = { name="Idris", augments={'Path: A',}}
    gear.Dunna = { name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}}

    gear.AmbuscadeCapeIdle = { name = "Nantosuelta's Cape", augments = {'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Occ. inc. resist. to stat. ailments+10',}}

    gear.MoonshadeEarring = { name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}}

    gear.default = {}
    gear.default.obi_waist = "Hachirin-no-Obi"
    gear.default.fastcast_staff = "Mpaca's Staff"

    gear.ElementalObi = {}
    gear.ElementalCape = {}
    gear.ElementalRing = {}
    gear.FastcastStaff = {}
    gear.RecastStaff = {}
    gear.ElementalGorget = {}
    gear.ElementalBelt = {}

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.EntrustDuration = {
        main = 'Solstice',
        sub = 'Genmei Shield',
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Bolster']          = { body = gear.RelicBody }
    sets.precast.JA["Concentric Pulse"] = { head = gear.RelicHead }
    sets.precast.JA['Full Circle']      = { head = gear.EmpyreanHead }
    sets.precast.JA['Life Cycle']       = { body = gear.ArtefactBody,
                                            back = gear.AmbuscadeCapeIdle }
    sets.precast.JA["Mending Halation"] = { legs = gear.RelicLegs }
    sets.precast.JA["Radial Arcana"]    = { feet = gear.RelicFeet }

    -- Fast cast sets for spells
    sets.precast.FC = {
    --  /RDM --15
        main="Oranyan", -- 7%
        sub="Clerisy Strap",-- 2%
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}}, -- 3%
        head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}}, -- 11%
        body="Zendik Robe", -- 13%
        legs="Geomancy Pants +3", -- 13%
        feet={ name="Merlinic Crackows", augments={'Mag. crit. hit dmg. +8%','Attack+7','Magic burst dmg.+15%','Accuracy+7 Attack+7','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}, -- 5%
        neck="Baetyl Pendant", --4%
        waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}}, --1-5%
        left_ear="Malignance Earring", --4%
        right_ear="Loquac. Earring", --2%
        left_ring="Kishar Ring", --4%

        -- hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+29','"Fast Cast"+6','MND+5',}},  --6
        -- ring1="Weatherspoon Ring", --5
    }

    sets.precast.FC["Dark Magic"] = sets.precast.FC

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        back="Perimede Cape",
        waist="Siegel Sash",
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        hands="Bagua Mitaines +3",
        neck="Stoicheion Medal",
        ear1="Barkarole Earring",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        ring1="Weatherspoon Ring",            --"Lebeche Ring", --(2)
        back="Pahtli Cape", --(4)
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})



    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC -- Haste

--    sets.midcast.Geomancy = {
--         main="Idris",
--         sub="Genmei Shield",
--         ranged="Dunna",
--         head="Azimuth Hood +3",
--         body="Amalric Doublet +1",
--         hands="Geomancy Mitaines +4",
--         legs="Vanya Slops",
--         feet="Bagua Sandals +3",
--         ear1="Calamitous Earring",
--         ear2="Azimuth Earring +1",
--         neck="Reti Pendant",
--         ring1="Murky Ring",
--         ring2="Mephitas's Ring +1",
--         back="Fi Follet Cape +1",
--         waist="Shinjutsu-no-Obi +1",
--     }

--     sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
--         legs="Bagua Pants +3",
--         feet="Azimuth Gaiters +3",
--         back="Lifestream Cape",
--     })
    sets.midcast["Geomancy"] = {
        main        = gear.Idris,
        sub         = "Genmei Shield",
        range       = gear.Dunna,
        head        = gear.EmpyreanHead,
        body        = gear.RelicBody,
        hands       = gear.ArtefactHands,
        legs        = gear.RelicLegs,
        feet        = gear.EmpyreanFeet,
        neck        = "Incanter's Torque",
        waist       = "Kobo Obi",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Stikini Ring +1",
        right_ring  = "Stikini Ring",
        back        = gear.AmbuscadeCapeIdle,
    }

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Sors Shield", --3/(-5)
        head="Vanya Hood", --10
        body="Vanya Robe", --7/(-6)
        hands="Vanya Cuffs",
        legs="Vanya Slops",
        feet="Vanya Clogs", --5
        neck="Incanter's Torque",
        ear1="Mendicant's Earring",
        ear2="Meili Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back="Tempered Cape +1", -- GEO Cure Cape
        waist="Shinjutsu-no-Obi +1",  --"Bishop's Sash"
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Nuna Gorget +1",
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck="Debilis Medallion",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        back="Oretan. Cape +1",
        ear1="Beatific Earring",
        })

    sets.midcast['Enhancing Magic'] = {
        main="Gada",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Befouled Crown",
        body="Telchine Chas.",
        hands="Regal Cuffs",
        legs="Shedir Seraweels",
        feet="Regal Pumps +1",
        neck="Incanter's Torque",
        ear1="Andoaa Earring",
        ear2="Mimir Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
        }

    sets.midcast.EnhancingDuration = {
        main="Gada",
        sub="Ammurapi Shield",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        feet="Inspired Boots",
        waist="Gishdubar Sash",
        })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
        legs="Shedir Seraweels",
        ear1="Earthcry Earring",
        })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head="Amalric Coif +1",
        ear2="Magnetic Earring",
        legs="Shedir Seraweels",
        })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MagicAccuracy = {
    }

    sets.midcast.MndEnfeebles = {
        main=gear.Idris,
        sub="Ammurapi Shield",
        ammo="Mana Ampulla",
        head="Geo. Galero +3",
        body="Geomancy Tunic +3",
        hands="Azimuth Gloves +3",
        legs="Geomancy Pants +3",
        feet="Geo. Sandals +3",
        neck="Bagua Charm +2",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1="Kishar Ring",
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back="Aurist's Cape +1",
        waist="Casso Sash",      --"Rumination Sash" or "Luminary Sash"
        } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Pemphredo Tathlum",
        waist="Acuity Belt +1",
        }) -- INT/Magic accuracy

    sets.midcast.LockedEnfeebles = {body="Geomancy Tunic +3"}

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast["Dark Magic"] = {
        main=gear.Idris,
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head=gear.EmpyreanHead,
        body=gear.EmpyreanBody,
        hands=gear.ArtefactHands,
        legs=gear.EmpyreanLegs,
        feet=gear.EmpyreanFeet,
        neck="Erra Pendant",
        waist="Null Belt",
        left_ear="Malignance Earring",
        right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
        left_ring="Evanescence Ring",
        right_ring="Stikini Ring +1",
        back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
    }

    sets.midcast["Drain"] = set_combine(sets.midcast["Dark Magic"], {
        main="Rubicundity", --20
        sub="Ammurapi Shield",
        head="Bagua Galero +4", --35
        feet="Agwu's Pigaches", --20
        ring1="Evanescence Ring", --10
        ring2="Archon Ring",
        neck="Erra Pendant", --5
        ear1="Hirudinea Earring", --5
        waist="Fucho-no-Obi", --8
        })

    sets.midcast["Aspir"] = sets.midcast["Drain"]

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Wizard's Rod",
        sub="Ammurapi Shield",
        ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
        head="Azimuth Hood +3",
        body="Azimuth Coat +3",
        hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs="Azimuth Tights +3",
        feet="Azimuth Gaiters +3",
        neck="Sibyl Scarf",
        waist="Sacro Cord",
        ear1="Malignance Earring",
        ear2="Barkaro. Earring",
        ring1="Freke Ring",
        ring2="Medada's Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        ear2="Digni. Earring",
        })

    -- sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {
    --     main="Bunzi's Rod",
    --     sub="Ammurapi Shield",
    --     })

    -- sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'].Resistant, {
    --     body="Seidr Cotehardie",
    -- })

    -- sets.midcast.GeoElem.Seidr = set_combine(sets.midcast['Elemental Magic'].Seidr, {})

    -- sets.midcast.Impact = set_combine(sets.midcast.IntEnfeebles, {
    --     head=empty,
    --     body="Twilight Cloak",
    --     hands="Geo. Mitaines +3",
    --     --ring2="Archon Ring",
    -- })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {}

    sets.idle["Normal"] =  {
        -- main="Malignance Pole",
        -- sub="Khonsu",
        -- head="Azimuth Hood +3",
        -- legs="Azimuth Tights +3",
        -- feet="Azimuth Gaiters +3",

        -- main={ name="Mpaca's Staff", augments={'Path: A',}},
        -- sub="Enki Strap",
        range=gear.Dunna,
        head="Befouled Crown",
        body=gear.EmpyreanBody,
        hands=gear.RelicHands,
        legs="Assid. Pants +1",
        feet=gear.ArtefactFeet,
        neck="Elite Royal Collar",
        waist="Null Belt",
        left_ear=gear.MoonshadeEarring,
        right_ear="Etiolation Earring",
        left_ring="Gurebu's Ring",
        right_ring="Stikini Ring +1",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Occ. inc. resist. to stat. ailments+10',}},
    }

    sets.idle["Hybrid"] = set_combine(sets.idle["Normal"], {

    })

    sets.idle["MagicEva"] = set_combine(sets.idle["Normal"], {
        -- neck="Loricate Torque +1", --6/6
        -- ear2="Odnowa Earring +1", --3/3
        -- back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
        -- waist="Plat. Mog. Belt", --3/3

        -- main={ name="Mpaca's Staff", augments={'Path: A',}},
        -- sub="Enki Strap",
        ammo="Staunch Tathlum +1",
        head=gear.EmpyreanHead,
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands=gear.EmpyreanHands,
        legs=gear.EmpyreanLegs,
        feet=gear.EmpyreanFeet,
        neck="Warder's Charm +1",
        waist="Null Belt",
        left_ear="Lugalbanda Earring",
        right_ear="Etiolation Earring",
        left_ring="Gurebu's Ring",
        right_ring="Murky Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Occ. inc. resist. to stat. ailments+10',}},
    })

    -- .Pet sets are for when Luopan is present.
    sets.idle["Normal"].Pet = set_combine(sets.idle["Normal"], {
        -- Pet: -DT (37.5% to cap) / Pet: Regen
        main=gear.Idris,
        sub="Genmei Shield",
        head=gear.EmpyreanHead,
        body=gear.ArtefactBody,
        hands=gear.ArtefactHands, --3/0/13/0
        legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
        feet=gear.RelicFeet, --0/0/0/5
        neck=gear.DynamisNeck,
        ear1="Ethereal Earring",
        ear2={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        ring1={name="Stikini Ring +1"},
        ring2="Murky Ring", --10/10/0/0
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
        waist="Isa Belt" --0/0/3/1
    })

    sets.idle["MagicEva"].Pet = set_combine(sets.idle["Normal"].Pet, {
        hands=gear.EmpyreanHands, --12/12
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}, --5/5
        waist="Plat. Mog. Belt" --3/3
    })

    sets.PetHP = {
        head = gear.RelicHead,
    }

    sets.resting = {
        -- main="Malignance Pole",
        -- sub="Khonsu",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Merlinic Hood", augments={'Enmity-3','Mag. Acc.+3','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        body="Azimuth Coat +3",
        hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
        legs="Assid. Pants +1",
        feet="Azimuth Gaiters +3",
        neck="Elite Royal Collar",
        waist="Fucho-no-Obi",
        ear1="Infused Earring",
        ear2={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
    }

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    --sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    --sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})

    sets.idle.Town = set_combine(sets.idle, {
        -- main="Malignance Pole",
        -- sub="Khonsu",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head={ name="Merlinic Hood", augments={'Enmity-3','Mag. Acc.+3','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
        body="Azimuth Coat +3",
        hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
        legs="Assid. Pants +1",
        feet="Azimuth Gaiters +3",
        neck="Elite Royal Collar",
        waist="Null Belt",
        left_ear="Infused Earring",
        right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        ring1={name="Stikini Ring +1", bag="wardrobe1"},
        ring2={name="Stikini Ring +1", bag="wardrobe2"},
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
    })

    sets.Kiting = {feet=gear.ArtefactFeet}
    sets.movement = sets.Kiting

    sets.latentRefresh50 = {
        waist       = "Fucho-no-Obi",           --  Latent: Refresh +1 when MP < 50%
    }

    sets.latentRefresh75 = {
        sub         = "Oneiros Grip",           --  Latent: Refresh +1 when MP <= 75%
    }

    -- sets.resting = {
    --     main        = "Boonwell Staff",         -- +18
    --     sub         = "Ariesian Grip",          -- +1
    --     ammo        = "Mana Ampulla",           -- +2
    --     head        = "Orvail Corona +1",       -- +4
    --     neck        = "Eidolon Pendant +1",     -- +6
    --     left_ear    = "Infused Earring",        -- +0, Regen +1
    --     right_ear   = gear.EmpyreanEarring,
    --     body        = "Chelona Blazer",         -- +8 (Nice to have +1)
    --     hands       = "Nares Cuffs",            -- +4
    --     left_ring   = "Star Ring",              -- +1
    --     right_ring  = "Angha Ring",             -- +2
    --     back        = "Felicitas Cape",         -- +3
    --     waist       = "Shinjutsu-no-Obi +1",    -- +5
    --     legs        = "Nisse Slacks",           -- +4
    --     feet        = "Chelona Boots"           -- +5 (Nice to have +1)
    -- }

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.main_weapons = {
        main=gear.Idris,
        sub="Genmei Shield",
    }

    -- Normal melee group
    sets.engaged = {
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        ear1="Cessance Earring",
        ear2="Brutal Earring",
        ring1="Petrov Ring",
        ring2="Hetairoi Ring",
        waist="Cetl Belt",
    }

    sets.engaged["Pet"] = sets.engaged


    --------------------------------------
    -- Weaponskill sets
    --------------------------------------
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Null Loop",
        waist="Fotia Belt",
        left_ear="Telos Earring",
        right_ear="Digni. Earring",
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back="Null Shawl",
    }

    sets.precast.WS['Hexastrike'] = set_combine(sets.precast.WS, {
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Exudation'] = sets.precast.WS['Hexastrike']

    sets.precast.WS['Flash Nova'] = {
        head="Azimuth Hood +3",
        body="Azimuth Coat +3",
        hands="Jhakri Cuffs +2",
        legs="Azimuth Tights +3",
        feet="Azimuth Gaiters +3",
        neck="Saevus Pendant +1",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        waist="Refoccilation Stone",
    }


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {
        main="Bunzi's Rod", --10
        sub="Ammurapi Shield",
        head="Ea Hat +1", --7/(7)
        body="Azimuth Coat +3", --(5)
        hands="Amalric Gages +1", --0/(6)
        legs="Azimuth Tights +3", --15
        neck="Mizu. Kubikazari", --10
        ring2="Mujin Band", --(5)
        }

    sets.buff.Doom = {ring1={name="Saida Ring", bag="wardrobe3"}, ring2={name="Saida Ring", bag="wardrobe4"},}
    sets.Obi = {waist="Hachirin-no-Obi"}
end