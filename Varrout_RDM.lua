-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Saboteur"] = buffactive["Saboteur"] or false
    state.Buff["Composure"] = buffactive["Composure"] or false
    state.Buff["Chainspell"] = buffactive["Chainspell"] or false
    state.Buff["Spontaneity"] = buffactive["Spontaneity"] or false
    state.Buff["Stymie"] = buffactive["Stymie"] or false

    state.Buff["Divine Seal"] = buffactive["Divine Seal"] or false

    -- state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- state.OffenseMode:options('None', 'Normal')
    -- state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    -- state.CastingMode:options('Normal', 'Resistant')
    -- state.IdleMode:options('Normal', 'PDT', 'MDT')

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
    sets.CP      = { back = { name     = "Mecisto. Mantle",
                              augments = {'Cap. Point+31%','INT+2','Attack+3','DEF+8',}},}
    sets.JSENeck = { neck = "Duelist's Torque"}

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {
        body = "Vitiation Tabard"
    }


    -- Fast cast sets for spells
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast       NEED TO RE-CALCULATE
    -- No other FC sets necessary.
    sets.precast.FC = {
        main        = "Bolelabunga",
        sub         = "Genmei Shield",
        ammo        = "Homiliary",
        head        = "Atrophy Chapeau +2",
        body        = "Vitiation Tabard",
        hands       = { name     = "Leyline Gloves",
                        augments = {'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
        legs        = { name     = "Kaykaus Tights",
                        augments = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
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
        main        = { name     = "Arka IV",
                        augments = {'"Cure" potency +24%',}},
        sub         = "Enki Strap",
        ammo        = "Quartz Tathlum +1",
        head        = { name     = "Vanya Hood",
                        augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = { name     = "Kaykaus Bliaut",
                        augments = {'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
        hands       = { name     = "Chironic Gloves",
                        augments = {'AGI+4','Crit.hit rate+1','"Refresh"+1','Accuracy+1 Attack+1',}},
        legs        = "Atrophy Tights +1",
        feet        = { name     = "Vanya Clogs",
                        augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck        = "Colossus's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Meili Earring",
        right_ear   = "Mendi. Earring",
        left_ring   = "Janniston Ring",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure
    -- sets.midcast.CureSelf = {ring1 = "Kunaji Ring",ring2 = "Asklepian Ring"}

    sets.midcast.NASpell = {
        main       = "Oranyan",
        sub        = "Clerisy Strap",
        ammo       = "Regal Gem",
        head       = { name     = "Vanya Hood",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body       = { name     = "Vitiation Tabard",
                       augments = {'Enhances "Chainspell" effect',}},
        hands      = "Shrieker's Cuffs",
        legs       = "Atrophy Tights +2",
        feet       = { name     = "Vanya Clogs",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck       = "Colossus's Torque",
        waist      = "Bishop's Sash",
        left_ear   = "Meili Earring",
        right_ear  = "Beatific Earring",
        left_ring  = "Menelaus's Ring",
        right_ring = "Sirona's Ring",
        back       = "Merciful Cape",
    }

    sets.midcast["Cursna"] = set_combine(sets.midcast.NASpell, {
        hands = "Leyline Gloves",
        neck = "Debilis Medallion",
        right_ring = "Haoma's Ring",
        back = "Oretania's Cape +1",
    })

    sets.midcast['Enhancing Magic'] = {
        main        = "Oranyan",
        sub         = "Clerisy Strap",
        ammo        = "Homiliary",
        head        = "Befouled Crown",
        body        = { name     = "Vitiation Tabard",
                        augments = {'Enhances "Chainspell" effect',}},
        hands       = "Atrophy Gloves +2",
        legs        = { name     = "Telchine Braconi",
                        augments = {'Enh. Mag. eff. dur. +9',}},
        feet        = "Lethargy Houseaux +1",       --  +30% enhancing magic duration
        neck        = { name     = "Duelist's Torque",
                        augments = {'Path: A',}},
        waist       = "Embla Sash",
        left_ear    = "Mimir Earring",
        right_ear   = "Snotra Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Kishar Ring",
        back        = { name     = "Sucellos's Cape",
                        augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    }

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        body = "Atrophy Tabard +2",
        legs = "Lethargy Fuseau +1"
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck = "Nodens Gorget",
        waist = "Siegel Sash",
        right_ear = "Earthcry Earring",
        legs = "Shedir Seraweels",
    })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main = "Bolelabunga",
        sub  = "Ammurapi Shield",
    })

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
        main       = "Oranyan",                  --  Enhancing Magic durtion +10%
        sub        = "Fulcio Grip",                 --  Enhancing magic +3
        head       = "Chironic Hat",                --  Aquaveil +1
        legs       = "Shedir Seraweels",            --  Enhances Aquaveil
    })

    sets.midcast['BarElement'] = set_combine(sets.midcast['Enhancing Magic'], {
        main = "Oranyan",   --  Enhancing Magic durtion +10%
        sub        = "Fulcio Grip",                 --  Enhancing magic +3
        ammo = "Regal Gem",
        head = "Befouled Crown",
        neck = "Colossus's Torque",
        left_ear = "Mimir Earring",
        right_ear = "Etiolation Earring",
        body = "Vitiation Tabard",
        hands = "Vitiation Gloves",
        left_ring = "Stikini Ring",
        right_ring = "Stikini Ring",
        back = "Fi Follet Cape",
        wasit = "Olympus Sash",
        legs = "Shedir Seraweels",
        feet = "Lethargy Houseaux +1",
    })

    -- sets.midcast['Enfeebling Magic'] = {
    sets.midcast.enfeeblingBase = {
        main        = "Oranyan",
        sub         = "Enki Strap",
        ammo        = "Regal Gem",
        head        = { name = "Vitiation Chapeau +1",
                        augments = {'Enfeebling Magic duration','Magic Accuracy',}},
        body        = "Atrophy Tabard +2",
        hands       = "Jhakri Cuffs +2",
        legs        = "Jhakri Slops +2",
        feet        = { name = "Vitiation Boots",
                        augments = {'Immunobreak Chance',}},
        neck        = { name     = "Duelist's Torque",
                        augments = {'Path: A',}},
        waist       = "Luminary Sash",
        left_ear    = "Digni. Earring",
        right_ear   = "Snotra Earring",
        left_ring   = "Stikini Ring",
        right_ring  = "Kishar Ring",
        back       = "Aurist's Cape +1",            --  +32 Magic Accuracy
    }

    -- sets.midcast.enfeeblingMNDCape = {
    --     back = { name     = "Sucellos's Cape",
    --              augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
    -- }

    -- sets.midcast.enfeeblingINTCape = {
    --     back = { name     = "Sucellos's Cape",
    --              augments = {'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
    -- }


    sets.midcast['Phalanx II']  = set_combine(sets.midcast['Enhancing Magic'],  {hands = "Duelist's Gloves +2"})

    sets.midcast['Elemental Magic'] = {
        main="Oranyan",
        sub="Thrace Strap",
        ammo="Regal Gem",
        head="Jhakri Coronal +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Mizu. Kubikazari",
        waist="Aswang Sash",
        left_ear="Lifestorm Earring",
        right_ear="Psystorm Earring",
        left_ring="Freke Ring",
        right_ring="Jhakri Ring",
        back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
    }

    -- sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body = "Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
        main        = "Lehbrailg +2",
        sub         = "Mephitis Grip",
        ammo        = "Kalboron Stone",
        head        = "Atrophy Chapeau +2",
        neck        = "Weike Torque",
        ear1        = "Lifestorm Earring",
        ear2        = "Psystorm Earring",
        body        = "Vanir Cotehardie",
        hands       = "Gendewitha Gages",
        ring1       = "Prolix Ring",
        ring2       = "Sangoma Ring",
        back       = "Aurist's Cape +1",            --  +32 Magic Accuracy
        waist       = "Luminary Sash",
        legs        = "Bokwus Slops",
        feet        = "Bokwus Boots"
    }

    sets.midcast["Stun"] = {
        main="Oranyan",
        sub="Enki Strap",
        ammo="Regal Gem",
        head="Atro. Chapeau +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        waist="Luminary Sash",
        left_ear="Lifestorm Earring",
        left_ear   = "Malignance Earring",          --  +10 Magic Accuracy
        right_ear  = "Snotra Earring",           --  +10 Magic Accuracy
        right_ring="Stikini Ring",
        back       = "Aurist's Cape +1",            --  +32 Magic Accuracy
    }


    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ring1       = "Excelsis Ring",
        waist       = "Fucho-no-Obi"
    })

    sets.midcast.Aspir = sets.midcast.Drain

    -- Sets for special buff conditions on spells.
    -- sets.midcast.EnhancingDuration = {hands = "Atrophy Gloves +1",back = "Estoqueur's Cape",feet = "Lethargy Houseaux"}

    sets.buff.ComposureOther = {
        head        = "Lethargy Chappel +1",
        body        = "Lethargy Sayon",
        hands       = "Lethargy Gantherots",
        legs        = "Lethargy Fuseau +1",
        feet        = "Lethargy Houseaux +1"
    }

    sets.buff["Saboteur"] = {hands = "Lethargy Gantherots"}

    -- Sets to return to when not performing an action.
    -- Resting sets
    sets.resting = {
        main        = "Boonwell Staff",
        sub         = "Ariesian Grip",
        ammo        = "Mana Ampulla",
        head        = "Vitiation Chapeau +1",
        body        = "Chelona Blazer",
        hands       = "Nares Cuffs",
        legs        = "Nisse Slacks",
        feet        = "Chelona Boots",
        neck        = "Eidolon Pendant +1",
        waist       = "Austerity Belt",
        left_ear    = { name     = "Moonshade Earring",
                        augments = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = "Infused Earring",
        left_ring   = "Angha Ring",
        right_ring  = "Star Ring",
        back        = "Felicitas Cape"
    }

    -- Idle sets
    sets.idle = {
        main={ name="Mpaca's Staff", augments={'Path: A',}},
        sub="Enki Strap",
        ammo="Homiliary",
        head={ name="Viti. Chapeau +1", augments={'Enfeebling Magic duration','Magic Accuracy',}},
        body="Jhakri Robe +2",
        hands={ name="Chironic Gloves", augments={'Pet: MND+10','Attack+5','"Refresh"+2','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
        legs={ name="Chironic Hose", augments={'INT+5','Enmity-3','"Refresh"+1','Accuracy+11 Attack+11',}},
        feet={ name="Chironic Slippers", augments={'Pet: DEX+15','VIT+8','"Refresh"+2','Accuracy+12 Attack+12',}},
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Fucho-no-Obi",
        left_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        right_ear="Infused Earring",
        left_ring="Sheltered Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.engaged = {
        ammo="Voluspa Tathlum",
        head="Jhakri Coronal +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Asperity Necklace",
        waist="Fucho-no-Obi",
        left_ear="Sherida Earring",
        right_ear="Digni. Earring",
        left_ring="Jhakri Ring",
        right_ring="Rajas Ring",
        -- back="",
    }

    -- sets.idle.Town = {main = "Bolelabunga",sub = "Genmei Shield",ammo = "Impatiens",
    --     head = "Atrophy Chapeau +1",neck = "Wiglen Gorget",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Atrophy Tabard +1",hands = "Atrophy Gloves +1",ring1 = "Sheltered Ring",ring2 = "Paguroidea Ring",
    --     back = "Shadow Mantle",waist = "Flume Belt",legs = "Crimson Cuisses",feet = "Hagondes Sabots"}

    -- sets.idle.Weak = {main = "Bolelabunga",sub = "Genmei Shield",ammo = "Impatiens",
    --     head = "Vitivation Chapeau",neck = "Wiglen Gorget",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Atrophy Tabard +1",hands = "Serpentes Cuffs",ring1 = "Sheltered Ring",ring2 = "Paguroidea Ring",
    --     back = "Shadow Mantle",waist = "Flume Belt",legs = "Crimson Cuisses",feet = "Hagondes Sabots"}

    -- sets.idle.PDT = {main = "Bolelabunga",sub = "Genmei Shield",ammo = "Demonry Stone",
    --     head = "Gendewitha Caubeen +1",neck = "Twilight Torque",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Gendewitha Bliaut +1",hands = "Gendewitha Gages",ring1 = "Defending Ring",ring2=gear.DarkRing.physical,
    --     back = "Shadow Mantle",waist = "Flume Belt",legs = "Osmium Cuisses",feet = "Gendewitha Galoshes"}

    -- sets.idle.MDT = {main = "Bolelabunga",sub = "Genmei Shield",ammo = "Demonry Stone",
    --     head = "Gendewitha Caubeen +1",neck = "Twilight Torque",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Gendewitha Caubeen +1",hands = "Yaoyotl Gloves",ring1 = "Defending Ring",ring2 = "Shadow Ring",
    --     back = "Engulfer Cape",waist = "Flume Belt",legs = "Osmium Cuisses",feet = "Gendewitha Galoshes"}


    -- Defense sets
    -- sets.defense.PDT = {
    --     head = "Atrophy Chapeau +1",neck = "Twilight Torque",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Hagondes Coat",hands = "Gendewitha Gages",ring1 = "Defending Ring",ring2=gear.DarkRing.physical,
    --     back = "Shadow Mantle",waist = "Flume Belt",legs = "Hagondes Pants",feet = "Gendewitha Galoshes"}

    -- sets.defense.MDT = {ammo = "Demonry Stone",
    --     head = "Atrophy Chapeau +1",neck = "Twilight Torque",ear1 = "Bloodgem Earring",ear2 = "Loquacious Earring",
    --     body = "Atrophy Tabard +1",hands = "Yaoyotl Gloves",ring1 = "Defending Ring",ring2 = "Shadow Ring",
    --     back = "Engulfer Cape",waist = "Flume Belt",legs = "Bokwus Slops",feet = "Gendewitha Galoshes"}

    -- sets.Kiting = {legs = "Crimson Cuisses"}

    sets.latent_refresh = {waist = "Fucho-no-obi"}
    sets.ToAU = {right_ring = "Balrahn's Ring"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    check_if_silenced(spell, eventArgs)

    -- if spell.action_type == 'Magic' and buffactive['Silence'] then
    --     -- If silenced, use what's available to remove it
    --     cancel_spell()
    --     if player.inventory['Catholicon'] ~= nil then
    --         send_command('input /item "Catholicon" <me>')
    --         send_command('input /echo *!! Silenced ~ Using Catholicon @ '..player.inventory['Catholicon'].count..' Left !!*')
    --     elseif player.inventory['Echo Drops'] ~= nil then
    --         send_command('input /item "Echo Drops" <me>')
    --         send_command('input /echo *!! Silenced ~ Using Echo Drops @ '..player.inventory['Echo Drops'].count..' Left !!*')
    --     elseif player.inventory['Remedy'] ~= nil then
    --         send_command('input /item "Remedy" <me>')
    --         send_command('input /echo *!! Silenced ~ Using Remedy @ '..player.inventory['Remedy'].count..' Left !!*')
    --     else
    --         send_command('input /echo *!! Silenced ~ No items to remove it !!*')
    --     end
    --     eventArgs.cancel = true
    --     return
    -- elseif

    if spell.type == "Trust" then
        equip(sets.Trust)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' then
        -- outputString = "Enfeebling: "
        enfeebling_set = sets.midcast.enfeeblingBase
        -- if enfeebling_int:contains(spellMap) then
        --     -- outputString = outputString .. "INT Based"
        --     enfeebling_set = set_combine(enfeebling_set, sets.midcast.enfeeblingINTCape)
        -- else
        --     -- outputString = outputString .. "MND Based"
        --     enfeebling_set = set_combine(enfeebling_set, sets.midcast.enfeeblingMNDCape)
        -- end
        if state.Buff["Saboteur"] then
            outputString = outputString .. " :: Saboteur Active"
            enfeebling_set = set_combine(enfeebling_set, sets.buff["Saboteur"])
        end
        -- windower.add_to_chat(8, outputString)
        equip(enfeebling_set)
    elseif spell.skill == 'Enhancing Magic' then
        local enhancing_set = sets.midcast.EnhancingDuration
        -- equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            enhancing_set = set_combine(enhancing_set, sets.buff.ComposureOther)
        elseif spellMap == "BarElement" then
            enhancing_set = sets.midcast["BarElement"]
        end
        if spellMap == "Refresh" then
            enhancing_set = sets.midcast.Refresh
            if spell.target.type == 'SELF' then
                enhancing_set = set_combine(enhancing_set, {
                    feet = "Inspirited Boots"
                })
            end
        end
        equip(enhancing_set)
    -- elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
    --     equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
-- function job_state_change(stateField, newValue, oldValue)
--     if stateField == 'Offense Mode' then
--         if newValue == 'None' then
--             enable('main','sub','range')
--         else
--             disable('main','sub','range')
--         end
--     end
-- end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    check_special_ring_equipped()

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

    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function status_change(new,old)
    if new == 'Engaged' then
        equip(sets.engaged)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 9)
    send_command('wait 2.5; input /lockstyleset 005')
end

function check_if_silenced(spell, eventArgs)
    if spell.action_type == 'Magic' and buffactive['Silence'] then
        -- If silenced, use what's available to remove it
        cancel_spell()
        if player.inventory['Catholicon'] ~= nil then
            send_command('input /item "Catholicon" <me>')
            send_command('input /echo *!! Silenced ~ Using Catholicon @ '..player.inventory['Catholicon'].count..' Left !!*')
        elseif player.inventory['Echo Drops'] ~= nil then
            send_command('input /item "Echo Drops" <me>')
            send_command('input /echo *!! Silenced ~ Using Echo Drops @ '..player.inventory['Echo Drops'].count..' Left !!*')
        elseif player.inventory['Remedy'] ~= nil then
            send_command('input /item "Remedy" <me>')
            send_command('input /echo *!! Silenced ~ Using Remedy @ '..player.inventory['Remedy'].count..' Left !!*')
        else
            send_command('input /echo *!! Silenced ~ No items to remove it !!*')
        end
        eventArgs.cancel = true
        return
    end
end