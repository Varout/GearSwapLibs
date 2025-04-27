include('Mote-Globals.lua')
include('Lib_SCH.lua')
include('Universal-Gear-Sets_Varrout.lua')

characterPocketMode = false

function init_gear_sets()
    --  ----------------------------------------------------------------------------------------------------
    --   Job Specific Armour
    --  ----------------------------------------------------------------------------------------------------
    gear.ArtefactHead  = "Academic's Mortarboard +3"
    gear.ArtefactBody  = "Academic's Gown +2"
    gear.ArtefactHands = "Academic's Bracers +2"
    gear.ArtefactLegs  = "Academic's Pants +3"
    gear.ArtefactFeet  = "Academic's Loafers +2"

    gear.RelicHead  = "Pedagogy Mortarboard +3"
    gear.RelicBody  = "Pedagogy Gown +3"
    gear.RelicHands = "Pedagogy Bracers +3"
    gear.RelicLegs  = "Pedagogy Pants +3"
    gear.RelicFeet  = "Pedagogy Loafers +3"

    gear.EmpyreanHead  = "Arbatel Bonnet +3"
    gear.EmpyreanBody  = "Arbatel Gown +3"
    gear.EmpyreanHands = "Arbatel Bracers +2"
    gear.EmpyreanLegs  = "Arbatel Pants +3"
    gear.EmpyreanFeet  = "Arbatel Loavers +3"

    gear.EmpyreanEarring = "Arbatel Earring +1"
    gear.DynamisNeck     = { name = "Argute Stole", augments = {'Path: A',}}

    --  REMA Weapons
    -- gear.WeaponMythic   = ""
    -- gear.WeaponEmpyrean = ""
    -- gear.WeaponAeonic   = ""
    gear.WeaponPrime    = "Opashoro"    --  Stage 2

    --  Moonshade Earring
    gear.Moonshade = { name = "Moonshade Earring", augments = {'MP+25','Latent effect: "Refresh"+1',}}

    --  Ambuscade Capes
    gear.AmbuscadeCapeIdle = { name = "Lugh's Cape", augments = {'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}
    gear.AmbuscadeCapeMAB  = { name = "Lugh's Cape", augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

    gear.BookwormCape = "Bookworm Cape"

    --  ----------------------------------------------------------------------------------------------------
    --   Idle Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.idle = {}

    sets.idle['Refresh'] = {
        main        = Oddy.MpacaStaff,
        sub         = "Enki Strap",
        ammo        = "Homiliary",
        head        = Chi.Head,
        body        = gear.EmpyreanBody,
        hands       = Chi.Hands,
        legs        = Chi.Legs,
        feet        = Chi.Feet,
        neck        = "Warder's Charm +1",
        waist       = "Null Belt",
        left_ear    = gear.Moonshade,
        right_ear   = "Etiolation Earring",
        left_ring   = "Gurebu's Ring",
        right_ring  = "Stikini Ring +1",
        back        = gear.AmbuscadeCapeIdle,
    }

    sets.idle['Hybrid'] = set_combine(sets.idle['Refresh'], {
        body        = gear.EmpyreanBody,
        hands       = Nyame.Hands,
        legs        = gear.EmpyreanLegs,
    })

    sets.idle['MagicEvasion'] = {
        main        = Oddy.MpacaStaff,
        sub         = "Enki Strap",
        ammo        = "Staunch Tathlum +1",
        head        = gear.EmpyreanHead,
        body        = gear.EmpyreanBody,
        hands       = Nyame.Hands,
        legs        = gear.EmpyreanLegs,
        feet        = Nyame.Feet,
        neck        = "Warder's Charm +1",
        waist       = "Null Belt",
        left_ear    = gear.Moonshade,
        right_ear   = "Etiolation Earring",
        left_ring   = "Gurebu's Ring",
        right_ring  = "Shadow Ring",
        back        = gear.AmbuscadeCapeIdle,
    }

    sets.idle['HybridMagEva'] = sets.idle['MagicEvasion']

    sets.latentRefresh50 = {
        waist       = "Fucho-no-Obi",           --  Latent: Refresh +1 when MP < 50%
    }

    sets.latentRefresh75 = {
        sub         = "Oneiros Grip",           --  Latent: Refresh +1 when MP <= 75%
    }

    sets.movement = {
        feet        = "Herald's Gaiters",       --  +12% Movement Speed
    }

    sets.sublimation = {
        head        = gear.ArtefactHead,
        body        = gear.RelicBody,
        waist       = "Embla Sash",
        right_ear   = "Savant's Earring",
        right_ring  = "Defending Ring",
    }

    sets.ToAU = {
        right_ring  = "Balrahn's Ring"
    }

    sets.town = {
        main        = "Daybreak",
        sub         = "Culminus",
        head        = gear.ArtefactHead,
        body        = gear.ArtefactBody,
        hands       = gear.ArtefactHands,
        legs        = gear.ArtefactLegs,
        feet        = gear.ArtefactFeet,
        neck        = "Incanter's Torque",
        left_ear    = gear.Moonshade,
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Gurebu-Ogurebu's Ring",
        right_ring  = "Janniston Ring +1",
        back        = "Aurist's Cape +1",
        waist       = "Hachirin-no-Obi",
    }

    sets.resting = {
        main        = "Boonwell Staff",
        sub         = "Ariesian Grip",
        ammo        = "Mana Ampulla",
        head        = "Orvail Corona +1",
        body        = "Chelona Blazer",
        hands       = "Nares Cuffs",
        legs        = "Nisse Slacks",
        feet        = "Chelona Boots",
        neck        = "Eidolon Pendant +1",
        waist       = "Shinjutsu-no-Obi +1",
        left_ear    = gear.Moonshade,
        right_ear   = "Infused Earring",
        left_ring   = "Gurebu-Ogurebu's Ring",
        right_ring  = "Angha Ring",
        back        = "Felicitas Cape",
    }

    sets.slept = {
        main = gear.WeaponPrime,
        sub = "Enki Staff",
    }

    --  ----------------------------------------------------------------------------------------------------
    --   Precast Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.precast = {}
    --  FC +41% (40% cap), Grimoire spellcast time -23%, Spell interruption -25%
    sets.precast.FC = {
        main        = Oddy.MpacaStaff,
        sub         = "Clerisy Strap",
        ammo        = "Incantor Stone",
        head        = gear.RelicHead,
        body        = "Zendik Robe",
        hands       = gear.ArtefactHands,
        legs        = Kay.Legs,
        feet        = gear.ArtefactFeet,
        neck        = "Baetyl Pendant",
        waist       = { name = "Shinjutsu-no-Obi +1", augments = {'Path: A',}},
        left_ear    = "Lugalbanda Earring",
        right_ear   = "Etiolation Earring",
        left_ring   = "Evanescence Ring",
        right_ring  = "Freke Ring",
        back        = "Fi Follet Cape +1",
    }

    sets.precast.FC.SixStepSc = set_combine(sets.precast.FC, {
        main        = "Twinned Blade",
        sub         = "Genmei Shield",
        feet        = gear.RelicFeet,   --  Makes up for the 8% FC lost from other items
        right_ear   = "Loquacious Earring",
        back        = gear.AmbuscadeCapeIdle,
    })

    sets.precast["Healing Magic"] = set_combine(sets.precast.FC, {
        main        = "Vadose Rod",
        sub         = "Calmius",
        back        = "Disperser's Cape",
    })

    sets.precast["Cure"] = set_combine(sets.precast.FC, {
        main        = "Vadose Rod",
        sub         = "Sors Shield",
        head        = Van.Head,
        body        = "Heka's Kalasiris",
        legs        = "Doyen Pants",
        feet        = Van.Feet,
        right_ear   = "Mendi. Earring",
        back        = "Pahtli Cape",
    })

    sets.precast["Curaga"] = sets.precast["Cure"]

    sets.precast["Enhancing Magic"] = set_combine(sets.precast.FC, {
        waist       = "Siegel Sash",
    })

    sets.precast["Stoneskin"] = set_combine(sets.precast["Enhancing Magic"], {
        head        = "Umuthi Hat",
        hands       = "Carapacho Cuffs",
        legs        = "Doyen Pants",
    })

    sets.precast["Enfeebling Magic"] = set_combine(sets.precast.FC, {})
    sets.precast["Elemental Magic"]  = set_combine(sets.precast.FC, {})
    sets.precast["Dark Magic"]       = set_combine(sets.precast.FC, {})

    sets.precast["Trust"] = {
        main        = Oddy.MpacaStaff,
        sub         = "Clerisy Strap",
        head        = gear.ArtefactHead,
        body        = gear.ArtefactBody,
        hands       = gear.ArtefactHands,
        legs        = gear.ArtefactLegs,
        feet        = gear.ArtefactFeet,
    }

    --  ----------------------------------------------------------------------------------------------------
    --   Midcast Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.midcast = {}

    sets.midcast.Potency = {
        back        = "Twilight Cape",
        waist       = "Hachirin-no-Obi",
    }

    sets.midcast["Enhancing Magic"] = {
        main        = "Oranyan",
        sub         = "Fulcio Grip",
        ammo        = "Savant's Treatise",
        head        = "Befouled Crown",
        body        = gear.RelicBody,
        hands       = Tel.Hands,
        legs        = gear.ArtefactLegs,
        feet        = Kay.Feet,
        neck        = "Incanter's Torque",
        waist       = "Embla Sash",
        left_ear    = "Mimir Earring",
        right_ear   = "Andoaa Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Stikini Ring +1",
        back        = "Fi Follet Cape +1",
    }

    sets.midcast["Duration"] = set_combine(sets.midcast["Enhancing Magic"], {
        main        = "Oranyan",            --  +10% Duration
        sub         = "Fulcio Grip",
        head        = gear.TeclhineHead,    --  +10% Duration
        body        = gear.RelicBody,       --  +12% Duration
        hands       = Tel.Hands,   --  +10% Duration
        legs        = Tel.Legs,    --  +10% Duration
        feet        = Tel.Feet,    --  +10% Duration
    })


    sets.midcast["BarElement"] = set_combine(sets.midcast["Enhancing Magic"], {
        head        = gear.TeclhineHead,
        body        = gear.RelicBody,
        hands       = Tel.Hands,
        legs        = "Shedir Seraweels",
        feet        = Tel.Feet,
        neck        = "Incanter's Torque",
        waist       = "Embla Sash",
        left_ear    = "Mimir Earring",
        right_ear   = "Etiolation Earring",
        left_ring   = "Gurebu-Ogurebu's Ring",
        right_ring  = "Stikini Ring +1",
        back        = "Fi Follet Cape +1",
    })

    sets.midcast['BarAilment'] = set_combine(sets.midcast['BarElement'], {
        neck        = "Sroda Necklace",                 --  Ailment Resistance Magic effect +20, Duration -50%
    })

    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
        legs        = "Haven Hose",
        neck        = "Nodens Gorget",
        waist       = "Siegel Sash",
        left_ear    = "Earthcry Earring",
    })

    sets.midcast["Regen"] = set_combine(sets.midcast["Duration"], {
        main        = { name     = "Coeus",
                        augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Fulcio Grip",
        head        = gear.EmpyreanHead,
        back        = gear.AmbuscadeCapeIdle

    })

    sets.midcast["Refresh"] = set_combine(sets.midcast["Duration"], {
        head        = Ama.Head,
    })

    sets.RefreshSelfDuration = {
        feet        = "Inspirited Boots",
    }

    sets.midcast["Aquaveil"] = set_combine(sets.midcast["Duration"], {
        main        = "Vadose Rod",
        sub         = "Culminus",
        head        = Ama.Head,
        legs        = "Shedir Seraweels",
        waist       = "Emphatikos Rope",
    })

    sets.midcast["Protect"] = set_combine(sets.midcast["Duration"], {
        right_ring   = "Sheltered Ring",                 -- Enhances Protect & Shell
    })
    sets.midcast["Protectra"] = sets.midcast["Protect"]
    sets.midcast["Shell"]     = sets.midcast["Protect"]
    sets.midcast["Shellra"]   = sets.midcast["Protect"]

    sets.midcast["Healing Magic"] = {
        main        = { name     = "Coeus",
                        augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Clerisy Strap",
        ammo        = "Incantor Stone",
        head        = Van.Head,
        body        = gear.RelicBody,
        hands       = gear.RelicHands,
        legs        = gear.ArtefactLegs,
        feet        = Van.Feet,
        neck        = "Colossus's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Healing Earring",
        left_ring   = "Sirona's Ring",
        right_ring  = "Haoma's Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast["StatusRemoval"] = sets.midcast["Healing Magic"]

    sets.midcast["Cursna"] = set_combine(sets.midcast["StatusRemoval"], {
        feet        = "Gendewitha Galosches +1",
        neck        = "Debilis Medallion",
        left_ring   = "Haoma's Ring",
        right_ring  = "Haoma's Ring",
        back        = "Oretan. Cape +1",
    })

    sets.midcast.Cure = {
        main        = "Daybreak",
        sub         = "Ammurapi Shield",
        ammo        = "Quartz Tathlum +1",
        head        = Van.Head,
        body        = Kay.Body,
        hands       = gear.RelicHands,
        legs        = gear.ArtefactLegs,
        feet        = Van.Feet,
        neck        = "Incanter's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Meili Earring",
        left_ring   = "Jann. Ring +1",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast.Rapture = {
        main        = "Daybreak",
        sub         = "Ammurapi Shield",
        ammo        = "Quartz Tathlum +1",
        head        = gear.EmpyreanHead,
        body        = Kay.Body,
        hands       = gear.RelicHands,
        legs        = gear.ArtefactLegs,
        feet        = Van.Feet,
        neck        = "Incanter's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Mendi. Earring",
        right_ear   = "Meili Earring",
        left_ring   = "Jann. Ring +1",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast["Enfeebling Magic"] = {
        main        = { name     = "Coeus",
                        augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
        sub         = "Enki Strap",
        ammo        = "Quartz Tathlum +1",
        head        = "Jhakri Coronal +1",
        body        = "Jhakri Robe +2",
        hands       = "Jhakri Cuffs +2",
        legs        = gear.EmpyreanLegs,
        feet        = "Jhakri Pigaches +1",
        neck        = "Erra Pendant",
        waist       = "Casso Sash",
        left_ear    = "Lifestorm Earring",
        right_ear   = "Psystorm Earring",
        left_ring   = "Stikini Ring +1",
        right_ring  = "Kishar Ring",
        back        = "Aurist's Cape +1",
    }

    sets.midcast["Elemental Magic"] = {
        main        = { name     = "Akademos",
                        augments = {'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
        sub         = "Thrace Strap",
        ammo        = "Pemphredo Tathlum",
        head        = gear.RelicHead,
        body        = gear.RelicBody,
        hands       = gear.EmpyreanHands,
        legs        = gear.EmpyreanLegs,
        feet        = gear.EmpyreanFeet,
        neck        = "Baetyl Pendant",
        waist       = "Aswang Sash",
        left_ear    = "Malignance Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Resonance Ring",
        right_ring  = "Freke Ring",
        back        = gear.AmbuscadeCapeMAB,
    }

    sets.midcast["Helix"] = set_combine(sets.midcast["Elemental Magic"], {
        neck        = gear.DynamisNeck,
        back        = gear.BookwormCape,
    })

    sets.MagicBurst = {
        head        = gear.RelicHead,
        body        = gear.ArtefactBody,
        hands       = gear.EmpyreanHands,
        feet        = gear.EmpyreanFeet,
        neck        = gear.DynamisNeck,
        left_ring   = "Jhakri Ring",
    }

    sets.midcast["Dark Magic"] = set_combine(sets.midcast["Elemental Magic"], {
        main        = { name     = "Rubicundity",
                        augments = {'Mag. Acc.+3','"Mag.Atk.Bns."+3','Dark magic skill +5','"Conserve MP"+2',}},
        sub         = "Ammurapi Shield",
        neck        = "Erra Pendant",
        left_ring   = "Evanescence Ring",
    })

    sets.midcast["Drain"] = set_combine(sets.midcast["Dark Magic"], {
        head        = "Appetence Crown",
        feet        = "Merlinic Crackows",
        right_ear   = "Hirudinea Earring",
    })

    sets.midcast["Aspir"] = sets.midcast["Drain"]

    sets.midcast["Trust"] = sets.precast["Trust"]


    --  ----------------------------------------------------------------------------------------------------
    --   Misc Sets
    --  ----------------------------------------------------------------------------------------------------
    sets.RaptureEbullience        = { head  = gear.EmpyreanHead }
    sets.PerpetuanceImmanence     = { hands = gear.EmpyreanHands }
    sets.PenuryParsimony          = { legs  = gear.EmpyreanLegs }
    sets.Klimaform                = { feet  = gear.EmpyreanFeet }
    sets.AltruismFocalization     = { head  = gear.RelicHead }
    sets.precast["Enlightenment"] = { body  = gear.RelicBody }
    sets.TranquilityEquanimity    = { hands = gear.RelicHands }
    sets.precast["Tabula Rasa"]   = { legs  = gear.RelicLegs }
    sets.Stormsurge               = { feet  = gear.RelicFeet }
    sets.CelerityAlacrity         = { feet  = gear.RelicFeet }
end