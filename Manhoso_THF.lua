--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include files.
    include('Mote-Include.lua')
    include('organizer-lib')
end


--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()
    include('Mote-TreasureHunter')
    --  Load common lua lists and functions
    include('common_lists.lua')
    include('common_functions.lua')

    state.Buff['Sneak Attack'] = buffactive['Sneak Attack'] or false
    state.Buff['Trick Attack'] = buffactive['Trick Attack'] or false
    state.Buff['Feint'] = buffactive['Feint'] or false
    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
    -- state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    -- state.UseRune = M(false, 'Use Rune')

    determine_haste_group()

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    --  Make sure all equipment can be changed/updated
    equipment_unlock_all()
end


--  ----------------------------------------------------------------------------------------------------
--  Information about custom commands
--  ----------------------------------------------------------------------------------------------------
function custom_instructions()
    add_to_chat(200, "Manhoso's THF Custom commands:")
    add_to_chat(200, "* Ctrl + =: Cycle Through TH Modes (Default: Tag)")

    if player.sub_job == 'DNC' then
        add_to_chat(200, "* Ctrl + , | Spectral Jig")
    end
end


--  ----------------------------------------------------------------------------------------------------
--  User and job setup
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.RangedMode:options('Normal')

    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

    if player.sub_job == 'DNC' then
        send_command('bind ^, input /ja "Spectral Jig" <me>')
    end

    custom_instructions()
    --  Which macro book to default to when changing jobs
    select_default_macro_book()
end


function user_unload()
    -- Local binds
    send_command('unbind ^=')
    send_command('unbind !-')

    send_command('unbind @f9')
    send_command('unbind ^[')
    send_command('unbind ![')

    send_command('unbind ^,')
end


