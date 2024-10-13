--  ----------------------------------------------------------------------------------------------------
--   Job Specific Armour
--  ----------------------------------------------------------------------------------------------------
gear.ArtefactHead  = "Academic's Mortarboard +3"
gear.ArtefactBody  = "Academic's Gown +2"
gear.ArtefactHands = "Academic's Bracers +2"
gear.ArtefactLegs  = "Academic's Pants +3"
gear.ArtefactFeet  = "Academic's Loafers +2"

gear.RelicHead  = "Pedagogy Mortarboard +2"
gear.RelicBody  = "Pedagogy Gown +3"
gear.RelicHands = "Pedagogy Bracers +3"
gear.RelicLegs  = "Pedagogy Pants +2"
gear.RelicFeet  = "Pedagogy Loafers +3"

gear.EmpyreanHead  = "Arbatel Bonnet +1"
gear.EmpyreanBody  = "Arbatel Gown +1"
gear.EmpyreanHands = "Arbatel Bracers +1"
gear.EmpyreanLegs  = "Arbatel Pants +1"
gear.EmpyreanFeet  = "Arbatel Loavers +1"

gear.EmpyreanRightEar = "Arbatel Earring"
gear.DynamisNeck      = { name     = "Argute Stole",
                          augments = {'Path: A',}}

--  REMA Weapons
-- gear.WeaponMythic   = ""
-- gear.WeaponEmpyrean = ""
-- gear.WeaponAeonic   = ""
-- gear.WeaponPrime    = ""

