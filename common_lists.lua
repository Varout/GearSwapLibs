-------------------------------------------------------------------------------------------------------------------
--  Zones For Special Equipment Effects
-------------------------------------------------------------------------------------------------------------------
--  Used for ToAU ring in assault or salvage areas
zones_toau_ring = S{
    "Leujaoam Sanctum",             --  Assault
    "Mamool Ja Training Grounds",   --  Assault
    "Lebros Cavern",                --  Assault
    "Periqia",                      --  Assault
    "Ilrusi Atoll",                 --  Assault
    "Nyzul Isle",                   --  Assault
    "Bhaflau Remnants",             --  Salvage
    "Arrapago Remnants",            --  Salvage
    "Silver Sea Remnants",          --  Salvage
    "Zhayolm Remnants",             --  Salvage
}

--  Used for SoA body movement speed
zones_adoulin_body = S{
    "Western Adoulin",
    "Eastern Adoulin",
    "Mog Garden",
}

zones_sandy_body = S{
    "Southern San d'Oria",
    "Northern San d'Oria",
    "Port San d'Oria",
    "Chateau d'Oraguille",
}

zones_bastok_body = S{
    "Bastok Mines",
    "Bastok Markets",
    "Port Bastok",
    "Metalworks",
}

zones_windy_body = S{
    "Windurst Walls",
    "Windurst Waters",
    "Windurst Woods",
    "Port Windurst",
    "Heavens Tower",
}

non_combat_zones = S{}

-------------------------------------------------------------------------------------------------------------------
--  Spell Sets
-------------------------------------------------------------------------------------------------------------------
spells_resistance = S{
    "Barstone",     "Barstonra",
    "Barwater",     "Barwatera",
    "Barareo",      "Baraera",
    "Barfire",      "Barfira",
    "Barblizzard",  "Barblizzara",
    "Barthunder",   "Barthundra",
    "Barsleep",     "Barsleepra",   --  Base: Light
    "Barpoison",    "Barpoisonra",  --  Base: Water
    "Barparalyze",  "Barparalyzra", --  Base: Blizzard
    "Barblind",     "Barblindra",   --  Base: Light
    "Barsilence",   "Barsilencera", --  Base: Aero
    "Barpetrify",   "Barpetra",     --  Base: Stone
    "Barvirus",     "Barvira",      --  Base: Fire
    "Baramnesra",                   --  Base: Fire
}

spells_barElement = S{
    "Barstone",     "Barstonra",
    "Barwater",     "Barwatera",
    "Barareo",      "Baraera",
    "Barfire",      "Barfira",
    "Barblizzard",  "Barblizzara",
    "Barthunder",   "Barthundra",
}

spells_barAilment = S{
    "Barsleep",     "Barsleepra",   --  Base: Light
    "Barpoison",    "Barpoisonra",  --  Base: Water
    "Barparalyze",  "Barparalyzra", --  Base: Blizzard
    "Barblind",     "Barblindra",   --  Base: Light
    "Barsilence",   "Barsilencera", --  Base: Aero
    "Barpetrify",   "Barpetra",     --  Base: Stone
    "Barvirus",     "Barvira",      --  Base: Fire
    "Baramnesra",                   --  Base: Fire
}

spells_na = S{
    "Poisona",
    "Paralyna",
    "Blindna",
    "Silena",
    "Stona",
    "Viruna",
    "Cursna",
}

spells_cursna = S{
    "Cursna",
}

spells_cure = S{
    'Cure', 'Curaga', 'Cura'
}

enfeebling_int = S{
    "Bind",
    "Blind",    -- "Blind II"
    "Break",
    "Dispel",
    "Distract", -- "Distract II", "Distract III"
    "Frazzle",  -- "Frazzle II", "Frazzle III"
    "Gravity",  -- "Gravity II"
    "Poison",   -- "Poison II"
    "Poisonga",
    "Sleep",    -- "SLeep II"
    "Sleepga",  -- "Sleepga II"
}

