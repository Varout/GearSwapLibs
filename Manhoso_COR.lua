-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan)
-------------------------------------------------------------------------------------------------------------------

--[[    Custom Features:

        QuickDraw Selector    Cycle through available primary and secondary shot types,
                            and trigger with a single macro
        Haste Detection        Detects current magic haste level and equips corresponding engaged set to
                            optimize delay reduction (automatic)
        Haste Mode            Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
        Capacity Pts. Mode    Capacity Points Mode Toggle [WinKey-C]
        Reive Detection        Automatically equips Reive bonus gear
        Auto. Lockstyle        Automatically locks specified equipset on file load
--]]

-------------------------------------------------------------------------------------------------------------------

--[[

    Custom commands:

    gs c qd
        Uses the currently configured shot on the target, with either <t> or <stnpc> depending on setting.

    gs c qd t
        Uses the currently configured shot on the target, but forces use of <t>.


    Configuration commands:

    gs c cycle mainqd
        Cycles through the available steps to use as the primary shot when using one of the above commands.

    gs c cycle altqd
        Cycles through the available steps to use for alternating with the configured main shot.

    gs c toggle usealtqd
        Toggles whether or not to use an alternate shot.

    gs c toggle selectqdtarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.


    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off

    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.

    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('COR_Roll_Values.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Dark Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot', 'Dark Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')
    state.HasteMode = M{['description']='Haste Mode', 'Haste I', 'Haste II'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    determine_haste_group()

end


--  Beagle's change mode to switch between DD gun and Rolls gun
--  /equip range "weapon"
--  /macro book #
--  /macro set #

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal',  'Hybrid')
    state.RangedMode:options('Normal', 'Acc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.CP = M(false, "Capacity Points Mode")
    state.DynaMode = M(false, "Dyna Mode")
    state.BuffMode = M(true, "Buff Mode")

    options.ammo_warning_limit = 5


    -- Additional local binds
    send_command('bind mmstop gs c reset DefenseMode')
    send_command('bind mail gs c cycle IdleMode')
    --send_command('bind ^` input /ja "Double-up" <me>')
    --send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    --send_command ('bind @` gs c toggle LuzafRing')

    --send_command('bind ^- gs c cycleback mainqd')
    --send_command('bind ^= gs c cycle mainqd')
    --send_command('bind !- gs c cycle altqd')
    --send_command('bind != gs c cycleback altqd')
    --send_command('bind ^[ gs c toggle selectqdtarget')
    --send_command('bind ^] gs c toggle usealtqd')

    if player.sub_job == 'DNC' then
        --send_command('bind ^, input /ja "Spectral Jig" <me>')
        --send_command('unbind ^.')
    elseif player.sub_job == "RDM" or player.sub_job == "WHM" then
        --send_command('bind ^, input /ma "Sneak" <stpc>')
        --send_command('bind ^. input /ma "Invisible" <stpc>')
    else
        --send_command('bind ^, input /item "Silent Oil" <me>')
        --send_command('bind ^. input /item "Prism Powder" <me>')
    end

    send_command('bind @c gs c toggle CP')
    send_command('bind @x gs c toggle Dyna')
    --send_command('bind @h gs c cycle HasteMode')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
--    send_command('unbind ^`')
--    send_command('unbind !`')
--    send_command('unbind @`')
--    send_command('unbind ^-')
--    send_command('unbind ^=')
--    send_command('unbind !-')
--    send_command('unbind !=')
--    send_command('unbind ^[')
--    send_command('unbind ^]')
--    send_command('unbind ^,')
send_command('unbind @c')
send_command('unbind @x')
--    send_command('unbind @h')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet"
    gear.QDbullet = "Animikii Bullet"

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
    sets.precast.JA['Triple Shot'] = { body = "Chasseur's Frac +2" }
    sets.precast.JA['Snake Eye']   = { legs = "Lanun Trews +2" }
    sets.precast.JA['Wild Card']   = { feet = "Lanun Bottes +3" }
    sets.precast.JA['Random Deal'] = { body = "Lanun Frac +3" }
    sets.precast.FoldDoubleBust    = { hands = "Lanun Gants +2" }

    sets.precast.CorsairRoll = {
        head={ name="Lanun Tricorne +2", augments={'Enhances "Winning Streak" effect',}},
        body="Malignance Tabard",
        hands="Chasseur's Gants +2",
        legs={ name="Desultor Tassets", augments={'"Phantom Roll" ability delay -5','"Waltz" TP cost -5',}},
        feet="Malignance Boots",
        neck="Elite Royal Collar",
        waist="Kwahu Kachina Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Tuisto Earring",
        left_ring="Barataria Ring",
        right_ring="Luzaf's Ring",
        back={ name="Gunslinger's Cape", augments={'Enmity-3','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5','Weapon skill damage +1%',}},
    }

    sets.precast.CorsairRoll["Blitzer's Roll"]   = set_combine(sets.precast.CorsairRoll, { head = "Chasseur's Tricorne +2" })
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, { body = "Chasseur's Frac +2" })
    sets.precast.CorsairRoll["Allies' Roll"]     = set_combine(sets.precast.CorsairRoll, { hand = "Chasseur's Gants +2" })
    sets.precast.CorsairRoll["Caster's Roll"]    = set_combine(sets.precast.CorsairRoll, { legs = "Chasseur's Culottes +2" })
    sets.precast.CorsairRoll["Courser's Roll"]   = set_combine(sets.precast.CorsairRoll, { feet = "Chasseur's Bottes +2" })

    sets.precast.CorsairShot = {
        head="Laksa. Tricorne +2",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands="Chasseur's Gants +2",
        legs="Chas. Culottes +2",
        feet="Chass. Bottes +2",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear={ name="Chas. Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
        left_ring="Dingir Ring",
        right_ring="Adoulin Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    sets.precast.Waltz = {  -- CHR and VIT
        head="Mummu Bonnet +2",
        body="Laksa. Frac +3",
        hands="Laksa. Gants +2",
        legs={ name="Lanun Trews +3", augments={'Enhances "Snake Eye" effect',}},
        feet={ name="Rawhide Boots", augments={'STR+8','Attack+11','"Store TP"+4',}},
        neck="Elite Royal Collar",
        waist="Chaac Belt",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Tuisto Earring",
        left_ring="Defending Ring",
        right_ring="Petrov Ring",
        back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet="Malignance Boots",
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Defending Ring",
        right_ring="Kishar Ring",
        back={ name="Camulus's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.RA = {
        head="Chass. Tricorne +2",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Chas. Culottes +2",
        feet="Malignance Boots",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Beyla Earring",
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Ephramad's Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo= gear.WSbullet,
        head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
        body="Laksa. Frac +3",
        hands="Chasseur's Gants +2",
        legs={ name="Herculean Trousers", augments={'Accuracy+27','Weapon skill damage +5%','AGI+8',}},
        feet="Lanun Bottes +3",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Sailfi Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Ilabrat Ring",
        right_ring="Ephramad's Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
        ammo= gear.WSbullet,
        head="Lanun Tricorne +2",
        body="Laksa. Frac +3",
        hands={ name="Herculean Gloves", augments={'Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+11',}},
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck={ name="Commodore Charm", augments={'Path: A',}},  --"Fotia Gorget"
        waist="Kwahu Kachina Belt",  --"Fotia Belt"
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Dingir Ring",
        right_ring="Ilabrat Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, {
        ammo= gear.WSbullet,  --Orichalcum or Living Bullet
        head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands="Chasseur's Gants +2",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Adoulin Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS, {
        head="Pixie Hairpin +1",
        body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
        hands="Chasseur's Gants +2",
        legs="Malignance Tights",
        feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Svelt. Gouriz +1",
        left_ear="Friomisi Earring",
        right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        left_ring="Dingir Ring",
        right_ring="Adoulin Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        -- body="Meg. Cuirie +2",
        -- hands="Meg. Gloves +2",
        -- legs="Samnuha Tights",
        -- ear1="Brutal Earring",
        -- ear2="Telos earring",
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,
 {
        head={ name="Herculean Helm", augments={'Attack+12','Weapon skill damage +5%',}},
        body="Laksa. Frac +3",
        hands="Chasseur's Gants +2",
        legs={ name="Herculean Trousers", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +5%','STR+7','Mag. Acc.+8','"Mag.Atk.Bns."+6',}},
        feet="Lanun Bottes +3",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Sailfi Belt +1",
        left_ear="Ishvara Earring",
        right_ear="Moonshade Earring",
        left_ring="Ilabrat Ring",
        right_ring="Ephramad's Ring",
        back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], { ring1="Rufescent Ring", })

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Savage Blade'], {}) --MND
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})

    -- Midcast Sets
    sets.midcast.FastRecast = {}
    sets.midcast.Cure = {}
    sets.midcast['Elemental Magic'] = {}
    sets.midcast.Utsusemi = {}
    sets.midcast.CorsairShot = {}
    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot, {})
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
    sets.midcast.RA = {
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +2",
        feet="Malignance Boots",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Beyla Earring",
        right_ear="Enervating Earring",
        left_ring="Paqichikaji Ring",
        right_ring="Meghanada Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    -- Ranged gear
    -- sets.midcast.RA = {
    --     head="Meghanada Visor +2", --?/0
    --     body="Meg. Cuirie +2", --7/0
    --     hands="Meg. Gloves +2", --3/0
    --     legs="Meg. Chausses +2", --5/0
    --     feet="Meg. Jam. +2", --4/0
    -- }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo= gear.RAbullet,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Elite Royal Collar",
        waist="Platinum Moogle Belt",
        left_ear="Infused Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Sheltered Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.idle.refresh = set_combine(sets.idle, {
        head="Rawhide Mask",
        legs= { name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    })

    sets.idle.DT = set_combine(sets.idle, {
        -- head        = "Rawhide Mask",
        -- body        = "Meg. Cuirie +2",
        -- hands    = { name="Herculean gloves", augments={'"Refresh"+1'}},
        -- legs        = { name="Herculean trousers", augments={'"Refresh"+1'}},
        feet="Malignance Boots",
        -- neck        = "Loricate Torque +1",
        ear2="Odnowa Earring +1",
        -- right_ring    = "Shneddick Ring",
        left_ring="Defending Ring",
        waist="Flume Belt +1",
    })

    sets.idle.Town = set_combine(sets.idle, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Elite Royal Collar",
        waist="Platinum Moogle Belt",
        left_ear="Infused Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Sheltered Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    })


    -- Defense sets
    sets.defense.PDT = {
        -- head="Meghanada Visor +2", --?/0
        -- body="Meg. Cuirie +2", --7/0
        -- hands="Meg. Gloves +2", --3/0
        -- legs="Meg. Chausses +2", --5/0
        -- feet="Meg. Jam. +2", --4/0
        -- neck="Loricate Torque +1", --6/6
        -- ear2="Odnowa Earring +1", --0/2
        -- ring1="Defending Ring", --10/10
        -- waist="Flume Belt +1", --4/0
    }

    sets.defense.MDT = sets.defense.PDT
    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * NIN Subjob DW Trait: 25% DW
    -- * DNC Subjob DW Trait: 15% DW

    -- No Magic Haste (72% DW to cap)
    sets.engaged.Normal = {
        ammo=gear.RAbullet,
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Malignance Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+19','"Triple Atk."+4','Attack+4',}},
        neck="Asperity Necklace",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Petrov Ring",
        right_ring="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.Hybrid = {
        ammo= gear.RAbullet,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Epona's Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.engaged.Triple = {
        body="Chasseur's Frac+1",
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {})
    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})
    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})


    -- 15% Magic Haste (66% DW to cap)
    sets.engaged.LowHaste = set_combine(sets.engaged, {}) -- 55-65% (40% Gear)
    sets.engaged.LowHaste.LowAcc = set_combine(sets.engaged.LowHaste, {})
    sets.engaged.LowHaste.MidAcc = set_combine(sets.engaged.LowHaste.LowAcc, {})
    sets.engaged.LowHaste.HighAcc = set_combine(sets.engaged.LowHaste.MidAcc, {})
    sets.engaged.LowHaste.Fodder = set_combine(sets.engaged.LowHaste, {})

    -- 30% Magic Haste (55% DW to cap)
    sets.engaged.MidHaste = set_combine(sets.engaged, {}) -- 49-59% (34% Gear)
    sets.engaged.MidHaste.LowAcc = set_combine(sets.engaged.MidHaste, {})
    sets.engaged.MidHaste.MidAcc = set_combine(sets.engaged.MidHaste.LowAcc, {})
    sets.engaged.MidHaste.HighAcc = set_combine(sets.engaged.MidHaste.MidAcc, {})
    sets.engaged.MidHaste.Fodder = set_combine(sets.engaged.MidHaste, {})

    -- 35% Magic Haste (50% DW to cap)
    sets.engaged.HighHaste = set_combine(set.engaged, {}) -- 38-48% (23% Gear)
    sets.engaged.HighHaste.LowAcc = set_combine(sets.engaged.HighHaste, {})
    sets.engaged.HighHaste.MidAcc = set_combine(sets.engaged.HighHaste.LowAcc, {})
    sets.engaged.HighHaste.HighAcc = set_combine(sets.engaged.HighHaste.MidAcc, {})
    sets.engaged.HighHaste.Fodder = set_combine(sets.engaged.HighHaste, {})

    -- 47% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = set_combine(set.engaged, {}) -- 24-34% (9% Gear)
    sets.engaged.MaxHaste.LowAcc = set_combine(sets.engaged.HighHaste, {})
    sets.engaged.MaxHaste.MidAcc = set_combine(sets.engaged.MaxHaste.LowAcc, {})
    sets.engaged.MaxHaste.HighAcc = set_combine(sets.engaged.MaxHaste.MidAcc, {})
    sets.engaged.MaxHaste.Fodder = set_combine(sets.engaged.MaxHaste, {})

    -- sets.Obi = {waist="Hachirin-no-Obi"}   --(if upgrading to all elemental obi, remove other obi lines and adjust obi rule)
    -- sets.DarkObi = {waist="Anrin Obi"}
    -- sets.CP = {back="Aptitude Mantle"}
    -- sets.Reive = {neck="Ygnas's Resolve +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function aftercast(spell,action)
    if not spell.interrupted then
        if spell.type == "WeaponSkill" then
            send_command('wait 0.2;gs c TP')
        end
    end
    status_change(player.status)
end

function status_change(new,old)
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'MDT' then
        equip(sets.MDT)
    elseif Armor == 'Kiting' then
        equip(sets.Kiting)
--[[    elseif Armor == 'CP' then
        send_command('gs disable back')]]--
    elseif new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    if spell.action_type == 'Magic' and buffactive['Silence'] then
        cancel_spell()
            send_command('input /item "Echo Drops" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Echo Drops'].count..' Left !!*')
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for WS/Quick Draw.
    if spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        if spell.english == 'Leaden Salute' and (world.weather_element == 'Dark' or world.day_element == 'Dark') then
            equip(sets.DarkObi)
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        elseif spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(sets.Obi)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if buffactive['Reive Mark'] then
        equip(sets.Reive)
        disable('neck')
    else
        enable('neck')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" then
        idleSet = set_combine(idleSet, sets.idle.refresh)
    end
    return idleSet
end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.

function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.

function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current..'/'..state.RangedMode.current .. ' ]'
    msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

    msg = msg .. '[ ' .. state.HasteMode.value .. ' ]'

    msg = msg .. '[ *'..state.Mainqd.current

    if state.UseAltqd.value == true then
        msg = msg .. '/'..state.Altqd.current
    end

    msg = msg .. '* ]'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5%/10%
    -- Victory March +0/+3/+4/+5    9.4%/14%/15.6%/17.1%
    -- Advancing March +0/+3/+4/+5  6.3%/10.9%/12.5%/14%
    -- Embrava - 30%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 40%

    classes.CustomMeleeGroups:clear()

    if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604])) then
            --add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            --add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            --add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            --add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) then
            --add_to_chat(215, '---------- <<<< | Magic Haste Level: 43% | >>>> ----------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            --add_to_chat(004, '---------- <<<< | Magic Haste Level: 35% | >>>> ----------')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            --add_to_chat(008, '---------- <<<< | Magic Haste Level: 30% | >>>> ----------')
            classes.CustomMeleeGroups:append('MidHaste')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            --add_to_chat(007, '---------- <<<< | Magic Haste Level: 15% | >>>> ----------')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShotShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
--            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)    --  Jason
    send_command('wait 2; input /lockstyleset 003')
end
