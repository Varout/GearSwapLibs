-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
		organizer_items = {
  MABfood="Pear Crepe",
  Remedy="Remedy",
  echos="Echo Drops",
  shihei="Shihei",
  sushi="Sublime sushi",
  sushii="Sublime sushi +1",
  bun="Red curry bun",
  water="Holy water",
  Ring="Dim. Ring (holla)",
  Warpring="Warp ring",
  Card="Trump Card",
  bullet="Chrono Bullet",
  bullett="Living Bullet",
  }
end



-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(7, 5)
    send_command('bind != gs c toggle CapacityMode')

	set_lockstyle()

	
	moonshade_WS = S{"Stardiver","Savage Blade","Camlanns Torment",}
	
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
   
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets +3"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
     sets.WSDayBonus = (set_combine(equipSet,{head="Gavialis Helm"}))


	sets.precast.JA.Jump = {

	    sub="Utu Grip",
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'"Store TP"+8','Accuracy+13','Attack+2',}},
    hands="Iktomi Dastanas",
    legs={ name="Valor. Hose", augments={'Accuracy+19','"Dbl.Atk."+5','VIT+6','Attack+5',}},
    feet="Flam. Gambieras +2",
    neck="Anu Torque",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	
    }

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }
	

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {legs="Vishap Brais +3",
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Peltast's Cuissots +1"
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Peltast's Cuissots +1"
        --feet="Lancer's Schynbalds +2"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
        hands="Peltast's Vambraces +1", 
        head="Vishap Armet +2"
    }
	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +1"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1" or Petroslaver Armet +1
    }
	sets.precast.JA['Spirit Surge'] = {body="Pteroslaver Mail +1"}
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Ginsen",
        head="Vishap Armet +2",
        legs="Vishap Brais +3",
    
    }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {

    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
      
        ear1="Loquacious Earring", 
        hands="Leyline Gloves",
    
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +2" })
	

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {  
	ammo="Knobkierrie",
    head="Gleti's Mask",
    body="Gleti's Guirass",
    hands="Gleti's Gauntlets",
    legs="Vishap Brais +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	head="Ynglinga sallet",
    body="Sulevia's platemail +2",
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {  
	ammo="Knobkierrie",
    head="Gleti's Mask",
    body="Gleti's Guirass",
    hands="Gleti's Gauntlets",
    legs="Vishap Brais +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},
    })
	
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
   ammo="Knobkierrie",
    head="Flamma zucchetto +2",
    body={ name="Valorous Mail", augments={'Accuracy+29','"Dbl.Atk."+3',}},
    hands="Sulev. Gauntlets +2",
    legs="Sulevia's cuisses +2",
   feet="Flamma Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
   left_ear="Cessance Earring",
    right_ear="Sherida earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
   back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},

	})
	
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, { 
	
	    ammo="Knobkierrie",
    head="Ynglinga Sallet",
    body="Sulevia's Plate. +2",
    hands="Pteroslaver Finger Gauntlets +3",
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	 
	})

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {  
	ammo="Knobkierrie",
     head={ name="Valorous Mask", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','INT+8','Attack+13',}},
    body={ name="Valorous Mail", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','STR+7','Accuracy+8',}},
    hands="Pteroslaver Finger Gauntlets +3",
    legs="Vishap Brais +3",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Sherida earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
   back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},

    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
    ammo="Knobkierrie",
    head="Hjarrandi Helm",
    body="Sulevia's Platemail +2",
    hands="Sulevia's Gauntlets +2",
    legs="Vishap Brais +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {       ammo="Knobkierrie",
    ammo="Knobkierrie",
    head="Hjarrandi Helm",
    body="Sulevia's Platemail +2",
    hands="Sulevia's Gauntlets +2",
    legs="Vishap Brais +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},

    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {       ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','INT+8','Attack+13',}},
    body="Sulevia's Plate. +2",
    hands="Flam. Manopolas +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Mache Earring",
    right_ear="Sherida earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},

    })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {  head="Ynglinga sallet",     })

	sets.precast.WS['Leg Sweep'] =  {   ammo="Pemphredo Tathlum",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Gwati Earring",
    right_ear="Digni. Earring",
    left_ring="Flamma Ring",
    right_ring="Sangoma Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},   }
	
	sets.precast.WS['Savage Blade'] = {
	       ammo="Knobkierrie",
    head="Hjarrandi Helm",
    body="Gleti's cuirass",
    hands="Flam. Manopolas +2",
    legs="Sulev. Cuisses +2",
    feet="Sulevia's Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Thrud earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}},

    }
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
    ammo="Staunch Tathlum +1",
     head={ name="Valorous Mask", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','INT+8','Attack+13',}},
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Sanctity Necklace",
    waist="Gishdubar sash",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }
	

	-- Idle sets
	sets.idle = {  
	ammo="Coiste Bodhar",
    head="Hjarrandi Helm",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bathy Choker +1",
    waist="Ioskeha Belt +1",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Sheltered Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
    ammo="Coiste Bodhar",
    head="Hjarrandi Helm",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Bathy Choker +1",
    waist="Ioskeha Belt +1",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Sheltered Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {

    })

    sets.idle.Regen = set_combine(sets.idle.Field, {

    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
    ammo="Ginsen",
    head="Hjarrandi Helm",
    body="Hjarrandi Breast.",
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs={ name="Valor. Hose", augments={'Accuracy+19','"Dbl.Atk."+5','VIT+6','Attack+5',}},
    feet="Flam. Gambieras +2",
    neck="Shulmanu Collar",
    waist="Tempus Fugit",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
         ammo="Staunch Tathlum +1",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Lissome Necklace",
    waist="Tempus Fugit",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {    sub="Utu Grip",
    ammo="Coiste Bodhar",
    head="Hjarrandi Helm",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    neck="Asperity Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Dignitary's Earring",
    right_ear="Sherida earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
     back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},

    }

	sets.engaged.Mid = set_combine(sets.engaged, {
    sub="Utu Grip",
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'"Store TP"+8','Accuracy+13','Attack+2',}},
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Flamma dirs +2",
    feet="Flam. Gambieras +2",
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
	  ammo="Amar Cluster",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'"Store TP"+8','Accuracy+13','Attack+2',}},
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs="Flamma dirs +2",
    feet="Flam. Gambieras +2",
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
         ammo="Ginsen",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Anu Torque",
    waist="Tempus Fugit",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })
	
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
     ammo="Staunch Tathlum +1",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Lissome Necklace",
    waist="Tempus Fugit",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })
	
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
     ammo="Ginsen",
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Lissome Necklace",
    waist="Tempus Fugit",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Defending Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    })

    sets.engaged.War = set_combine(sets.engaged, {    sub="Utu Grip",
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Valorous Mail", augments={'"Store TP"+8','Accuracy+13','Attack+2',}},
    hands="Flam. Manopolas +2",
    legs={ name="Valor. Hose", augments={'Accuracy+19','"Dbl.Atk."+5','VIT+6','Attack+5',}},
    feet="Flam. Gambieras +2",
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Brutal Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},

    })
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {

    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.midcast['Elemental Magic'], {waist="Hachirin-No-Obi"})
        end
    end
