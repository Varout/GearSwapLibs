-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- Local Settings, setting the zones prior to use
abilityCancel = S{
    "Addendum: White",
}

abilityNothing = S{
    "Light Arts",
    "Dark Arts",
    "Afflatus Misery",
    "Afflatus Solace",
    "Accession",
    "Penury",
    "Celerity",
    "Sublimation",
    "Asylum",
    "Sacrosanctity",
    "Martyr",
    "Divine Caress",
    "Divine Seal",
    "Addendum: Black",
}

--  Used to lock in rings
special_ring_equipped = false

--  Used to lock in melee equipment
melee_jobs = S{
    'WAR',
    'SAM',
    'NIN',
    'DNC',
    'THF',
    'PLD',
    'MNK',
    'DRK',
}

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('common_lists.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Light Arts']      = buffactive['Light Arts']      or false
    state.Buff['Weakness']        = buffactive['Weakness']        or false

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    state.DynamisMode   = M(false, 'Dynamis Mode')
    state.CPMode        = M(false, 'CP Mode')
    -- state.MeleeMode     = M(false, 'Melee Mode')

    send_command('bind @c gs c toggle CP Mode')
    send_command('bind @x gs c toggle Dynamis Mode')
    -- send_command('bind @z gs c toggle Melee Mode')

    add_to_chat(104, 'Windows Key + C: Toggle CP Mode')
    add_to_chat(104, 'Windows Key + x: Dynamis Neck Piece Lock')
    -- add_to_chat(104, 'Windows Key + z: Melee Mode')

    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    -- send_command('unbind @z')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --  Bind Specific Sets
    sets.Dynamis = { neck = "Cleric's Torque" }
    sets.CP      = { back = "Mecistopins Mantle" }

    --  Timing/Area Specific Sets
    sets.WeatherBoost = {
        waist = "Hachirin-no-Obi",
        back  = "Twilight Mantle",
    }
    sets.WSBoost = {
        neck  = "",
        waist = "Fotia Belt",
    }

    --  Idle Sets
    sets.Idle =
    {
        main    = "Bolelabunga",
        sub     = "Ammurapi Shield",
        ammo    = "Homiliary",
        head    = "Inyanga Tiara +2",
        neck    = "Loricate Torque +1",
        ear1    = "Infused Earring",
        ear2    = "Moonshade Earring",
        body    = "Theophany Briault +3",
        hands   = "Inyanga Dastanas +2",
        ring1   = "Defending Ring",
        ring2   = "Inyanga Ring",
        back    = { name        = "Alaunus's Cape",
                    augments    = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
        waist   = "Fucho-no-obi",
        legs    = "Inyanga Shalwar +2",
        feet    = "Inyanga Crackows +2"
    }
    sets.IdleToAU = { ring1 = "Balrahn's Ring" }

    sets.Resting =
    {
        main    = "Boonwell Staff",      -- +18
        sub     = "Ariesian Grip",       -- +1
        ammo    = "Mana Ampulla",        -- +2
        head    = "Orvail Corona +1",    -- +4
        neck    = "Eidolon Pendant +1",  -- +6
        ear1    = "Glorious Earring",    -- +0
        ear2    = "Moonshade Earring",   -- +0
        body    = "Chelona Blazer",      -- +8   (Nice to have +1)
        hands   = "Nares Cuffs",         -- +4
        ring1   = "Star Ring",           -- +1
        ring2   = "Angha Ring",          -- +2
        back    = "Felicitas Cape",      -- +3
        waist   = "Austerity Belt",      -- +4
        legs    = "Nisse Slacks",        -- +4
        feet    = "Chelona Boots"        -- +5   (Nice to have +1)
    }
    sets.LatentRefresh   = { waist = "Fucho-no-obi" }

    --  JA Specific Sets
    sets.JA.Devotion     = { head  = "Piety Cap +3" }
    sets.JA.Benediction  = { body  = "Piety Briault +3" }
    sets.JA.Martyr       = { hands = "Piety Mitts +3" }
    sets.JA.DivineCaress =
    {
        hands = "Ebers Pantaloons +1",
        back = "Mending Cape"
    }

    sets.Trust =
    {
        main    = "Bolelabunga",
        sub     = "Ammurapi Shield",
        ranged  = "",
        ammo    = "Homiliary",
        head    = "Inyanga Tiara +2",
        body    = "INyanga Jubbah +2",
        hands   = "Inyanga Dastanas +2",
        legs    = "Inyanga Shalwar +2",
        feet    = "Inyanga Crackows +2"
    }


    -- Precast Sets
    --  Total fast cast for this set is 63%.  Not sure what the cap is.
    sets.Precast = {}

    sets.Precast.FastCast =
    {
        main    = "Grioavolr",                          -- FC +04%
        sub     = "Clerisy Strap",                      -- FC +02%
        ammo    = "Incantor Stone",                     -- FC +02%
        head    = "Revealer's Crown",                   -- FC +05%
        neck    = "Cleric's Torque",                    -- FC +06%
        ear1    = "Loquac. Earring",                    -- FC +02%
        ear2    = "Infused Earring",                    -- Regen +1, Evasion +10
        body    = "Inyanga Jubbah +2",                  -- FC +14%
        hands   = "Fanatic Gloves",                     -- FC +07%
        ring1   = "Evanescence Ring",                   -- Spell Interruption down 05%
        ring2   = "Kishar Ring",                        -- FC +04%
        back    = { name        = "Alaunus's Cape",     -- FC +10%, Spell Interruption down 10%
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist   = "Witful Belt",                        -- FC +03%, Quickcast +3%
        legs    = { name="Kaykaus Tights",              -- FC +06%, Spell Interruption down 10%
                    augments    = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet    = "Regal Pumps +1"                      -- FC +04% - +06%       (Nice to have +1)
    }

    sets.Precast.Enhancing = set_combine(sets.Precast.FastCast,
    {
        head    = "Umuthi Hat",
        waist   = "Siegel Sash"
    })

    sets.Precast.Stoneskin = set_combine(sets.Precast.Enhancing,
    {
        head    = "Umuthi Hat",              --  Stoneskin Cast Time -15%
        hands   = "Carapacho Cuffs"          --  Stoneskin Cast Time -15%
    })

    sets.Precast.Aquaveil   = set_combine(sets.Precast.Enhancing, {})
    sets.Precast.Barspell   = set_combine(sets.Precast.Enhancing, {})
    sets.Precast.Regen      = set_combine(sets.Precast.Enhancing, {})

    sets.Precast.NASpell = set_combine(sets.Precast.FastCast,
    {
        legs    = "Ebers Pantaloons +1"      --  Healing Magic Cast Time -13%
    })
    sets.Precast.Cursna     = set_combine(sets.Precast.NASpell, {})

    sets.Precast.Cure = set_combine(sets.Precast.FastCast,
    {
        main    = "Ababinili +1",            --  Cure Cast Time -11%
        sub     = "Clerisy Strap",           --  FC +02%
        head    = "Piety Cap +3",            --  Cure Cast Time -15%, Haste +6%
        ear1    = "Nourishing Earring +1",   --  Cure Cast Time -4%
        ear2    = "Mendicant's Earring",     --  Cure Cast Time -5%, Conserve MP +3
        body    = "Heka's Kalasiris",        --  Cure Cast Time -15%
        feet    = "Hygieia Clogs +1"         --  Cure Cast Time -18%, Haste +3%, Conserve MP +5
    })
    sets.Precast.Curaga     = set_combine(sets.Precast.Cure, {})

    sets.Precast.Enfeebling = set_combine(sets.Precast.Fastcast, {})

    sets.Precast.Divine     = set_combine(sets.Precast.Fastcast, {})
    sets.Precast.Banish     = set_combine(sets.Precast.Divine, {})

    -- Midcast Sets
    sets.Midcast            = {}
    sets.Midcast.Fastcast   = {}

    sets.Midcast.Enhancing =
    {
        main    = "Beneficus",                  --  Enhancing Maigc +15
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        ammo    = "Hydrocera",                  --  Enhancing Maigc +0
        head    = "Befouled Crown",             --  Enhancing Maigc +16
        neck    = "Colossus's Torque",          --  Enhancing Maigc +7
        ear1    = "Augmenting Earring",         --  Enhancing Maigc +3
        ear2    = "Andoaa Earring",             --  Enhancing Maigc +5
        body    = "Anhur Robe",                 --  Enhancing Maigc +12
        hands   = "Inyanga Dastanas +2",        --  Enhancing Maigc +20
        ring1   = "Stikini Ring",               --  All magic +5
        ring2   = "Stikini Ring",               --  All magic +5
        back    = "Fi Follet Cape",             --  Enhancing Maigc +8
        waist   = "Olympus Sash",               --  Enhancing Maigc +5
        legs    = "Piety Pantaloons +3",        --  Enhancing Maigc +26
        feet    = "Theophany Duckbills +3"      --  Enhancing Magic +21, Enhancing Magic Duration +10%
    }
    sets.Midcast.EnhancingDuration = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Beneficus",                  --  Enhancing Maigc +15
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        hands   = { name        = "Telchine Gloves",
                    augments    = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        feet    = "Theophany Duckbills +3",     --  Enhancing Magic +21, Enhancing Magic Duration +10%
    })
    sets.Midcast.Stoneskin = set_combine(sets.Midcast.Enhancing,
    {
        neck    = "Nodens Gorget",              --  Stoneskin +30
        ear1    = "Earthcry Earring",           --  Stoneskin +10
        waist   = "Siegel Sash",                --  Stoneskin +20
        legs    = "Haven Hose"                  --  Stoneskin +20
        -- legs    = "Shedir Seraweels"         --  Stoneskin +35
    })
    sets.Midcast.Aquaveil = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Vadose Rod"                  --  Aquaveil +1
        -- legs    = "Shedir Seraweels"         --  Enhances Aquaveil
    })
    sets.Midcast.Barspell = set_combine(sets.Midcast.Enhancing,
    {
        head    = "Ebers Cap +1",               --  Set: Occationally negates damage with correct barpsell
        body    = "Ebers Bliaud +1",            --  Set: Occationally negates damage with correct barpsell
        hands   = "Ebers Mitts +1",             --  Set: Occationally negates damage with correct barpsell
        legs    = "Piety Pantaloons +3",        --  Barspell +36
        feet    = "Ebers Duckbills +1"          --  Set: Occationally negates damage with correct barpsell
    })
    --  Regen Potency/Duration set
    --  +46 Duration
    --  +76% Potency from gear
    sets.Midcast.Regen = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Bolelabunga",                --  Regen Potency +10%
        head    = "Inyanga Tiara +2",           --  Regen Potency +14%
        body    = "Piety Briault +3",           --  Regen Potency +52%
        hands   = "Ebers Mitts +1",             --  Regen Duration +22
        legs    = "Theophany Pantaloons +3"     --  Regen Duration +24
    })
    sets.Midcast.ProShell   = { ring1 = "Sheltered Ring" }
    sets.Midcast.Erase = set_combine(sets.Midcast.Enhancing,
    {
        main    = "Yagrush",
        sub     = "Ammurapi Shield",            --  Enhancing magic duration +10%
        neck    = "Cleric's Torque"             --  Erase +1        (Nice to have +1 or 2)
    })
    sets.Midcast.Auspice    = { hands = "Dynasty Mitts", feet = "Orison Duckbills +2" }

    sets.Midcast.Caress = set_combine(sets.Midcast.NASpell,
    {
        hands="Ebers Mitts +1"              --  Divine Caress +1
    })
    sets.Midcast.NASpell =
    {
        main    = "Yagrush",                --  AoE Status Removal
        sub     = "Sors Shield",            --  Nothing special, just some extra defense and evasion
        ammo    = "Incantor Stone",         --  Healing Magic +00
        head    = "Ebers Cap +1",           --  Healing Magic +00, Divine Veil +22%
        neck    = "Colossus's Torque",      --  Healing Magic +07 (Lightsday +10.  There is a torque which gives +10 to all magic skills)
        ear1    = "Beatific Earring",       --  Healing Magic +04
        ear2    = "Healing Earring",        --  Healing Magic +03
        body    = "Ebers Bliaud +1",        --  Healing Magic +24
        hands   = "Theophany Mitts +3",     --  Healing Magic +21
        ring1   = "Sirona's Ring",          --  Healing Magic +10
        ring2   = "Menelaus's Ring",        --  Cure +5%, Healing Magic +15, Cursna +20
        back    = "Altruistic Cape",        --  Healing Magic +05
        waist   = "Bishop's Sash",          --  Healing Magic +05
        legs    = "Ebers Pantaloons +1",    --  Healing Magic +00, Divine Benison +2
        feet    = { name        = "Vanya Clogs",        --  Healing Magic +40, Cursna +5
                    augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    }
    --  Slot missing: Main - Gambanteinn i119 III: Cursna +100
    --  Totals:
    --  ** Healing Magic    620
    --  ** Cursna          +116
    sets.Midcast.Cursna = set_combine(sets.Midcast.NASpell,
    {
        -- main="Gambanteinn",                          --  Cursna +100 (Very very nice to have.  Goals.  But would I really use this in place of a Yagrush?)
        head    = "Vanya Hood",                         --  Healing Magic +20, Cursna +0
        neck    = "Debilis Medallion",                  --  Healing Magic +00, Cursna +15
        hands   = "Fanatic Gloves",                     --  Healing Magic +10, Cursna +15
        ring1   = "Haoma's Ring",                       --  Healing Magic +08, Cursna +15
        ring2   = "Menelaus's Ring",                    --  Healing Magic +15, Cursna +20
        back    = { name        = "Alaunus's Cape",     --  Healing Magic +00, Cursna +25
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        legs    = "Theophany Pantaloons +3",            --  Healing Magic +00, Cursna +21
        feet    = { name        = "Vanya Clogs",        --  Healing Magic +40, Cursna +5
                    augments    = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}        -- Gendewitha Galoshes +1: +10 Cursna.  Not sure if it'll be better than what I already have
    })

    sets.Midcast.Cure =
    {
        main    = "Queller Rod",                             --  Cure +10%, Cure Pot. II +2%, Healing Magic +15, MND +6, Enmity -10
        sub     = "Sors Shield",                             --  Cure +3%, Cure Cast Time -5%, Enmity -5
        ammo    = "Quartz Tathlum +1",                       --  MND +4
        head    = "Vanya Hood",                              --  Cure +10%, Healing Magic +20, MND +27, Haste +6%
        neck    = "Colossus's Torque",                       --  Healing Magic +7 (Lightsday +10.  There is a torque which gives +10 to all magic skills)
        ear1    = "Glorious Earring",                        --  Cure Pot. II +2%, MP +30, Enmity -5
        ear2    = "Mendicant's Earring",                     --  Cure +5%, Conserve MP +2
        -- body    = "Ebers Bliaud +1",                      --  Allfatus Solace +14
        body    = "Theophany Briault +3",                    --  Cure Pot. II +6%, MND +39, Haste +3%, Enmity -6
        hands   = "Theophany Mitts +3",                      --  Cure Pot. II +4%, Healing Magic +21, MND +48, Haste +3%, Enmity -7
        ring1   = "Janniston Ring",                          --  Cure Pot. II +5%, Enmity -7                        (Nice to have +1)
        ring2   = "Menelaus's Ring",                         --  Cure +5%, Healing Magic +15, Cursna +20
        back    = { name        = "Alaunus's Cape",          --  Cure +10%, MND +30
                    augments    = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
        waist   = "Bishop's Sash",                           --  Healing Magic +5
        legs    = "Ebers Pantaloons +1",                     --  MND +33, Haste +5%, Convert 6% Cure HP to MP
        feet    = { name        = "Vanya Clogs",             --  Path A Augment: Cure +12%, Healing Magic +20, MND +19, Haste +3%, Enmity -6
                    augments    = {'MP+50','"Cure" potency +7%','Enmity-6',}}
    }
    sets.Midcast.CureSolace = set_combine(sets.Midcast.Cure, {})
    sets.Midcast.CureBonus =
    {
        main        = { name        = "Queller Rod",
                        augments    = {'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
        sub         = "Sors Shield",
        ammo        = "Quartz Tathlum +1",
        head        = "Ebers Cap +1",
        body        = "Theo. Briault +3",
        hands       = "Theophany Mitts +3",
        legs        = "Ebers Pantaloons +1",
        feet        = { name        = "Kaykaus Boots",
                        augments    = {'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
        neck        = "Cleric's Torque",
        waist       = "Hachirin-no-Obi",
        left_ear    = "Glorious Earring",
        right_ear   = "Mendi. Earring",
        left_ring   = "Janniston Ring",
        right_ring  = "Menelaus's Ring",
        back        = "Twilight Cape",
    }
    sets.Midcast.Curaga     = set_combine(sets.Midcast.Cure, {})
    sets.Midcast.CureMelee  = set_combine(sets.Midcast.Cure, {})

    sets.Midcast.MagicAcc =
    {
        main    = "Blurred Staff",                          --  +20 Magic Accuracy, +228 Magic Accuracy Skill
        sub     = "Enki Strap",                             --  +10 Magic Accuracy
        ammo    = "Hydrocera",                              --  +06 Magic Accuracy
        head    = "Inyanga Tiara +2",                       --  +44 Magic Accuracy
        neck    = "Erra Pendant",                           --  +17 Magic Accuracy
        -- neck    = "Incanter's Torque",                   --  +10 All magic (Synergy from 10 Escha - Ru'Aun NM drops)
        ear1    = "Psystorm Earring",                       --  +12 Magic Accuracy: Set
        ear2    = "Lifestorm Earring",                      --  +12 Magic Accuracy: Set
        body    = "Inyanga Jubbah +2",                      --  +46 Magic Accuracy
        hands   = "Inyanga Dastanas +2",                    --  +43 Magic Accuracy, +20 All magic
        ring1   = "Stikini Ring",                           --  +08 Magic Accuracy, +05 All magic
        ring2   = "Stikini Ring",                           --  +08 Magic Accuracy, +05 All magic
        back    = { name        = "Alaunus's Cape",         --  +20 Magic Accuracy
                    augments    = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist   = "Aswang Sash",                            --  +03 Magic Accuracy
        legs    = "Inyanga Shalwar +2",                     --  +45 Magic Accuracy
        feet    = "Piety Duckbills +3"                      --  +36 Magic Accuracy
    }
    sets.Midcast.Enfeebling = set_combine(sets.Midcast.MagicAcc,
    {
        body    = "Theophany Briault +3",
        ring2   = "Kishar Ring",
        waist   = "Casso Sash",
        legs    = { name        = "Chironic Hose",
                    augments    = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })
    sets.Midcast.EnfeeblingMND = set_combine(sets.Midcast.Enfeebling, {})
    sets.Midcast.EnfeeblingINT = sets.Midcast.Enfeebling

    sets.Midcast.Divine = set_combine(sets.Midcast.MagicAcc,
    {
        hands   = "Piety Mitts +3",
        waist   = "Bishop's Sash",
        legs    = "Theophany Pantaloons +3"
    })
    sets.Midcast.Banish = set_combine(sets.Midcast.Divine,
    {
        neck    = "Sanctity Necklace",          --  +10 Magic Accuracy, +10 Magic Attack Bonus
        ear1    = "Dignitary's Earring",        --  +10 Magic Accuracy
        ear2    = "Hecate's Earring",           --  +06 Magic Attack Bonus, +3% Magic Crit. Hit
        back    = "Disperser's Cape",           --  Potency of Banish vs. Undead +7
        waist   = "Aswang Sash",                --  +03 Magic Attack Bonus
        legs    = { name        = "Chironic Hose",
                    augments    = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })

    sets.Midcast.DarkMagic = set_combine(sets.Midcast.MagicAcc, {})

    -- Misc sets

    -- sets.idle.PDT = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
    --     head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
    --     back="Umbra Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Herald's Gaiters"}

    -- sets.idle.Town = {main="Bolelabunga", sub="Genbu's Shield",ammo="Incantor Stone",
    --     head="Gendewitha Caubeen",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --     back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}

    -- sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Incantor Stone",
    --     head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
    --     back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Gendewitha Galoshes"}

    -- Defense sets

    -- sets.defense.PDT = {main=gear.Staff.PDT,sub="Achaq Grip",
    --     head="Gendewitha Caubeen",neck="Twilight Torque",
    --     body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
    --     back="Umbra Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    -- sets.defense.MDT = {main=gear.Staff.PDT,sub="Achaq Grip",
    --     head="Nahtirah Hat",neck="Twilight Torque",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
    --     back="Tuilha Cape",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    -- sets.Kiting = {feet="Herald's Gaiters"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    -- sets.engaged = {
    --     head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --     body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
    --     back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    -- gear.default.weaponskill_neck = "Asperity Necklace"
    -- gear.default.weaponskill_waist = ""
    -- sets.precast.WS = {
    --     head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
    --     back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}

    -- sets.precast.WS['Flash Nova'] = {
    --     head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
    --     back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.usemidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --  Cancel spell and try removing it with echo drops first, then remedy if no echo drops available
    if spell.action_type == 'Magic' and buffactive['Silence'] then
        cancel_spell()
        if player.inventory['Echo Drops'] ~= nil then
            send_command('input /item "Echo Drops" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Echo Drops'].count..' Left !!*')
        elseif player.inventory['Remedy'] ~= nil then
            send_command('input /item "Remedy" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Remedy'].count..' Left !!*')
        end
    end

    -- No gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        eventArgs.handled = true
    end

end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    -- if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
    if  naSpellsNoCursna:contains(spell) and buffactive['Divine Caress'] then
        equip(sets.JA.DivineCaress)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
-- function job_state_change(stateField, newValue, oldValue)
--     if stateField == 'Offense Mode' then
--         if newValue == 'Normal' then
--             disable('main','sub','range')
--         else
--             enable('main','sub','range')
--         end
--     end
-- end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    --  Initialise set
    idleSet = {}

    --  Latent MP refres equip
    --  If below 51% MP, equip Fucho-no-obi if it isn't already set as idle piece
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    --  Treasures Of Aht Urhgan area check
    --  If in a specified area, equip refresh ring for idle set
    if toau_zones:contains(world.zone) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  CP Mode Toggle
    --  Lock in back piece for bonus CP
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    --  Dynamis Mode Toggle
    --  Lock in neck piece for kill counts
    if state.DynamisMode.current == 'on' then
        equip(sets.Dynamis)
        disable('neck')
    else
        enable('neck')
    end

    --  Melee Mode Toggle
    --  Locking weapon slots so that TP isn't lost when casting
    if state.MeleeMode.current == 'on' then
        disable('main')
        disable('sub')
    else
        enable('main')
        enable('sub')
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts =
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']

        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end

--  Locks the correct ring slot if a listed ring is equipped
--  Unlocks the slot if the ring is no longer detected
function check_special_ring_equipped()
    if exp_rings:contains(player.equipment.ring1) then
        windower.add_to_chat(9, "Ring1 locked")
        special_ring_equipped = true
        disable("ring1")
    elseif exp_rings:contains(player.equipment.ring2) then
        windower.add_to_chat(9, "Ring2 locked")
        special_ring_equipped = true
        disable("ring2")
    elseif special_ring_equipped then
        windower.add_to_chat(9, "Unlocking rings")
        special_ring_equipped = false
        enable('ring1')
        enable('ring2')
    end
end

--  Check if the spell element matches the current day, weather, or SCH storm
--  @param  String: The string of the spell element to check
function get_weather_day_match(element)
    isMatchWeather = world.weather_element == element
    isMatchDay = world.day_element == element

    -- windower.add_to_chat(3, string.format("Weather Match: " .. "%s", tostring(isMatchWeather)))
    -- windower.add_to_chat(3, string.format("Day Match: " .. "%s", tostring(isMatchDay)))
    if (isMatchDay or isMatchWeather) then
        windower.add_to_chat(10, "Weather or Day Match")
    else
        windower.add_to_chat(10, "No Weather or Day Match")
    end

    return (isMatchDay or isMatchWeather)
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function sub_job_change(new, old)
    if melee_sub_jobs:contains(player.sub_job) then
        disable('main')
        disable('sub')
        disable('ranged')
        disable('ammo')
    else
        enable('main')
        enable('sub')
        enable('ranged')
        enable('ammo')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 4)
end

function set_lockstyle()

end