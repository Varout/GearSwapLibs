--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
    include("common_lists.lua")
    include("common_functions.lua")
end

--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()
    --  Scholar Specific
    state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
    state.Buff["Sublimation: Complete"]  = buffactive["Sublimation: Complete"]  or false
    state.Buff["Tabula Rasa"]   = buffactive["Tabula Rasa"] or false
    state.Buff["Klimaform"]     = buffactive["Klimaform"] or false
    state.Buff["Enlightenment"] = buffactive["Enlightenment"] or false

    --  Scholar Specific: Light Arts
    state.Buff["Altruism"]    = buffactive["Altruism"] or false
    state.Buff["Penury"]      = buffactive["Penury"] or false
    state.Buff["Perpetuance"] = buffactive["Perpetuance"] or false
    state.Buff["Rapture"]     = buffactive["Rapture"] or false
    state.Buff["Tranquility"] = buffactive["Tranquility"] or false

    --  Scholar Specific: Dark Arts
    state.Buff["Ebullience"]   = buffactive["Ebullience"] or false
    state.Buff["Immanence"]    = buffactive["Immanence"] or false
    state.Buff["Parsimony"]    = buffactive["Parsimony"] or false
    state.Buff["Focalization"] = buffactive["Focalization"] or false
    state.Buff["Equanimity"]   = buffactive["Equanimity"] or false

    --  White mage Specific
    state.Buff["Divine Seal"] = buffactive["Divine Seal"] or false

    --  Black Magic Specific
    state.Buff["Elemental Seal"] = buffactive["Elemental Seal"] or false
end

--  ----------------------------------------------------------------------------------------------------
--
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    -- state.OffenseMode:options("Normal") --  F9
    -- state.HybridMode:options("Normal")  --  F10
    -- state.CastingMode:options("Normal") --  F11
    -- state.IdleMode:options("Normal")    --  F12

    --  Which macro book to default to when changing jobs
    select_default_macro_book()

    --  Special states to track for White Mage
    -- state.CP = M(false, "CP Mode")              --  CP Mode: SCH is mastered, so likely won"t need this anymore
    state.Dynamis = M(false, "Dynamis Mode")    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    -- state.Debug = M(false, "Debug Mode")        --  Debug Mode: Helpful for outputting information in the LUA. Not set up
    state.MB = M(false, "MB Mode")              --  MB Mode: Focusing nukes to be magic bursts

    --  Where @ is the Windows Key
    -- send_command("bind @c gs c toggle CP")      --  Windows Key + C: Toggle CP Mode
    send_command("bind @x gs c toggle Dynamis") --  Windows Key + X: Toggle Dynamis Mode
    -- send_command("bind @m input /map")          --  Windows Key + M: Show map, because I"m lazy af
    -- send_command("bind @z gs c toggle Debug")   --  Windows Key + Z: Toggle Debug Mode
    send_command("bind @b gs c toggle MB")      --  Windows Key + B: Toggle MB Mode

    --  Set up lockstyle set
    -- randomise_lockstyle()

    --  Make sure all equipment slots are unlocked when we change to this job
    -- equipment_unlock_all()
end

function user_unload()
    -- send_command("unbind @c")
    send_command("unbind @x")
    -- send_command("unbind @m")
    -- send_command("unbind @z")
    send_command("unbind @b")
end

