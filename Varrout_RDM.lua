-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Local Settings, setting the zones prior to use
toau_zones = 
S{
    "Leujaoam Sanctum",             --  Assault
    "Mamool Ja Training Grounds",   --  Assault
    "Lebros Cavern",                --  Assault
    "Periqia",                      --  Assault
    "Ilrusi Atoll",                 --  Assault
    "Nyzul Isle",                   --  Assault
    "Bhaflau Remnants",             --  Salvage
    "Arrapago Remnants",            --  Salvage
    "Silver Sea Remnants",          --  Salvage
    "Zhayolm Remnants"              --  Salvage
}

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    -- gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()

    state.CP = M(false, "CP Mode")
    state.Dyna = M(false, "Dyna Mode")

	send_command('bind @c gs c toggle CP')
    send_command('bind @x gs c toggle Dyna')
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    --  Toggle specific gear
    sets.CP      = { back={ name="Mecisto. Mantle", 
                            augments={'Cap. Point+31%','INT+2','Attack+3','DEF+8',}},}
    sets.JSENeck = { neck="Duelist's Torque"}

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {
        body = "Vitivation Tabard"
    }
    

    -- Fast cast sets for spells
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast       NEED TO RE-CALCULATE
    -- No other FC sets necessary.
    sets.precast.FC = {
        main        = "Bolelabunga",
        sub         = "Genbu's Shield",
        ammo        = "Homiliary",
        head        = "Atrophy Chapeau",
        body        = { name="Vitiation Tabard", 
                        augments={'Enhances "Chainspell" effect',}},
        hands       = { name="Leyline Gloves", 
                        augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
        legs        = { name="Kaykaus Tights", 
                        augments={'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet        = "Chelona Boots",
        neck        = "Sanctity Necklace",
        waist       = "Witful Belt",
        left_ear    = "Loquac. Earring",
        right_ear   = "Estq. Earring",
        left_ring   = "Kishar Ring",
        right_ring  = "Defending Ring",
        back        = "Perimede Cape",
    }

    sets.midcast.Cure = {
        main        = { name="Arka IV", 
                        augments={'"Cure" potency +24%',}},
        sub         = "Enki Strap",
        ammo        = "Quartz Tathlum +1",
        head        = { name="Vanya Hood", 
                        augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = { name="Kaykaus Bliaut", 
                        augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands       = { name="Chironic Gloves", 
                        augments={'AGI+4','Crit.hit rate+1','"Refresh"+1','Accuracy+1 Attack+1',}},
        legs        = "Atrophy Tights +1",
        feet        = { name="Vanya Clogs", 
                        augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck        = "Colossus's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Mendi. Earring",
        left_ring   = "Janniston Ring",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }
        
    sets.midcast.Curaga = sets.midcast.Cure
    -- sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {
        main        = "Bolelabunga",
        sub         = "Genbu's Shield",
        ammo        = "Homiliary",
        head        = "Umuthi Hat",
        body        = { name = "Vitiation Tabard", 
                        augments = {'Enhances "Chainspell" effect',}},
        hands       = { name = "Telchine Gloves", 
                        augments = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        legs        = "Atrophy Tights +1",
        feet        = "Estq. Houseaux +2",
        neck        = "Colossus's Torque",
        waist       = "Olympus Sash",
        left_ear    = "Augment. Earring",
        right_ear   = "Andoaa Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Stikini Ring",
        back        = "Estoqueur's Cape",
    }

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        legs="Estoqueur's Fuseau +2"
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Siegel Sash"
    })
    
    sets.midcast['Enfeebling Magic'] = {
        main        = "Bolelabunga",
        sub         = "Genbu's Shield",
        ammo        = "Homiliary",
        head        = { name="Vitiation Chapeau", 
                        augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
        body        = "Atrophy Tabard",
        hands       = "Jhakri Cuffs +1",
        legs        = "Jhakri Slops",
        feet        = "Uk'uxkaj Boots",
        neck        = "Duelist's Torque",
        waist       = "Casso Sash",
        left_ear    = "Lifestorm Earring",
        right_ear   = "Psystorm Earring",
        left_ring   = "Sheltered Ring",
        right_ring  = "Capacity Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast['Phalanx II']  = set_combine(sets.midcast['Enhancing Magic'],  {hands = "Duelist's Gloves +2"})
    sets.midcast['Dia III']     = set_combine(sets.midcast['Enfeebling Magic'], {head  = "Vitivation Chapeau"})
    sets.midcast['Slow II']     = set_combine(sets.midcast['Enfeebling Magic'], {head  = "Vitivation Chapeau"})
    sets.midcast['Blind II']    = set_combine(sets.midcast['Enfeebling Magic'], {legs  = "Duelist's Tights +2"})
    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet  = "Vitiation Boots"})
    
    sets.midcast['Elemental Magic'] = {
        main        = "Lehbrailg +2",
        sub         = "Zuuxowu Grip",
        ammo        = "Dosis Tathlum",
        head        = "Hagondes Hat",
        neck        = "Eddy Necklace",
        ear1        = "Friomisi Earring",
        ear2        = "Hecate's Earring",
        body        = "Hagondes Coat",
        hands       = "Yaoyotl Gloves",
        ring1       = "Icesoul Ring",
        ring2       = "Acumen Ring",
        back        = "Toro Cape",
        waist       = gear.ElementalObi,
        legs        = "Hagondes Pants",
        feet        = "Hagondes Sabots"
    }
        
    -- sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
        main        = "Lehbrailg +2",
        sub         = "Mephitis Grip",
        ammo        = "Kalboron Stone",
        head        = "Atrophy Chapeau",
        neck        = "Weike Torque",
        ear1        = "Lifestorm Earring",
        ear2        = "Psystorm Earring",
        body        = "Vanir Cotehardie",
        hands       = "Gendewitha Gages",
        ring1       = "Prolix Ring",
        ring2       = "Sangoma Ring",
        back        = "Refraction Cape",
        waist       = "Goading Belt",
        legs        = "Bokwus Slops",
        feet        = "Bokwus Boots"
    }

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ring1       = "Excelsis Ring", 
        waist       = "Fucho-no-Obi"
    })

    sets.midcast.Aspir = sets.midcast.Drain

    -- Sets for special buff conditions on spells.
    -- sets.midcast.EnhancingDuration = {hands="Atrophy Gloves +1",back="Estoqueur's Cape",feet="Lethargy Houseaux"}
        
    sets.buff.ComposureOther = {
        head        = "Lethargy Chappel",
        body        = "Lethargy Sayon",
        hands       = "Lethargy Gantherots",
        legs        = "Estoqueur's Fuseau +2",
        feet        = "Lethargy Houseaux"
    }

    sets.buff.Saboteur = {hands="Lethargy Gantherots"}

    -- Sets to return to when not performing an action.
    -- Resting sets
    sets.resting = {
        main        = "Boonwell Staff",
        sub         = "Ariesian Grip",
        ammo        = "Mana Ampulla",
        head        = { name="Vitiation Chapeau", 
                        augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
        body        = "Chelona Blazer",
        hands       = "Nares Cuffs",
        legs        = "Nisse Slacks",
        feet        = "Chelona Boots",
        neck        = "Eidolon Pendant +1",
        waist       = "Austerity Belt",
        left_ear    = { name="Moonshade Earring", 
                        augments={'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = "Infused Earring",
        left_ring   = "Angha Ring",
        right_ring  = "Star Ring",
        back        = "Felicitas Cape",
    }

    -- Idle sets
    sets.idle = {
        main        = "Bolelabunga",
        sub         = "Genbu's Shield",
        ammo        = "Homiliary",
        head        = { name="Vitiation Chapeau", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
        body        = Jhakri Robe +2,
        hands       = { name="Chironic Gloves", augments={'"Mag.Atk.Bns."+9','Attack+1','"Refresh"+1','Accuracy+13 Attack+13','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
        legs        = { name="Chironic Hose", augments={'INT+5','Enmity-3','"Refresh"+1','Accuracy+11 Attack+11',}},
        feet        = { name="Chironic Slippers", augments={'Mag. Acc.+12','"Fast Cast"+3','"Refresh"+1','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
        neck        = "Sanctity Necklace",
        waist       = "Fucho-no-Obi",
        left_ear    = { name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = "Infused Earring",
        left_ring   = "Sheltered Ring",
        right_ring  = "Defending Ring",
        back        = "Solemnity Cape",
    }

    -- sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
    --     head="Atrophy Chapeau +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Atrophy Tabard +1",hands="Atrophy Gloves +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --     back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}
    
    -- sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
    --     head="Vitivation Chapeau",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Atrophy Tabard +1",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --     back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Hagondes Sabots"}

    -- sets.idle.PDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
    --     head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut +1",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
    --     back="Shadow Mantle",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}

    -- sets.idle.MDT = {main="Bolelabunga",sub="Genbu's Shield",ammo="Demonry Stone",
    --     head="Gendewitha Caubeen +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Caubeen +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
    --     back="Engulfer Cape",waist="Flume Belt",legs="Osmium Cuisses",feet="Gendewitha Galoshes"}
    
    
    -- Defense sets
    -- sets.defense.PDT = {
    --     head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Hagondes Coat",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
    --     back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants",feet="Gendewitha Galoshes"}

    -- sets.defense.MDT = {ammo="Demonry Stone",
    --     head="Atrophy Chapeau +1",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Atrophy Tabard +1",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
    --     back="Engulfer Cape",waist="Flume Belt",legs="Bokwus Slops",feet="Gendewitha Galoshes"}

    -- sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}
    sets.ToAU = {right_ring="Balrahn's Ring"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    -- elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
    --     equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
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

    if state.Dyna.current == 'on' then
        equip(sets.JSENeck)
        disable('neck')
    else
        enable('neck')
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    if toau_zones:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 9)
end
