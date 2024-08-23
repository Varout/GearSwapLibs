-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off

    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.

    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    send_command('clearbinds')

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    -- include('warp_functions.lua')
    include('Mote-TreasureHunter')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(true)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

--  Beagle's change mode to switch between DD gun and Rolls gun
--  /equip range "weapon"
--  /macro book #
--  /macro set #



    state.OffenseMode:options('Melee', 'Ranged', 'Acc')
    state.RangedMode:options('Normal', 'Acc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet" -- Devastating Bullet
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 10

    -- Additional local binds
    -- send_command('bind ^v paste')
    -- send_command('bind !f fillmode')

    -- send_command('bind @t gs c cycle treasuremode')
    send_command('bind @l gs c toggle LuzafRing')
    -- send_command('bind @e input /item "Echo Drops" <me>')
    -- send_command('bind @r input /item "Remedy" <me>')
    -- send_command('bind @p input /item "Panacea" <me>')
    -- send_command('bind @h input /item "Holy Water" <me>')

    -- send_command('bind !` input /ja "Double-up" <me>')
    -- send_command('bind ^c input /ja "Crooked Cards" <me>')
    -- send_command('bind ^` input /ja "Snake Eye" <me>')
    -- send_command('bind @f input /ja "Fold" <me>')
    -- send_command('bind @b input /ja "Bolter\'s Roll" <me>')
    send_command('bind @` gs c toggle LuzafRing')

    -- send_command('bind @1 input /ws "Savage Blade" <t>')
    -- send_command('bind @2 input /ws "Wildfire" <t>')
    -- send_command('bind @3 input /ws "Leaden Salute" <t>')
    -- send_command('bind @4 input /ws "Last Stand" <t>')
    -- send_command('bind @5 input /ws "Aeolian Edge" <t>')
    -- send_command('bind @6 input /ws "Evisceration" <t>')
    -- send_command('bind @7 input /ws "Requiescat" <t>')

    -- send_command('bind !1 input /ra <t>')

    send_command('bind ^1 fireshot')
    send_command('bind ^2 darkshot')
    send_command('bind ^3 lightshot')
    send_command('bind ^4 watershot')
    send_command('bind ^5 thundershot')

    -- send_command('alias mhaura gs c sw mhaura')
    -- send_command('alias eado gs c sw eado')
    -- send_command('alias wado gs c sw wado')
    -- send_command('alias psan gs c sw psan')
    -- send_command('alias nsan1 gs c sw nsan1')
    -- send_command('alias nsan2 gs c sw nsan2')
    -- send_command('alias ssan1 gs c sw ssan1')
    -- send_command('alias ssan2 gs c sw ssan2')
    -- send_command('alias rulude gs c sw rulude')
    -- send_command('alias pj1 gs c sw pj1')
    -- send_command('alias pj2 gs c sw pj2')
    -- send_command('alias wg hp aht urhgan whitegate 2')
    -- send_command('alias nash hp nashmau')
    -- send_command('alias warpring gs c sw warp')
    -- send_command('alias mhauraall send @all gs c sw mhaura')
    -- send_command('alias eadoall send @all gs c sw eado')
    -- send_command('alias wadoall send @all gs c sw wado')
    -- send_command('alias psanall send @all gs c sw psan')
    -- send_command('alias nsan1all send @all gs c sw nsan1')
    -- send_command('alias nsan2all send @all gs c sw nsan2')
    -- send_command('alias ssan1all send @all gs c sw ssan1')
    -- send_command('alias ssan2all send @all gs c sw ssan2')
    -- send_command('alias ruludeall send @all gs c sw rulude')
    -- send_command('alias pj1all send @all gs c sw pj1')
    -- send_command('alias pj2all send @all gs c sw pj2')
    -- send_command('alias expall send @all gs c sw exp')
    -- send_command('alias delveall send @all gs c sw yorciafs')
    -- send_command('alias warpringall send @all gs c sw warp')
    -- send_command('alias mg Unbridled Learning; wait 1.5; Diffusion; wait 1.5; Mighty Guard')
    -- send_command('alias followall send beefcurtains hb f esvedium; wait .2; send mibbley hb f esvedium')

    select_default_macro_book()

    send_command('wait 4; input /lockstyleset 14')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    ------------------------------------------------------------------------------------------------
    -----------------------------------------Augmented Gear-----------------------------------------
    ------------------------------------------------------------------------------------------------

    HercHead = {}
    HercHead.Refresh = {name="Herculean Helm", augments={'INT+7','"Store TP"+2','"Refresh"+1','Accuracy+16 Attack+16'}}
    HercHead.TH = {name="Herculean Helm", augments={'Pet: INT+11','CHR+7','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13'}}

    HercHands = {}
    HercHands.Refresh = {name="Herculean Gloves", augments={'AGI+6','Attack+19','"Refresh"+1','Accuracy+16 Attack+16'}}
    HercHands.TH = {name="Herculean Gloves", augments={'Attack+8','"Blood Pact" ability delay -1','"Treasure Hunter"+1','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11'}}
    HercHands.WS = {name="Herculean Gloves", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +4%','Mag. Acc.+14'}}

    HercLegs = {}
    HercLegs.PH = {name="Herculean Trousers", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Phys. dmg. taken -2%','Phalanx +4','Accuracy+12 Attack+12'}}
    HercLegs.MAB = {name="Herculean Trousers", augments={'Weapon skill damage +4%','STR+5','"Mag.Atk.Bns."+12'}}
    HercLegs.WS = {name="Herculean Trousers", augments={'Weapon skill damage +4%','STR+5','"Mag.Atk.Bns."+12'}}

    HercFeet = {}
    HercFeet.TH = {name="Herculean Boots", augments={'Attack+5','"Mag.Atk.Bns."+7','"Treasure Hunter"+2','Accuracy+5 Attack+5',}}
    HercFeet.WS = {name="Herculean Boots", augments={'"Mag.Atk.Bns."+11','"Conserve MP"+1','Weapon skill damage +6%','Accuracy+16 Attack+16'}}

    COR_Back = {}
    COR_Back.MAB = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10'}}
    COR_Back.RA = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+5','"Store TP"+10','Phys. dmg. taken-10%'}}
    COR_Back.MABWS = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Occ. inc. resist. to stat. ailments+10'}}
    COR_Back.Snap = {name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Mag. Evasion+15'}}

    TaeonHead = {}
    TaeonHead.PH = {name="Taeon Chapeau", augments={'Spell interruption rate down -9%','Phalanx +3'}}

    TaeonBody = {}
    TaeonBody.Snap = {name="Taeon Tabard", augments={'Phalanx +3'}}

    TaeonHands = {}
    TaeonHands.PH = {name="Taeon Gloves", augments={'Phalanx +3'}}

    TaeonLegs = {}
    TaeonLegs.PH = {name="Taeon Tights", augments={'Phalanx +3'}}

    TaeonFeet = {}
    TaeonFeet.PH = {name="Taeon Boots", augments={'"Cure" potency +3%','Phalanx +3'}}


    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Setsg

    -- Precast sets to enhance JAs

    sets.precast.JA['Snake Eye'] = {
		legs = "Lanun Trews +1"
	}
    sets.precast.JA['Wild Card'] = {
		feet = "Lanun Bottes +3"
	}
    sets.precast.JA['Random Deal'] = {
		body = "Lanun Frac +1"
	}

    -- sets.precast.JA['Violent Flourish'] = {ammo="Devastating Bullet",
    --     head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
    --     body="Mummu Jacket +2",hands="Malignance Gloves",ring1={name="Stikini Ring +1",bag="Wardrobe"},ring2={name="Stikini Ring +1",bag="Wardrobe 2"},
    --     back=COR_Back.MABWS,waist="Eschan Stone",legs="Mummu Kecks +2",feet="Malignance Boots"}

    sets.precast.CorsairRoll = {
        head="Lanun Tricorne +1",
		neck="Regal Necklace",
		ear1="Hearty Earring",
		ear2="Odnowa Earring +1",
        body="Lanun Frac",
		hands="Chasseur's Gants +1",
		ring1="Defending Ring",
		ring2="Luzaf's Ring",
        back="Camulus's Mantle",
		waist="Flume Belt +1",
		legs="Desultor Tassets",
		feet="Lanun Bottes +3"
	}

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
		legs="Chasseur's Culottes +1"
	})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
		feet="Chasseur's Bottes +1"
	})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {
		head="Chasseur's Tricorne +1"
	})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
		body="Chasseur's Frac +1"
	})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {
		hands="Chasseur's Gants +1"
	})

    sets.precast.LuzafRing = {
		ring1="Luzaf's Ring"
	}
    sets.precast.FoldDoubleBust = {
		hands="Lanun Gants +1"
	}

    -- Waltz set (chr and vit)
    -- sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    -- sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
		head="Carmine Mask +1",
		neck="Voltsurge Torque",
		ear2="Loquacious Earring",
        body=TaeonBody.Snap,
		hands="Leyline Gloves",
        feet=TaeonFeet.PH
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads"
	})

    sets.precast.RA = {
		ammo=gear.RAbullet,
        head="Chasseur's Tricorne +1",
		neck="Commodore Charm",
        body="Laksamana's Frac +1",
		hands="Lanun Gants +1",
        back=COR_Back.Snap,
		waist="Yemaya Belt",
		legs="Adhemar Kecks +1",
		feet="Meg. Jam. +2"
	}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo=gear.WSbullet,
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body="Adhemar Jacket +1",
		hands="Meghanada Gloves +2",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
        back=COR_Back.MABWS,
		waist="Sailfi Belt +1",
		feet=HercLegs.WS,
		feet="Lanun Bottes +3"
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Savage Blade'] = {
		ammo=gear.WSbullet,
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body="Adhemar Jacket +1",
		hands="Meghanada Gloves +2",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
        back=COR_Back.MABWS,
		waist="Sailfi Belt +1",
		legs=HercLegs.WS,
		feet="Lanun Bottes +3"
	}

    sets.precast.WS['Last Stand'] = {
		ammo=gear.WSbullet,
        head="Meghanada Visor +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body="Adhemar Jacket +1",
		hands="Meghanada Gloves +2",
		ring1="Dingir Ring",
		ring2="Ilabrat Ring",
        back=COR_Back.MABWS,
		waist="Fotia Belt",
		legs=HercLegs.WS,
		feet="Lanun Bottes +3"
	}

    sets.precast.WS['Wildfire'] = {
		ammo=gear.MAbullet,
        head=HercHead.TH,
		neck="Baetyl Pendant",
		ear1="Novio Earring",
		ear2="Friomisi Earring",
        body="Lanun Frac +3",
		hands=HercHands.WS,
		ring1="Dingir Ring",
		ring2={name="Shiva Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,
		waist="Eschan Stone",
		legs=HercLegs.MAB,
		feet="Lanun Bottes +3"
	}

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
		ear1="Moonshade Earring",
		ring2="Archon Ring",
	})

    sets.precast.WS['Aeolian Edge'] = {
		ammo=gear.QDbullet,
        head=HercHead.TH,
		neck="Baetyl Pendant",
		ear1="Novio Earring",
		ear2="Friomisi Earring",
        body="Lanun Frac +3",
		hands=HercHands.WS,
		ring1="Dingir Ring",
		ring2={name="Shiva Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,
		waist="Eschan Stone",
		legs=HercLegs.MAB,
		feet="Lanun Bottes +3"
	}

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head=HercHead.TH,neck="Baetyl Pendant",ear1="Novio Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2={name="Shiva Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,waist="Eschan Stone",legs=HercLegs.MAB,feet="Lanun Bottes +3"}

    sets.midcast.CorsairShot.Acc = {ammo="Devastating Bullet",
        head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Mummu Jacket +2",hands="Malignance Gloves",ring1={name="Stikini Ring +1",bag="Wardrobe"},ring2={name="Stikini Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,waist="Eschan Stone",legs="Mummu Kecks +2",feet="Malignance Boots"}

    sets.midcast.CorsairShot.Enhance = {ammo=gear.QDbullet,
        head=HercHead.TH,neck="Baetyl Pendant",ear1="Novio Earring",ear2="Friomisi Earring",
        body="Mirke Wardecors",hands="Carmine Finger Gauntlets +1",ring1="Dingir Ring",ring2={name="Shiva Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,waist="Eschan Stone",legs=HercLegs.MAB,feet="Chass. Bottes +1"}

    sets.midcast.CorsairShot['Fire Shot'] = sets.midcast.CorsairShot.Enhance

    sets.midcast.CorsairShot['Light Shot'] = {ammo="Devastating Bullet",
        head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Mummu Jacket +2",hands="Malignance Gloves",ring1={name="Stikini Ring +1",bag="Wardrobe"},ring2={name="Stikini Ring +1",bag="Wardrobe 2"},
        back=COR_Back.MABWS,waist="Eschan Stone",legs="Mummu Kecks +2",feet="Malignance Boots"}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA ={ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Dedition Earring",ear2="Clearview Earring",
        body="Nisroch Jerkin",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=COR_Back.RA,waist="Yemaya Belt",legs="Meghanada Chausses +2",feet="Malignance Boots"}

    sets.midcast.RA.Acc ={ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Odr Earring",ear2="Clearview Earring",
        body="Nisroch Jerkin",hands="Malignance Gloves",ring1="Dingir Ring",ring2="Hajduk Ring",
        back=COR_Back.RA,waist="Yemaya Belt",legs="Meghanada Chausses +2",feet="Malignance Boots"}

    sets.midcast.RA.Critical = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Odr Earring",ear2="Clearview Earring",
        body="Nisroch Jerkin",hands="Mummu Wrists +2",ring1="Mummu Ring",ring2="Begrudging Ring",
        back=COR_Back.RA,waist="Yemaya Belt",legs="Mummu Kecks +2",feet="Oshoci Leggings"}

    sets.TripleShot = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Iskur Gorget",ear1="Odr Earring",ear2="Clearview Earring",
        body="Chasseur's Frac +1",hands="Oshosi Gloves",ring1="Dingir Ring",ring2="Hajduk Ring",
        back=COR_Back.RA,waist="Yemaya Belt",legs="Oshosi Trousers",feet="Oshosi Leggings"}

    sets.TrueShot = {body="Nisroch Jerkin",legs="Oshosi Trousers"}

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {neck="Sanctity Necklace"}

    -- Idle sets
    sets.idle = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=COR_Back.RA,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Meghanada Jambeaux +2"}

    sets.idle.Town={ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +2",hands="Meghanada Gloves +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back=COR_Back.RA,waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Meghanada Jambeaux +2"}

    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.Utility = {}

    --Comes on while terrored, asleep, etc
    sets.Utility.DerpDT = {
        head="Meghanada Visor +2",neck="Loricate Torque +1",ear1="Hearty Earring",ear2="Odnowa Earring +1",
        body="Meghanada Cuirie +1",hands="Meghanada Gloves +1",ring1="Defending Ring",ring2="Gelatinous Ring +1",
        back="Camulus's Mantle",waist="Flume Belt +1",legs="Mummu Kecks +2",feet="Meghanada Jambeaux +2"}

    -- Engaged sets

    -- Normal melee group
    sets.engaged.Melee = {
        head="Adhemar Bonnet +1",neck="Clotharius Torque",ear1="Dedition Earring",ear2="Cessance Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back=COR_Back.MABWS,waist="Windbuffet Belt +1",legs="Mummu Kecks +2",feet="Mummu Gamashes +2"}

    sets.engaged.Acc = {
        head="Adhemar Bonnet +1",
		neck="Sanctity Necklace",
		ear1="Steelflash Earring",
		ear2="Bladeborn Earring",
        body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
        back=COR_Back.MABWS,
		waist="Windbuffet Belt +1",
		legs="Meghanada Chausses +2",
		feet="Meghanada Jambeaux +2"
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
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

function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-- Turtle Mode
function buff_change(n, gain, buff_table)
    local name
    name = string.lower(n)
    if S{"terror","petrification","sleep","stun"}:contains(name) then
        if gain then
            ChangeGear(sets.Utility.DerpDT) -- Put this set on when terrored etc
        elseif not has_any_buff_of({"terror","petrification","sleep","stun"}) then
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                        ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "doom" then
        if gain then
            send_command('@input /echo Doomed {~o~:} !')
        else
            send_command('@input /echo Doom is off {^_^}')
        end
    elseif name == "charm" then
        if gain then
            send_command('@input /echo Charmed {<3_<3:} !')
        else
            send_command('@input /echo Charm is off {~_^}')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
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


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end

    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="XP"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky '..tostring(rollinfo.lucky)..', Unlucky '..tostring(rollinfo.unlucky)..'.')
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
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
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
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end