function init_gear_sets()
    --  **************************************************************************************  --
    --                                    JOB SPECIFIC                                          --
    --  **************************************************************************************  --
    gear.Artifact = {}
    --  Artifact: Academic's Attire Set. Enhances: Acc, Rng Acc, & Magic Acc
    gear.Artifact.Head  = "Academic's Mortarboard +3"   --  Enhances "Sublimation" effect
    gear.Artifact.Body  = "Academic's Gown +2"          --  Enhances "Dark Arts"
    gear.Artifact.Hands = "Academic's Bracers +2"       --
    gear.Artifact.Legs  = "Academic's Pants +2"         --  Enhances "Light Arts"
    gear.Artifact.Feet  = "Academic's Loafers +2"       --

    --  Relic: Pedagogy Attire Set
    gear.Relic = {}
    gear.Relic.Head  = "Pedagogy Mortarboard +2"    --  Enhances "Altruism" and "Focalization"
    gear.Relic.Body  = "Pedagogy Gown +3"           --  Enhances "Enlightenment" effect. Enhances "Sublimation" effect
    gear.Relic.Hands = "Pedagogy Bracers +3"        --  Enhances "Tranquility" and "Equanimity"
    gear.Relic.Legs  = "Pedagogy Pants +2"          --  Enhances "Tabula Rasa" effect
    gear.Relic.Feet  = "Pedagogy Loafers +2"        --  Enhances "Stormsurge" effect. Weather: "Celerity" and "Alacrity" effect +16

    --  Empyrean: Arbatel Attire Set. Augments Grimoire
    gear.Empyrean = {}
    gear.Empyrean.Head  = "Arbatel Bonnet +1"   --  “Rapture”+15 “Ebullience”+15 “Regen” potency +15%
    gear.Empyrean.Body  = "Arbatel Gown +1"     --  “Refresh”+2 “Addendum: White” Enmity -22 “Addendum: Black” Enmity -22
    gear.Empyrean.Hands = "Arbatel Bracers +1"  --  “Perpetuance”+55% “Immanence”+11%
    gear.Empyrean.Legs  = "Arbatel Pants +1"    --  “Penury” and “Parsimony” +4
    gear.Empyrean.Feet  = "Arbatel Loafers +1"  --  Klimarform +15

    --  **************************************************************************************  --
    --                                    GENERAL SETS                                          --
    --  **************************************************************************************  --
    sets.precast = {}
    sets.midcast = {}

    --  Gear sets for specific conditions and commands
    --  Neck equipment to lock in while in dynamis
    sets.JSENeck = {
        neck      = "Argute Stole",
    }
    --  Used for locking in back piece for CP bonus
    sets.CP = {
        back      = "Mecistopins Mantle",
    }
    --  Idle refresh in specific ToAU areas
    sets.ToAU = {
        left_ring = "Balrahn's Ring",
    }
    --  Reive specific
    sets.Reives = {
        neck       = "Arciela's Grace +1",
    }

    sets.resting = {
        main       = "Boonwell Staff",
        sub        = "Ariesian Grip",
        ammo       = "Mana Ampulla",
        head       = "Orvail Corona +1",
        body       = "Chelona Blazer",
        hands      = "Nares Cuffs",
        legs       = "Nisse Slacks",
        feet       = "Chelona Boots",
        neck       = "Eidolon Pendant +1",
        waist      = "Austerity Belt",
        left_ear   = { name     = "Moonshade Earring",
                       augments = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear  = "Infused Earring",
        left_ring  = "Angha Ring",
        right_ring = "Star Ring",
        back       = "Felicitas Cape",
    }

    -- sets.idle = {
    --     main={ name="Mpaca's Staff", augments={'Path: A',}},
    --     sub="Enki Strap",
    --     ammo="Homiliary",
    --     head={ name="Chironic Hat", augments={'Pet: Phys. dmg. taken -1%','"Dbl.Atk."+3','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    --     body="Jhakri Robe +2",
    --     hands={ name="Chironic Gloves", augments={'Pet: MND+10','Attack+5','"Refresh"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    --     legs="Assid. Pants +1",
    --     feet={ name="Chironic Slippers", augments={'Pet: DEX+15','VIT+8','"Refresh"+2','Accuracy+12 Attack+12',}},
    --     neck={ name="Loricate Torque +1", augments={'Path: A',}},
    --     waist="Fucho-no-Obi",
    --     left_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
    --     right_ear="Etiolation Earring",
    --     left_ring="Defending Ring",
    --     right_ring="Sheltered Ring",
    --     back="Solemnity Cape",
    -- }

    -- sets.idleRefresh = {
    --     waist      = "Fucho-no-Obi",
    -- }

    --  **************************************************************************************  --
    --                                JOB ABILITIES & TRAITS                                    --
    --  **************************************************************************************  --
    --  Equipment that enhances the charge rate of Sublimation
    sets.Sublimation = {
        head      = gear.Artifact.Head,
        body      = gear.Relic.Body,
        right_ear = "Savant's Earring",
        waist     = "Embla Sash"
    }

    sets.Stormsurge = {
        feet       = gear.Relic.Feet
    }

    sets.precast.JA = {}
    sets.precast.JA["RaptureEbullience"]     = { head  = gear.Empyrean.Head }
    sets.precast.JA["PerpetuanceImmanence"]  = { hands = gear.Empyrean.Hands }
    sets.precast.JA["PenuryParsimony"]       = { legs  = gear.Empyrean.Legs }
    sets.precast.JA["AltruismFocalization"]  = { head  = gear.Relic.Head }
    sets.precast.JA["Enlightenment"]         = { body  = gear.Relic.Body }
    sets.precast.JA["TranquilityEquanimity"] = { hands = gear.Relic.Hands }
    sets.precast.JA["TabulaRasa"]            = { legs  = gear.Relic.Legs }

    sets.midcast.JA = {}
    sets.midcast.JA["RaptureEbullience"]     = sets.precast.JA["RaptureEbullience"]
    sets.midcast.JA["PerpetuanceImmanence"]  = sets.precast.JA["PerpetuanceImmanence"]
    sets.midcast.JA["PenuryParsimony"]       = sets.precast.JA["PenuryParsimony"]
    sets.midcast.JA["AltruismFocalization"]  = sets.precast.JA["AltruismFocalization"]
    sets.midcast.JA["Enlightenment"]         = sets.precast.JA["Enlightenment"]
    sets.midcast.JA["TranquilityEquanimity"] = sets.precast.JA["TranquilityEquanimity"]

    --  **************************************************************************************  --
    --                                    SPELL CASTING                                         --
    --  **************************************************************************************  --
    --                                      PRE-CAST                                            --
    --  **************************************************************************************  --
    sets.precast = {
        main="Oranyan",
        sub="Clerisy Strap",
        ammo="Incantor Stone",
        head=gear.Artifact.Head,
        body="Merlinic Jubbah",
        hands="Acad. Bracers +2",
        legs={ name="Kaykaus Tights", augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet={ name="Peda. Loafers +2", augments={'Enhances "Stormsurge" effect',}},
        neck="Baetyl Pendant",
        waist="Embla Sash",
        left_ear="Loquac. Earring",
        right_ear="Malignance Earring",
        left_ring="Evanescence Ring",
        right_ring="Kishar Ring",
        back="Solemnity Cape",
    }

    sets.precast["Healing Magic"] = set_combine(sets.precast, {
        back       = "Disperser's Cape",
    })

    sets.precast["Cure"] = set_combine(sets.precast["Healing Magic"], {
        main       = "Vadose Rod",
        sub        = "Sors Shield",
        head       = { name     = "Vanya Hood",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body       = "Heka's Kalasiris",
        feet       = { name     = "Vanya Clogs",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        right_ear  = "Mendi. Earring",
        back       = "Pahtli Cape",
    })

    sets.precast["Enhancing Magic"] = set_combine(sets.precast, {
        waist      = "Siegel Sash",
    })

    sets.precast["Stoneskin"] = set_combine(sets.precast["Enhancing Magic"], {
        head       = "Umuthi Hat",
        hands      = "Carapacho Cuffs",
        legs = 'Doyen Pants',
    })

    -- sets.precast["Aquaveil"] = set_combine(sets.precast["Enhancing Magic"], {})
    -- sets.precast["Regen"] = set_combine(sets.precast["Enhancing Magic"], {})

    sets.precast["Enfeebling Magic"] = set_combine(sets.precast, {})

    sets.precast["Elemental Magic"] = set_combine(sets.precast, {})

    sets.precast["Dark Magic"] = set_combine(sets.precast, {})

    --  **************************************************************************************  --
    --                                    SPELL CASTING                                         --
    --  **************************************************************************************  --
    --                                      MID-CAST                                            --
    --  **************************************************************************************  --
    sets.midcast["Trust"] = {
        main = "Mpaca's Staff",
        sub = "Enki Strap",
        head = gear.Artifact.Head,
        body = gear.Artifact.Body,
        hands = gear.Artifact.Hands,
        legs = gear.Artifact.Legs,
        feet = gear.Artifact.Feet,
    }

    sets.midcast.WeattherDayBoost = {
        -- main = "",
        back = "Twilight Cape",     --  +5% extra, ? (2), ? (3)
        waist = "Hachirin-no-Obi",  --  +10% extra (1), +20% extra (2), +25% extra (3)
    }

    sets.midcast = {}

    -- sets.midcast["Healing Magic"] = set_combine(sets.midcast, {
    --     main="Oranyan",
    --     sub="Enki Strap",
    --     ammo="Quartz Tathlum +1",
    --     head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    --     body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    --     hands={ name="Peda. Bracers +3", augments={'Enh. "Tranquility" and "Equanimity"',}},
    --     legs="Acad. Pants +2",
    --     feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    --     neck="Incanter's Torque",
    --     waist="Bishop's Sash",
    --     left_ear="Beatific Earring",
    --     right_ear="Meili Earring",
    --     left_ring="Sirona's Ring",
    --     right_ring="Haoma's Ring",
    --     back="Altruistic Cape",
    -- })

    sets.midcast["Cursna"] = set_combine(sets.midcast["Healing Magic"], {
        neck       = "Debilis Medallion",
        left_ring  = "Menelaus's Ring",
        right_ring = "Haoma's Ring",
        back       = "Oretan. Cape +1",
    })


    sets.midcast["Cure"] = set_combine(sets.midcast["Healing Magic"], {
        main       = "Vadose Rod",
        sub        = "Sors Shield",
        ammo       = "Quartz Tathlum +1",
        head       = { name     = "Vanya Hood",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body       = { name     = "Kaykaus Bliaut",
                       augments = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands      = { name     = "Peda. Bracers +3",
                       augments = {'Enh. "Tranquility" and "Equanimity"',}},
        legs       = "Acad. Pants +2",
        feet       = { name     = "Vanya Clogs",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck       = "Colossus's Torque",
        waist      = "Bishop's Sash",
        left_ear   = "Beatific Earring",
        right_ear  = "Mendi. Earring",
        left_ring  = "Janniston Ring",
        right_ring = "Sirona's Ring",
        back       = "Altruistic Cape",
    })

    -- sets.midcast.Cure = {
    --     main       = "Vadose Rod",
    --     sub        = "Sors Shield",
    --     ammo       = "Quartz Tathlum +1",
    --     head       = { name     = "Vanya Hood",
    --                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    --     body       = { name     = "Kaykaus Bliaut",
    --                    augments = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
    --     hands      = { name     = "Peda. Bracers +3",
    --                    augments = {'Enh. "Tranquility" and "Equanimity"',}},
    --     legs       = "Acad. Pants +2",
    --     feet       = { name     = "Vanya Clogs",
    --                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    --     neck       = "Colossus's Torque",
    --     waist      = "Bishop's Sash",
    --     left_ear   = "Beatific Earring",
    --     right_ear  = "Mendi. Earring",
    --     left_ring  = "Janniston Ring",
    --     right_ring = "Sirona's Ring",
    --     back       = "Altruistic Cape",
    -- }

    sets.midcast.CureBonus = {

    }

    sets.midcast["Enhancing Magic"] = set_combine(sets.midcast, {
        main="Oranyan",
        sub="Fulcio Grip",
        ammo="Savant's Treatise",
        head="Befouled Crown",
        body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
        hands={ name="Telchine Gloves", augments={'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +8',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
        left_ring="Stikini Ring",
        right_ring="Stikini Ring",
        back="Fi Follet Cape",
    })

    sets.midcast["BarElement"] = set_combine(sets.midcast["Enhancing Magic"], {
        legs="Shedir Seraweels",
        feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
        waist="Olympus Sash",
    })

    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
        neck = "Nordens Gorget",
        right_ear = "Earthcry Earring",
        waist = "Siegel Sash",
        legs = "Shedir Serawells",
    })

    sets.midcast["Regen"] = set_combine(sets.midcast["Enhancing Magic"], {
        main = "Bolelabunga",
        sub = "Ammurapi Shield",
        head = gear.Empyrean.Head,
        back = { name = "Lugh's Cape", augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},

    })

    sets.midcast["Aquaveil"] = set_combine(sets.midcast["Enhancing Magic"], {
        main = "Vadose Rod",
        sub = "Ammurapi Shield",
        head = { name="Chironic Hat", augments={'Pet: Phys. dmg. taken -1%','"Dbl.Atk."+3','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
        legs = "Shedir Serawells",
    })

    sets.midcast["Protect"] = set_combine(sets.midcast["Enhancing Magic"], {
        left_ring = "Sheltered Ring",
    })

    sets.midcast["Shell"] = sets.midcast["Protect"]

    sets.midcast["Refresh"] = set_combine(sets.midcast["Enhancing Magic"], {
        feet = "Inspirited Boots",
    })

    sets.midcast["Haste"] = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast["Phalanx"] = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast["Storm"] = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast.MagicAccuracy = {

    }

    sets.midcast["Enfeebling Magic"] = set_combine(sets.midcast.MagicAccuracy, {})

    sets.midcast["Klimaform"] = { feet  = gear.Empyrean.Feet }

    sets.midcast.MagicBurst = {}
    sets.midcast["Elemental Magic"] = set_combine(sets.midcast, {})

    sets.midcast["Dark Magic"] = set_combine(sets.midcast, {})

------------------------------------------------------------------------------------------

    -- sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
    --     legs       = "Haven Hose",
    --     neck       = "Nodens Gorget",
    --     waist      = "Siegel Sash",
    --     left_ear   = "Earthcry Earring",
    -- })

    -- sets.midcast["Regen"] = set_combine(sets.midcast["Enhancing Magic"], {
    --     main       = { name     = "Coeus",
    --                    augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
    --     sub        = "Fulcio Grip",
    --     head       = "Arbatel Bonnet",
    --     legs       = { name     = "Telchine Braconi",
    --                    augments = {'"Regen" potency+3',}},
    --     back       = { name     = "Lugh's Cape",
    --                    augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    -- })

    -- sets.midcast["Shell"] = set_combine(sets.midcast["Enhancing Magic"], {
    --     left_ring  = "Sheltered Ring",
    -- })

    -- sets.midcast["Protect"] = set_combine(sets.midcast["Enhancing Magic"], {
    --     left_ring  = "Sheltered Ring",
    -- })

    -- sets.midcast["Aquaveil"] = set_combine(sets.midcast["Enhancing Magic"], {
    --     main       = "Vadose Rod",
    --     sub        = "Ammurapi Shield",
    -- })

    -- --  Base set for magic accuracy for Divine and Enfeebling
    -- sets.midcast["Enfeebling Magic"] = {
    --     main       = { name     = "Coeus",
    --                    augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
    --     sub        = "Enki Strap",
    --     ammo       = "Quartz Tathlum +1",
    --     head       = "Jhakri Coronal +1",
    --     body       = "Jhakri Robe +2",
    --     hands      = "Jhakri Cuffs +2",
    --     legs       = "Arbatel Pants +1",
    --     feet       = "Jhakri Pigaches +1",
    --     neck       = "Erra Pendant",
    --     waist      = "Casso Sash",
    --     left_ear   = "Lifestorm Earring",
    --     right_ear  = "Psystorm Earring",
    --     left_ring  = "Stikini Ring",
    --     right_ring = "Kishar Ring",
    --     back       = { name     = "Lugh's Cape",
    --                    augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    -- }

    -- sets.midcast["Enfeebling Magic"].Light = set_combine( sets.midcast["Enfeebling Magic"], {
    --     body       = "Academic's Gown +2",
    -- })

    -- sets.midcast["Enfeebling Magic"].Dark = set_combine( sets.midcast["Enfeebling Magic"], {
    --     legs       = "Academic's Pants +2",
    -- })

    -- sets.midcast["Divine Magic"] = {}

    -- sets.midcast["Elemental Magic"] = {
    --     main       = { name     = "Akademos",
    --                    augments = {'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    --     sub        = "Enki Strap",
    --     ammo       = "Hydrocera",
    --     head       = "Pedagogy Mortaboard +2",
    --     body       = "Jhakri Robe +2",
    --     hands      = { name     = "Pedagogy Bracers +3",
    --                    augments = {'Enh. "Tranquility" and "Equanimity"',}},
    --     legs       = "Jhakri Slops +2",
    --     feet       = "Jhakri Pigaches +2",
    --     neck       = "Argute Sole",
    --     waist      = "Aswang Sash",
    --     left_ear   = "Barkarole Earring",
    --     right_ear  = "Hecate's Earring",
    --     left_ring  = "Mallquis Ring",
    --     right_ring = "Jhakri Ring",
    --     back       = { name     = "Lugh's Cape",
    --                    augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
    -- }

    -- sets.midcast.MagicBurst = {
    --     main       = "Mpaca's Staff",
    --     neck       = "Argute Sole",
    --     head       = "Pedagogy Mortaboard +2",
    --     right_ring = "Jhakri Ring",
    --     feet       = "Jhakri Pigaches +2",
    -- }

    -- sets.midcast["Dark Magic"] = set_combine(sets.midcast["Elemental Magic"], {
    --     main       = { name     = "Rubicundity",
    --                    augments = {'Mag. Acc.+3','"Mag.Atk.Bns."+3','Dark magic skill +5','"Conserve MP"+2',}},
    --     sub        = "",
    --     neck       = "Erra Pendant",
    --     left_ring  = "Evanescence Ring",
    -- })

    -- sets.midcast["Drain"] = {
    --     head       = "Appetence Crown",
    --     right_ear  = "Hirudinea Earring",
    -- }

    -- sets.midcast["Aspir"] = sets.midcast["Drain"]
end


function job_precast(spell, action, spellMap, eventArgs)
    -- if player.tp > player_tp_lock then
    --     melee_equip_lock()
    -- end

    check_special_ring_equipped()

    if spell.action_type == "Magic" and buffactive["Silence"] then
        -- If silenced, use what"s available to remove it
        cancel_spell()
        if player.inventory["Catholicon"] ~= nil then
            send_command("input /item \"Catholicon\" <me>")
            send_command("input /echo *!! Silenced ~ Using Catholicon @ "..player.inventory["Catholicon"].count.." Left !!*")
        elseif player.inventory["Echo Drops"] ~= nil then
            send_command("input /item \"Echo Drops\" <me>")
            send_command("input /echo *!! Silenced ~ Using Echo Drops @ "..player.inventory["Echo Drops"].count.." Left !!*")
        elseif player.inventory["Remedy"] ~= nil then
            send_command("input /item \"Remedy\" <me>")
            send_command("input /echo *!! Silenced ~ Using Remedy @ "..player.inventory["Remedy"].count.." Left !!*")
        else
            send_command("input /echo *!! Silenced ~ No items to remove it !!*")
        end
        eventArgs.cancel = true
        return
    elseif spell.name == "Sublimation" and buffactive["Weakness"] then
        --  If weakend, don"t waste your Sublimation
        cancel_spell()
        send_command("input /echo *!! Weakend ~ Cancelling Sublimation !!*")
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    elseif spellMap == "Cure" then
        windower.add_to_chat(9, "Cure")
        equip(sets.precast["Cure"])
        eventArgs.handled = true
        return
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- if player.tp > player_tp_lock then
    --     melee_equip_lock()
    -- end

    if spell.action_type == "Magic" then
        spell_element_match = spell.element == world.weather_element or spell.element == world.day_element

        if spell_element_match or state.Buff["Klimaform"] then
            if spell.skill == "Enfeebling Magic" then
                equipSet = sets.midcast["Enfeebling Magic"]
            elseif spell.skill == "Divine Magic" then
                equipSet = sets.midcast["Divine Magic"]
            elseif spell.skill == "Elemental Magic" then
                equipSet = sets.midcast["Elemental Magic"]
            elseif spell.skill == "Dark Magic" then
                equipSet = sets.midcast["Dark Magic"]
            end

            --  Combine sets for matched day and/or weather to spell element
            if spell_element_match then
                equipSet = set_combine(equipSet, sets.midcast.WeatherBoost)
            end

            --  Magic Burst & Klimaform
            if spell.skill == "Elemental Magic" or spell.skill == "Dark Magic" then
                --  Combine sets for Magic Bursts
                if state.MB.current == "on" then
                    equipSet = set_combine(equipSet, sets.midcast.MB)
                end

                --  Combine for Klimaform
                if state.Buff["Klimaform"] then
                    equipSet = set_combine(equipSet, sets.midcast.Klimaform)
                end
            end
        end
        equip(equipSet)
        eventArgs.handled = true
        return
    end

    -- if spell.type == "Trust" then
    --     equipSet = sets.trust
    -- end
end


function customize_idle_set(idleSet)
    -- if state.Debug.current == "on" then
    --    windower.add_to_chat(9, "Currently in: " .. world.area)
    -- end

    -- if player.tp < player_tp_lock then
    --     melee_equip_unlock()
    -- end

    check_equipment_special_ring()
    check_status_cp()
    check_status_dynamis()

    --  Checking player stats
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  If in an Adoulin zone, equip body piece if available
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    --  Check if sublimation is active
    if state.Buff["Sublimation: Activated"] then
        idleSet = set_combine(idleSet, sets.Sublimation)
    end

    return idleSet
end


-- function user_status_change(newStatus, oldStatus)
--     if newStatus == "Engaged" then
--         melee_equip_lock()
--     elseif oldStatus == "Engaged" then
--         melee_equip_unlock()
--     end
-- end


--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)
    if state.Buff["Sublimation: Activated"] then
        equip(sets.Sublimation)
    elseif buff == "Sublimation: Activated" and not gain then
        equip(sets.idle)
    end
end


function job_self_command(cmdParams, eventArgs)

    -- if cmdParams[1]:lower() == "test" then
    --     add_to_chat(100, reraiseIV)
    -- end

    --  Make Reraise easy to handle
    -- if (string.find(cmdParams[1]:lower(), "rr")) and (not buffactive["Reraise"]) then
    --     local reraise_level = cmdParams[1]:gsub("rr", "")
    --     if reraise_level == "0" then
    --         send_command("@input /echo *** Cancelling: No reraise level stated. ***")
    --     elseif reraise_level == "1" then
    --         send_command("@input /ma "Reraise" <me>")
    --     elseif reraise_level == "2" then
    --         send_command("@input /ma "Reraise II" <me>")
    --     elseif reraise_level == "3" then
    --         send_command("@input /ma "Reraise III" <me>")
    --     else
    --         send_command("@input /echo *** Cancelling: Something weird happened. ***")
    --     end
    --     eventArgs.handled = true
    --     return
    -- elseif cmdParams[1]:lower() == "reraise" then
    --     send_command("@input /echo *** Cancelling: Reraise already active. ***")
    --     eventArgs.handled = true
    --     return
    -- end

    --  Make Raise easy to handle
    -- if cmdParams[1]:lower() == "raise" then
    --     local raise_level = cmdParams[2]
    --     if reraise_level == "nil" then
    --         send_command("@input /echo *** Cancelling. No Raise Level Stated. ***")
    --     elseif reraise_level == "1" then
    --         send_command("@input /ma "Raise" <me>")
    --     elseif reraise_level == "2" then
    --         send_command("@input /ma "Raise II" <me>")
    --     elseif reraise_level == "3" then
    --         send_command("@input /ma "Raise III" <me>")
    --     else
    --         send_command("@input /echo *** What are you even doing? ***")
    --     end
    --     eventArgs.handled = true
    --     return
    -- end
end


function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------

--  Locks the correct ring slot if a listed ring is equipped
--  Unlocks the slot if the ring is no longer detected
function check_equipment_special_ring()
    if equip_lock_rings:contains(player.equipment.ring1) then
        -- windower.add_to_chat(9, 'Ring1 locked')
        special_ring_equipped = true
        equipment_lock_specific({'ring1'})
    elseif equip_lock_rings:contains(player.equipment.ring2) then
        -- windower.add_to_chat(9, 'Ring2 locked')
        special_ring_equipped = true
        equipment_lock_specific({"ring2"})
    elseif special_ring_equipped then
        -- windower.add_to_chat(9, 'Unlocking rings')
        special_ring_equipped = false
        equipment_unlock_specific({'ring1', 'ring2'})
    end
end


function check_status_dynamis()
    if state.Dynamis.current == 'on' then
        equip(sets.JSENeck)
        equipment_lock_specific({'neck',})
    else
        equipment_unlock_specific({'neck',})
    end
end


function check_status_cp()
    if state.CP.current == 'on' then
        equip(sets.CP)
        equipment_lock_specific({'back',})
    else
        equipment_unlock_specific({'back',})
    end
end


-- --  Lock weapon and sub slots
-- function melee_equip_lock()
--     disable("main")
--     disable("sub")
-- end

-- --  Unlock weapon and sub slots
-- function melee_equip_unlock()
--     -- add_to_chat(30, "Unlocking melee")
--     enable("main")
--     enable("sub")
-- end