--  Ambuscade Capes
gear.AmbuscadeCapeIdle = gear.AmbuscadeCapeMAB
gear.AmbuscadeCapeMAB = { name = "Lugh's Cape", augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

--  ----------------------------------------------------------------------------------------------------
--   Idle Sets
--  ----------------------------------------------------------------------------------------------------
sets.idle = {
    main        = { name     = "Mpaca's Staff",
                    augments={'Path: A',}},
    sub         = "Enki Strap",
    ammo        = "Homiliary",
    head        = { name     = "Chironic Hat",
                    augments = {'Pet: Phys. dmg. taken -1%','"Dbl.Atk."+3','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    body        = "Jhakri Robe +2",
    hands       = { name     = "Chironic Gloves",
                    augments = {'Pet: MND+10','Attack+5','"Refresh"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    legs        = { name     = "Chironic Hose",
                    augments = {'Accuracy+7','CHR+5','"Refresh"+2','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
    feet        = { name     = "Chironic Slippers",
                    augments = {'Pet: DEX+15','VIT+8','"Refresh"+2','Accuracy+12 Attack+12',}},
    neck        = { name     = "Loricate Torque +1",
                    augments = {'Path: A',}},
    waist       = "Plat. Mog. Belt",
    left_ear    = { name     = "Moonshade Earring",
                    augments = {'MP+25','Latent effect: "Refresh"+1',}},
    right_ear   = "Infused Earring",
    left_ring   = "Stikini Ring +1",
    right_ring  = "Defending Ring",
    back        = "Solemnity Cape",
}

sets.idle.RefreshLatent = {
    waist       = "Fucho-no-Obi",
}

sets.idle.Sublimation = {
    head        = gear.ArtefactHead,
    body        = gear.RelicBody,
    waist       = "Embla Sash",
    right_ear   = "Savant's Earring",
}

sets.idle.ToAU = {
    right_ring  = "Balrahn's Ring"
}

sets.idle.Town = {
    main = "Daybreak",
    sub = "Culminus",
    head = gear.ArtefactHead,
    body = gear.ArtefactBody,
    hands = gear.ArtefactHands,
    legs = gear.ArtefactLegs,
    feet = gear.ArtefactFeet,
    neck = "Incanter's Torque",
    left_ear = "Moonshade Earring",
    right_ear = gear.EmpyreanRightEar,
    left_ring = "Stikini Ring +1",
    right_ring = "Janniston Ring +1",
    back = "Aurist's Cape +1",
    waist = "Hachirin-no-Obi",
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
    left_ear    = { name     = "Moonshade Earring",
                    augments = {'MP+25','Latent effect: "Refresh"+1',}},
    right_ear   = "Infused Earring",
    left_ring   = "Stikini Ring +1",
    right_ring  = "Angha Ring",
    back        = "Felicitas Cape",
}


--  ----------------------------------------------------------------------------------------------------
--   Engaged Sets
--  ----------------------------------------------------------------------------------------------------

--  ----------------------------------------------------------------------------------------------------
--   Precast Sets
--  ----------------------------------------------------------------------------------------------------
sets.precast = {}
sets.precast.FC = {
    main        = { name     = "Mpaca's Staff",
                    augments = {'Path: A',}},
    sub         = "Clerisy Strap",
    ammo        = "Incantor Stone",
    head        = gear.ArtefactHead,
    body        = "Merlinic Jubbah",
    hands       = gear.ArtefactHands,
    legs        = { name     = "Kaykaus Tights",
                    augments = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
    feet        = gear.RelicFeet,
    neck        = "Baetyl Pendant",
    waist       = "Embla Sash",
    left_ear    = "Malignance Earring",
    right_ear   = "Etiolation Earring",
    left_ring   = "Medada's Ring",
    right_ring  = "Kishar Ring",
    back        = "Perimede Cape",
}

sets.precast.FC.SixStepSc = set_combine(sets.precast.FC, {
    main = "Twinned Blade",
    sub="Genmei Shield",
    right_ear = "Loquacious Earring",
    back = "Solemnity Cape"
})

sets.precast["Healing Magic"] = set_combine(sets.precast.FC, {
    main        = "Vadose",
    sub         = "Calmius",
    back        = "Disperser's Cape"
})

sets.precast["Cure"] = set_combine(sets.precast.FC, {
    main        = "Vadose Rod",
    sub         = "Sors Shield",
    head        = { name     = "Vanya Hood",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = "Heka's Kalasiris",
    legs        = "Doyen Pants",
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    right_ear   = "Mendi. Earring",
    back        = "Pahtli Cape",
})
sets.precast["Curaga"] = sets.precast["Cure"]

sets.precast["Enhancing Magic"] = set_combine(sets.precast.FC, {
    waist = "Siegel Sash",
})

sets.precast["Stoneskin"] = set_combine(sets.precast["Enhancing Magic"], {
    head        = "Umuthi Hat",
    hands       = "Carapacho Cuffs",
})

sets.precast["Enfeebling Magic"] = set_combine(sets.precast.FC, {})
sets.precast["Elemental Magic"]  = set_combine(sets.precast.FC, {})
sets.precast["Dark Magic"]       = set_combine(sets.precast.FC, {})

sets.precast["Trust"] = {
    main        = { name     = "Mpaca's Staff",
                    augments = {'Path: A',}},
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
    main        = "Bolelabunga",
    sub         = "Ammurapi Shield",
    ammo        = "Savant's Treatise",
    head        = "Befouled Crown",
    body        = gear.RelicHead,    --  Enh. Mag. eff. dur. +8%
    hands       = { name     = "Telchine Gloves",
                    augments = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
    legs        = { name     = "Telchine Braconi",
                    augments = {'Enh. Mag. eff. dur. +9',}},
    feet        = { name     = "Telchine Pigaches",
                    augments = {'Enh. Mag. eff. dur. +6',}},
    neck        = "Colossus's Torque",
    waist       = "Olympus Sash",
    left_ear    = "Augment. Earring",
    right_ear   = "Andoaa Earring",
    left_ring   = "Stikini Ring +1",
    right_ring  = "Stikini Ring",
    back        = "Fi Follet Cape",
}

sets.midcast["Barspell"] = set_combine(sets.midcast["Enhancing Magic"], {
    hands       = { name     = "Chironic Gloves",
                    augments = {'AGI+4','Crit.hit rate+1','"Refresh"+1','Accuracy+1 Attack+1',}},
    legs        = "Shedir Seraweels",
    feet        = { name     = "Kaykaus Boots",
                    augments = {'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
})

sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
    legs        = "Haven Hose",
    neck        = "Nodens Gorget",
    waist       = "Siegel Sash",
    left_ear    = "Earthcry Earring",
})

sets.midcast["Regen"] = set_combine(sets.midcast["Enhancing Magic"], {
    main        = { name     = "Coeus",
                    augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
    sub         = "Fulcio Grip",
    head        = gear.EmpyreanHead,
    legs        = { name     = "Telchine Braconi",
                    augments = {'"Regen" potency+3',}},
    back        = gear.AmbuscadeCapeMAB

})

sets.midcast["Aquaveil"] = set_combine(sets.midcast["Enhancing Magic"], {
    main        = "Vadose Rod",
    sub         = "Genbu's Shield",
})

sets.midcast["Healing Magic"] = {
    main        = { name     = "Coeus",
                    augments = {'Mag. Acc.+50','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
    sub         = "Clerisy Strap",
    ammo        = "Incantor Stone",
    head        = { name     = "Vanya Hood",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = gear.RelicBody,
    hands       = gear.RelicHands,
    legs        = gear.ArtefactLegs,
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
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
    neck        = "Debilis Medallion",
    left_ring   = "Haoma's Ring",
    right_ring  = "Haoma's Ring",
    back        = "Oretan. Cape +1",
})

sets.midcast.Cure = {
    main        = "Daybreak",
    sub         = "Ammurapi Shield",
    ammo        = "Quartz Tathlum +1",
    head        = { name     = "Vanya Hood",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body        = { name     = "Kaykaus Bliaut",
                    augments = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
    hands       = gear.RelicHands,
    legs        = gear.ArtefactLegs,
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
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
    body        = { name     = "Kaykaus Bliaut",
                    augments = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
    hands       = gear.RelicHands,
    legs        = gear.ArtefactLegs,
    feet        = { name     = "Vanya Clogs",
                    augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
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
    back        = "Aurist's Cape",
}

sets.midcast["Elemental Magic"] = {
    main        = { name     = "Akademos",
                    augments = {'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
    sub         = "Enki Strap",
    ammo        = "Hydrocera",
    head        = gear.RelicHead,
    body        = gear.RelicBody,
    hands       = gear.RelicHands,
    legs        = gear.RelicLegs,
    feet        = gear.RelicFeet,
    neck        = "Baetyl Pendant",
    waist       = "Aswang Sash",
    left_ear    = "Barkarole Earring",
    right_ear   = gear.EmpyreanRightEar,
    left_ring   = "Medada's Ring",
    right_ring  = "Freke Ring",
    back        = gear.AmbuscadeCapeMAB,
}

sets.midcast["Helix"] = set_combine(sets.midcast["Elemental Magic"], {
    neck=gear.DynamisNeck,
    -- back=""
})

sets.midcast.MagicBurst = set_combine(sets.midcast["Elemental Magic"], {
    body        = gear.ArtefactBody,
    feet        = "Jhakri Pigaches +2",
    neck        = gear.DynamisNeck,
    right_ring  = "Jhakri Ring",
})

sets.midcast["Dark Magic"] = set_combine(sets.midcast["Elemental Magic"], {
    main        = { name     = "Rubicundity",
                    augments = {'Mag. Acc.+3','"Mag.Atk.Bns."+3','Dark magic skill +5','"Conserve MP"+2',}},
    sub         = "",
    neck        = "Erra Pendant",
    left_ring   = "Evanescence Ring",
})

sets.midcast["Drain"] = set_combine(sets.midcast["Dark Magic"], {
    head        = "Appetence Crown",
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
