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

spells_na = S{
    "Poisona",
    "Paralyna",
    "Blindna",
    "Silena",
    "Stona",
    "Viruna",
}

spells_cursna = S{
    "Cursna",
}

enfeebling_int = S{
    "Blind",    -- "Blind II",
    "Poison",   -- "Poison II",
    "Sleep",    -- "SLeep II", "Sleepga", "Sleepga II",
    "Break",
    "Bind",
    "Dispel",
    "Gravity",  -- "Gravity II",
    "Distract", -- "Distract II", "Distract III",
    "Frazzle",  -- "Frazzle II", "Frazzle III"
}

enfeebling_mnd = S{
    "Slow",     -- "Slow II",
    "Paralyze", -- "Paralyze II",
    "Dia",      -- "Dia II", "Dia III", "Diaga",
    "Silence",
    "Addle",    -- Addle II
    "Inundation",
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
    "Capacity  Ring",
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


-------------------------------------------------------------------------------------------------------------------
--  Job Sets for Subjobs (For my playstyle)
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