end
------------------------------------------------------------------------------


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end

function job_post_precast(spell, action, spellMap, eventArgs)
  
    if spell.action_type=="Magic" and buffactive.Silence then
        eventArgs.cancel = true
        send_command('input /item "Remedy" <me>')
    end
    if spell.type=='WeaponSkill' then
        if moonshade_WS:contains(spell.english) and player.tp<2850 then
            equip({left_ear="Moonshade Earring"})
        end
    end
end


--Gav helm

-------------------------------
--   WS Chart For Gavialis   --
-------------------------------
 
check_ws_day = {
Firesday = S {'Liquefaction','Fusion','Light'},
Earthsday= S {'Scission','Gravitation','Darkness'},
Watersday = S {'Reverberation','Distortion','Darkness'},
Windsday = S {'Detonation','Fragmentation','Light'},
Iceday = S {'Induration','Distortion','Darkness'},
Lightningsday = S {'Impaction','Fragmentation','Light'},
Lightsday = S {'Transfixion','Fusion','Light'},
Darksday = S {'Compression','Gravitation','Darkness'},}

function job_post_precast(spell, action, spellMap, eventArgs)
   if spell.english == 'Stardiver' and Stardiver_ind ~= 1 and (check_ws_day[world.day]:contains(spell.skillchain_a) -- Remove the and _ind ~=1 (not equal) for Gavialis if you don't have Ptero +2/3.
    or check_ws_day[world.day]:contains(spell.skillchain_b)
    or check_ws_day[world.day]:contains(spell.skillchain_c)) then
    equip(sets.WSDayBonus)
  end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(7,5)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 4')
end