function init_gear_sets()
    -- include('Manhoso_THF_GearSets.lua')
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.ArtefactHead  = "Pillager's Bonnet +2"
    gear.ArtefactBody  = "Pillager's Vest +2"
    gear.ArtefactHands = "Pillager's Armlets +2"
    gear.ArtefactLegs  = "Pillager's Culottes +2"
    gear.ArtefactFeet  = "Pillager's Poulains +2"

    gear.RelicHead  = "Plunderer's Bonnet +3"
    gear.RelicBody  = "Plunderer's Vest +1"
    gear.RelicHands = "Plunderer's Armlets +1"
    gear.RelicLegs  = "Plunderer's Culottes +1"
    gear.RelicFeet  = "Plunderer's Poulaines +1"

    --  Non-iLevel: Raiders
    gear.EmpyreanHead  = "Skulker's Bonnet +2"
    gear.EmpyreanBody  = "Skulker's Vest +2"
    gear.EmpyreanHands = "Skulker's Armlets +2"
    gear.EmpyreanLegs  = "Skulker's Culottes +2"
    gear.EmpyreanFeet  = "Skulker's Poulaines +2"

    gear.EmpyreanEarring = { name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}}
    gear.DynamisNeck     = ""

    gear.AdhemarHead  = { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.AdhemarBody  = { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.AdhemarHands = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.AdhemarLegs  = { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}

    gear.PursuerFeet = { name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}}

    gear.HercHead = {}
    gear.HercHead.WS = { name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}}

    gear.HercBody = {}
    gear.HercBody.Trip = { name="Herculean Vest", augments={'Accuracy+4','"Triple Atk."+4','AGI+3',}}

    gear.HercHands = {}
    gear.HercHands.WSMab = { name="Herculean Gloves", augments={'Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+11',}}

    gear.HercLegs = {}
    gear.HercLegs.WS    = { name="Herculean Trousers", augments={'Enmity-5','"Dbl.Atk."+3','Weapon skill damage +6%','Accuracy+10 Attack+10',}}
    gear.HercLegs.WSMab = { name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}}

    gear.HercFeet = {}
    gear.HercFeet.WS    = { name="Herculean Boots", augments={'Weapon skill damage +5%','AGI+8','Accuracy+6',}}
    gear.HercFeet.WSMab = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+24','Attack+16','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
    gear.HercFeet.Trip  = { name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}}

    gear.RawhideLegs = {}
    gear.RawhideLegs.FC = { name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}}

    gear.RawhideFeet = {}
    gear.RawhideFeet.WS = { name="Rawhide Boots", augments={'STR+10','Attack+15','"Store TP"+5',}}

    gear.ShantotoLegs = { name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}}

    gear.AmbuscadeCape = {}
    gear.AmbuscadeCape.StoreTP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
    gear.AmbuscadeCape.WSDDex  = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
    gear.AmbuscadeCape.WSStr   = { name="Toutatis's Cape", augments={'Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    sets.TreasureHunter = {
        ammo        = "Perfect Lucky Egg",
        hands       = gear.RelicHands,
        feet        = gear.EmpyreanFeet,
        waist       = "Chaac Belt",
    }

    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }

    sets.Organizer = {
        --grip="Pearlsack",
        --waist="Linkpearl",
    }

    --  Boost "Sneak Attack+", DEX
    sets.buff['Sneak Attack'] = {
        ammo        = "Voluspa Tathlum",            --  +5 DEX
        head        = gear.ArtefactHead,            --  +32 DEX, +4% Crit. Damage
        body        = "Meg. Cuirie +2",             --  +45 DEX, +6% Crit. Damage
        hands       = gear.EmpyreanHands,           --  +40 DEX, +25 "Sneak Attack"
        legs        = gear.ArtefactLegs,            --  +10 DEX, +4% Crit. Damage
        feet        = "Malignance Boots",           --  +40 DEX
        neck        = "Sanctity Necklace",
        waist       = "Chaac Belt",                 --  +5 DEX
        left_ear    = "Sherida Earring",            --  +5 DEX
        right_ear   = "Odr Earring",                --  +10 DEX
        left_ring   = "Ephramad's Ring",            --  +10 DEX
        right_ring  = "Ilabrat Ring",               --  +10 DEX
        back        = gear.AmbuscadeCape.StoreTP,   --  +30 DEX
    }

    --  Boost "Trick Attack+", AGI
    sets.buff['Trick Attack'] = {
        ammo        = "Voluspa Tathlum",
        head        = gear.ArtefactHead,            --  +32 AGI, +4% Crit. Damage
        body        = "Meg. Cuirie +2",             --  +41 AGI, +6% Crit. Damage
        hands       = gear.ArtefactHands,           --  +20 AGI, +18 "Trick Attack", +3% Crit. Damage
        legs        = gear.ArtefactLegs,            --  +25 AGI, +4% Crit. Damage
        feet        = "Mummu Gamash. +2",           --  +57 AGI
        neck        = "Sanctity Necklace",
        waist       = "Chaac Belt",                 --  +5 AGI
        left_ear    = "Sherida Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Ephramad's Ring",            --  +10 AGI
        right_ring  = "Ilabrat Ring",               --  +10 AGI
        back        = gear.AmbuscadeCape.StoreTP,
    }

    --  Boost "Sneak Attack+", "Trick Attack+", DEX/AGI
    sets.buff['SATA'] = sets.buff['Sneak Attack']

    -- Precast Sets
    sets.precast.JA = {}
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator']  = { head = gear.EmpyreanHead }
    sets.precast.JA['Accomplice']    = { head = gear.EmpyreanHead }
    sets.precast.JA['Flee']          = { feet = gear.ArtefactFeet }
    sets.precast.JA['Hide']          = { body = gear.ArtefactBody }
    sets.precast.JA['Conspirator']   = { body = gear.EmpyreanBody }
    sets.precast.JA['Steal']         = { feet = gear.ArtefactFeet } -- ammo="Barathrum"
    sets.precast.JA['Despoil']       = { legs = gear.EmpyreanLegs, feet = gear.EmpyreanFeet } --ammo="Barathrum"
    sets.precast.JA['Perfect Dodge'] = { hands = gear.RelicHands }
    sets.precast.JA['Feint']         = { legs = gear.RelicLegs }

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (CHR, VIT)
    sets.precast.Waltz = {
        ammo        = "Yamarang",
        head        = "Mummu Bonnet +2",
        body        = "Mummu Jacket +2",
        hands       = "Mummu Wrists +2",
        legs        = gear.ShantotoLegs,
        feet        = gear.RawhideFeet.WS,
        neck        = "Elite Royal Collar",
        waist       = "Chaac Belt",
        left_ear    = "Tuisto Earring",
        right_ear   = { name     = "Odnowa Earring +1",
                        augments = {'Path: A',}},
        left_ring   = "Petrov Ring",
    }
    sets.midcast.Waltz = sets.precast.Waltz

    -- TH actions
    sets.precast.Step = {
        head        = "Adhemar Bonnet +1",
        neck        = "Assassin's Gorget +1",
        ear1        = "Brutal Earring",
        ear2        = "Sherida Earring",
        back        = gear.AmbuscadeCape.WSDDex,
        ring1       = "Regal Ring",
        ring2       = "Ilabrat Ring",
        waist       = "Chaac Belt",
        legs        = gear.ArtefactLegs,
        feet        = gear.EmpyreanFeet,
    }
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo        = "Sapience Orb",                       --  FC  +2%
        head        = gear.HercHead.WS,                     --  FC  +7%
        body        = "Malignance Tabard",                  --  Eva +102
        hands       = "Malignance Gloves",                  --  Eva +80
        legs        = "Limbo Trousers",                     --  FC  +3%
        feet        = "Malignance Boots",                   --  Eva +119
        neck        = { name     = "Loricate Torque +1",    --  Spell Interrupt, DT
                        augments = {'Path: A',}},
        waist       = "Svelt. Gouriz +1",                   --  Eva +10
        left_ear    = "Loquac. Earring",                    --  FC  +2%
        right_ear   = { name     = "Odnowa Earring +1",     --  DT
                        augments = {'Path: A',}},
        left_ring   = "Defending Ring",                     --  DT
        right_ring  = "Evanescence Ring",                   --  Spell Interrupt
        back        = gear.AmbuscadeCape.StoreTP,           --  DT
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
    })

    -- Ranged gear
    sets.precast.RA = {
        head        = "Meghanada Visor +2",
        legs        = gear.AdhemarLegs,
        feet        = "Meg. Jam. +2",
        left_ring   = "Dingir Ring",
    }

    sets.midcast.RA = {
        head        = "Meghanada Visor +2",
        body        = "Meg. Cuirie +2",
        hands       = "Meg. Gloves +2",
        legs        = "Malignance Tights",
        feet        = "Malignance Boots",
        neck        = "Sanctity Necklace",
        waist       = "Eschan Stone",
        left_ear    = "Enervating Earring",
        right_ear   = "Volley Earring",
        left_ring   = "Dingir Ring",
        right_ring  = "Ephramad's Ring",
    }
    sets.midcast.RA.Acc = sets.midcast.RA
    sets.midcast.RA.TH  = set_combine(sets.midcast.RA, set.TreasureHunter)

    -- Weaponskill Sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=gear.HercHead.DM,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body=gear.HercBody.WSD,
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Gere Ring",
        back=gear.AmbuscadeCape.WSDDex,
        waist="Windbuffet Belt +1",
        legs=gear.ArtefactLegs,
        feet=gear.HercFeet.TP
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ring2="Cacoethic Ring +1",
        waist="Olseni Belt"
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head=gear.HercHead.DM,
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        ring2="Ilabrat Ring",
        legs="Meghanada Chausses +2",
        waist="Breeze Belt",
        back=gear.AmbuscadeCape.WSDDex,
    })
    sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'].Mid, {
        back=gear.AmbuscadeCape.WSDDex,
    })
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Fotia Gorget",
        body="Meghanada Cuirie +2",
        --hands=gear.ArtefactHands,
        legs=gear.ArtefactLegs,
    })
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Fotia Gorget",
        --hands=gear.ArtefactHands,
    })
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {neck="Fotia Gorget"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {
        head=gear.ArtefactHead,
        waist="Olseni Belt",
    })
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Fotia Gorget"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Fotia Gorget"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Fotia Gorget"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        neck="Fotia Gorget",
        head="Adhemar Bonnet +1",
        body="Herculean Vest",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        left_ring="Ilabrat Ring",
        right_ring="Rufescent Ring",
        hands="Adhemar Wristbands +1",
        waist="Sailfi Belt +1",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
        back=gear.AmbuscadeCape.WSDDex,
        feet="Mummu Gamashes +2"
    })
    sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'], {
        hands="Adhemar Wristbands +1",
        back=gear.AmbuscadeCape.WSDDex,
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        waist="Olseni Belt",
        neck="Assassin's Gorget +1",
    })
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Fotia Gorget"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Fotia Gorget"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Fotia Gorget"})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
        body="Herculean Vest",
        hands="Meg. Gloves +2",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
        feet={ name="Herculean Boots", augments={'Weapon skill damage +5%','AGI+8','Accuracy+6',}},
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Sailfi Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Ilabrat Ring",
        right_ring="Rufescent Ring",
        back={ name="Toutatis's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
-- Testing italics
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        body=gear.HercBody.WSD,
        --body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Snow Belt",
        back=gear.AmbuscadeCape.WSDDex,
        feet=gear.HercFeet.TP
    })
    sets.precast.WS["Rudra's Storm"].Mid = set_combine(sets.precast.WS["Rudra's Storm"], {
        ear2="Odr Earring",
        body="Meghanada Cuirie +2",
        back=gear.AmbuscadeCape.WSDDex,
    })
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
        legs=gear.ArtefactLegs,
        head=gear.ArtefactHead,
        body=gear.ArtefactBody,
        waist="Olseni Belt"
    })
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        ammo="Yetshila",
        head=gear.ArtefactHead,
        body="Meghanada Cuirie +2"
    })
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        body=gear.HercBody.WSD,
    })
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        body="Meghanada Cuirie +2",
    })

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
        head=gear.HercHead.DM,
        neck="Fotia Gorget",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        hands=gear.ArtefactHands,
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
    })
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {
        head=gear.ArtefactHead,
    })
    sets.precast.WS['Shark Bite'].Mid = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mid, {ring1="Ramuh Ring"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Fotia Gorget"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Fotia Gorget"})

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Seething Bomblet +1",
        neck="Sanctity Necklace",
        head=gear.HercHead.DM,
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        body=gear.HercBody.WSD,
        hands=gear.HercHands.MAB,
        ring1="Dingir Ring",
        ring2="Mummu Ring",
        back="Toro Cape",
        waist="Thunder Belt",
        legs=gear.HercLegs.MAB,
        feet=gear.HercFeet.MAB
    }
    sets.precast.WS["Cyclone"]    = sets.precast.WS['Aeolian Edge']
    sets.precast.WS["Gust Slash"] = sets.precast.WS['Aeolian Edge']

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast


    -- Resting sets
    sets.resting = {
		ammo="Staunch Tathlum +1",
        -- main="Taming Sari",
        head="Malignance Chapeau",
        neck="Bathy Choker +1",
        ear1="Infused Earring",
        ear2="Odnowa Earring +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Paguroidea Ring",
        ring2="Sheltered Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Flume Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots",
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        ammo        = "Yamarang",
        head        = "Malignance Chapeau",
        body        = "Malignance Tabard",
        hands       = "Malignance Gloves",
        legs        = "Malignance Tights",
        feet        = "Malignance Boots",
        neck        = { name     = "Loricate Torque +1",
                        augments = {'Path: A',}},
        waist       = "Plat. Mog. Belt",
        left_ear    = "Infused Earring",
        right_ear   = { name     = "Odnowa Earring +1",
                        augments = {'Path: A',}},
        left_ring   = "Defending Ring",
        right_ring  = "Sheltered Ring",
        back        = gear.AmbuscadeCape.StoreTP,
    }

    sets.idle.Town = set_combine(sets.idle, {
       ammo="Staunch Tathlum +1",
        -- main="Taming Sari",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",  --Bathy Choker +1
        ear1="Infused Earring",
        ear2="Odnowa Earring +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Flume Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots",
    })

    sets.idle.Regen = set_combine(sets.idle, {
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        ear1="Infused Earring",
        body="Malignance Tabard",
        ring1="Paguroidea Ring",
        ring2="Sheltered Ring",
    })
    sets.idle.PDT = set_combine(sets.idle, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        ring1="Defending Ring",
        ring2="Dark Ring"
    })

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Epona's Ring",
        back="Moonlight Cape",
        waist="Flume Belt +1",
        legs="Malignance Tights",
        feet="Malignance Boots",
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        ear1="Etiolation Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back="Solemnity Cape",
        legs="Malignance Tights",
        feet="Malignance Boots"
    }

    sets.Kiting = {
        feet        = gear.ArtefactFeet,
        waist       = "Sveltesse Gouriz +1",
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.

    -- Normal melee group
    sets.engaged = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Asperity Necklace",
        ear1="Cessance Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Sailfi Belt +1",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
    }
    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Adhemar Bonnet +1",
        ammo="Yamarang",
        --ring1="Petrov Ring",
        legs=gear.ArtefactLegs,
        -- feet="Mummu Gamashes +2"
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        head=gear.ArtefactHead,
        neck="Assassin's Gorget +1",
        ear1="Telos Earring",
        ear2="Odr Earring",
        body="Adhemar Jacket +1",
        hands="Floral Gauntlets",
        back=gear.AmbuscadeCape.StoreTP,
        ring1="Regal Ring",
        waist="Olseni Belt",
        feet=gear.HercFeet.TP
    })
    sets.engaged.PDT = set_combine(sets.engaged, {
        ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",
        neck="Loricate Torque +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
		waist="Sailfi Belt +1",
        back="Moonlight Cape",
        legs="Malignance Tights",
        feet="Malignance Boots"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.PDT, {
        body=gear.ArtefactBody,
        --ring1="Patricius Ring",
        back="Canny Cape",
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        body=gear.ArtefactBody,
        back="Canny Cape",
        waist="Olseni Belt"
    })

    -- Haste sets
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Asperity Necklace",
        ear1="Cessance Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Sailfi Belt +1",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Mid, {
        body="Adhemar Jacket +1",
        neck="Assassin's Gorget +1",
    })
    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc, {
        hands="Adhemar Wristbands +1",
    })
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, {
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=gear.AmbuscadeCape.StoreTP,
        legs="Malignance Tights",
        feet="Malignance Boots"
    })
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.PDT.Haste_15, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring2="Patricius Ring",
        legs="Malignance Tights",
        back="Canny Cape",
    })
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Mid.PDT.Haste_15, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        back="Canny Cape",
        legs="Malignance Tights",
        waist="Olseni Belt"
    })

    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Asperity Necklace",
        ear1="Cessance Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Sailfi Belt +1",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
        body=gear.ArtefactBody,
        ear1="Telos Earring",
        neck="Assassin's Gorget +1",
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        head="Adhemar Bonnet +1",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Windbuffet Belt +1",
        legs="Samnuha Tights",
        feet="Mummu Gamashes +2"
    })
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, {
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=gear.AmbuscadeCape.StoreTP,
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet=gear.HercFeet.TP
    })
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.PDT.Haste_30, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        ring2="Patricius Ring",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        back=gear.AmbuscadeCape.StoreTP,
    })
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Mid.PDT.Haste_30, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        back=gear.AmbuscadeCape.StoreTP,
        hands="Malignance Gloves",
        legs="Malignance Tights",
        waist="Olseni Belt"
    })

    -- Haste 43%
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Asperity Necklace",
        ear1="Cessance Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        back=gear.AmbuscadeCape.StoreTP,
        waist="Sailfi Belt +1",
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Adhemar Bonnet +1",
        ear1="Telos Earring",
        body=gear.ArtefactBody,
        ring1="Regal Ring",
        feet=gear.RelicFeet,
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.MaxHaste.Mid, {
        head=gear.ArtefactHead,
        neck="Assassin's Gorget +1",
        hands="Adhemar Wristbands +1",
        ear1="Telos Earring",
        ear2="Odr Earring",
        waist="Olseni Belt",
        back=gear.AmbuscadeCape.StoreTP,
        legs=gear.ArtefactLegs,
        feet="Mummu Gamashes +2"
    })
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=gear.AmbuscadeCape.StoreTP,
        legs="Malignance Tights",
        feet=gear.HercFeet.TP
    })
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.PDT.MaxHaste, {
        body=gear.ArtefactBody,
        ring2="Patricius Ring",
        back=gear.AmbuscadeCape.StoreTP,
    })
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Mid.PDT.MaxHaste, {
        body=gear.ArtefactBody,
        back=gear.AmbuscadeCape.StoreTP,
        waist="Olseni Belt"
    })