enfeebling_mnd = S{
    "Addle",    -- Addle II
    "Dia",      -- "Dia II", "Dia III"
    "Diaga",
    "Inundation",
    "Paralyze", -- "Paralyze II"
    "Silence",
    "Slow",     -- "Slow II"
}

enhancing_dark = S{
    "Blaze Spikes",
    "Ice Spikes",
    "Shock Spikes",
    "Dread Spikes",
    -- "Klimaform", -- ???
}


-------------------------------------------------------------------------------------------------------------------
--  Equipment Sets By Slot For Locking
-------------------------------------------------------------------------------------------------------------------
equip_lock_earrings = S{
    "Reraise Earring",
}

equip_lock_rings = S{
    "Emperor Ring",
    "Caliber Ring",
    "Echad Ring",
    "Capacity Ring",
    "Facility Ring",
    "Trizek Ring",
    "Endorsement Ring",
    "Warp Ring",
    "Dim. Ring (Holla)",
    "Dim. Ring (Mea)",
    "Dim. Ring (Dem)",
}

equip_lock_back = S{
    "Nexus Cape",
}

equip_lock_ammo_pouches = S{
    'Chrono Bullet Pouch',
    'Chr. Bul. Pouch'
}

sets.Capacity = {}
sets.Capacity['Varrout'] = { back = { name     = "Mecisto. Mantle",
                                      augments = {'Cap. Point+31%','INT+2','Attack+3','DEF+8',}},}
sets.Capacity['Manhoso'] = { back = { name     = "Mecisto. Manle",
                                      augments = {}},}

-------------------------------------------------------------------------------------------------------------------
--  Job Sets for Subjobs
-------------------------------------------------------------------------------------------------------------------
job_type_melee = S{
    "WAR",
    "MNK",
    "THF",
    "SAM",
    "NIN",
    "DNC",
    "PLD",
    "DRK",
    "DRG",
    "RUN",
    "RNG",
    "BST",
    "COR",
}

job_type_mage = S{
    "WHM",
    "RDM",
    "BLM",
    "BRD",
    "BLU",
    "SCH",
    "GEO",
    "SMN",
}

job_type_magic_user = S{
    "NIN",
    "PLD",
    "DRK",
    "RUN",
    "WHM",
    "RDM",
    "BLM",
    "BRD",
    "SCH",
    "GEO",
    "SMN"
}


-------------------------------------------------------------------------------------------------------------------
--  Healing Breath Sets for Subjobs
-------------------------------------------------------------------------------------------------------------------
HB_Mage_SubJob = S{"WHM","RDM","BLM","BLU","SCH"} -- 50% Healing Breath Trigger SubJob --
HB_DD_SubJob = S{"PLD","DRK","BRD","NIN"} -- 33% Healing Breath Trigger SubJob --
DRG_MP_SubJob = S{"WHM", "RDM", "BLM", "BLU", "SCH", "PLD", "DRK"}

wyv_breath_spells = S{'Dia', 'Poison', 'Sprout Smack', 'Head Butt', 'Cocoon'}
wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}


-------------------------------------------------------------------------------------------------------------------
--  Skillchain Names
-------------------------------------------------------------------------------------------------------------------
level_1_skillchains = S{}
level_2_skillchains = S{
    'distortion',       --  Blizard / Water
    'fragmentation',    --  Aero / Thunder
    'fusion',           --  Fire / Light
    'gravitation',      --  Dark / Stone
}
level_3_skillchains = S{
    'darkness',         --  Blizard / Dark / Stone / Water
    'light',            --  Aero / Fire / Light / Thunder
}
level_4_skillchains = S{
    'radiance',         --  Aero / Fire / Light / Thunder
    'umbra',            --  Blizard / Dark / Stone / Water
}

-------------------------------------------------------------------------------------------------------------------
--  Elemental Weaknesses
-------------------------------------------------------------------------------------------------------------------
weak_to_element = {
    ["Light"]    = "Darkness",
    ["Darkness"] = "Light",
    ["Earth"]    = "Wind",
    ["Water"]    = "Thunder",
    ["Wind"]     = "Ice",
    ["Fire"]     = "Water",
    ["Ice"]      = "Fire",
    ["Thunder"]  = "Earth"
}