end


--  ----------------------------------------------------------------------------------------------------
--  Check before changing any equipment
--  ----------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()

    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


--  ----------------------------------------------------------------------------------------------------
--  PRECAST
--  ----------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    -- check_debuff_silenced(spell, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        --equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end


--  ----------------------------------------------------------------------------------------------------
--  MIDCAST
--  ----------------------------------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

--  ----------------------------------------------------------------------------------------------------
--  AFTERCAST
--  ----------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end

    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end


--  ----------------------------------------------------------------------------------------------------
--  Custom Sets
--  ----------------------------------------------------------------------------------------------------
function customize_idle_set(idleSet)
	-- check_special_ring_equipped()
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.value == 'PDT' then
        idleSet = set_combine(idleSet, sets.idle.PDT)
    end
    return idleSet
end

function customize_melee_set(meleeSet)
	check_special_ring_equipped()
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    return meleeSet
end


--  ----------------------------------------------------------------------------------------------------
--  STATUS CHANGE
--  ----------------------------------------------------------------------------------------------------
function user_status_change(newStatus, oldStatus)

end


--  ----------------------------------------------------------------------------------------------------
--  JOB BUFF CHANGE
--  ----------------------------------------------------------------------------------------------------
--  Job specific ability changes, mostly here to handy Sublimation
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	check_special_ring_equipped()

    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
    --determine_haste_group()
end


--  ----------------------------------------------------------------------------------------------------
--  JOB SELF COMMAND / CUSTOM COMMANDS
--  ----------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    --  Make Reraise easy to handle
    -- if (cmdParams[1]:lower() == 'reraise') then
    --     cast_highest_available_reraise()
    --     eventArgs.handled = true
    --     return
    -- end

end


--  ----------------------------------------------------------------------------------------------------
--  SELECT MACRO BOOK
--  ----------------------------------------------------------------------------------------------------
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 18)
    else
        set_macro_page(1, 18)
    end
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                ( buffactive.march == 2 and buffactive[604] ) ) then

            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then

            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then

            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
            ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
            ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
            ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches

            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then  -- haste with MG

            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end

windower.register_event('zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(sets.idle)
    end
)