function get_sets()
    mote_include_version = 2

    --  Load and initialise include file(s)
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')

    --  Make sure all gear is unlocked after character swap
    equipment_unlock_all()
end

--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()

end

--  ----------------------------------------------------------------------------------------------------
--
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    -- state.OffenseMode:options('Normal')
    -- state.HybridMode:options('Normal')
    -- state.CastingMode:options('Normal')
    -- state.IdleMode:options('Normal')

    --  Which macro book to default to when changing jobs
    -- select_default_macro_book(false)

    --  Special states to track for White Mage
    state.CP = M(false, "CP Mode")              --  CP Mode: WHM is mastered, so likely won't need this anymore
    state.Dynamis = M(false, "Dynamis Mode")    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.Debug = M(false, "Debug Mode")        --  Debug Mode: Helpful for outputting information in the LUA. Not set up
    -- state.OhShi = M(false, "OhShi Mode")
    -- state.Weapons = M(false, "Weapons Mode")

    --  Where @ is the Windows Key
    send_command('bind @c gs c toggle CP')      --  Windows Key + C: Toggle CP Mode
    send_command('bind @x gs c toggle Dynamis') --  Windows Key + X: Toggle Dynamis Mode
    send_command('bind @m input /map')          --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind @1 gs c rr4')            --  Windows Key + 1: Reraise 4
    send_command('bind @z gs c toggle Debug')   --  Windows Key + z: Togger Debug Mode
    -- send_command('bind @v gs c toggle OhShi')   --  Windows Key + v: Toggle OhShi Mode. Good for kiting
    -- send_command('bind @n gs c toggle Weapons')
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @m')
    send_command('unbind @1')
    send_command('unbind @z')
    -- send_command('unbind @v')
    -- send_command('unbind @n')
end

function init_gear_sets()
    sets.latent_refresh = {}
    sets.ToAU = {}
    sets.Adoulin = {}
    --  Gear sets for specific conditions and commands
    --  Neck equipment to lock in while in dynamis
    sets.JSENeck = {
        neck       = "",
    }

    sets.CapacityPoints = {
        back = "Mecistopins Mantle",
    }
    -- --  Equipment that enhances the charge rate of Sublimation
    -- sets.Sublimation = {
    --     waist      = "Embla Sash"
    -- }

    -- --  Equipment only active during reives
    -- sets.Reives = {
    --     neck       = "Arciela's Grace +1"
    -- }

    --  Set for summoning Trusts. All iLevel 119
    sets.Trust = {
        -- main       = "Bolelabunga",
        -- sub        = "Ammurapi Shield",
        -- ammo       = "Homiliary",
        -- head       = "Inyanga Tiara +2",
        -- body       = "Inyanga Jubbah +2",
        -- hands      = "Inyanga Dastanas +2",
        -- legs       = "Inyanga Shalwar +2",
        -- feet       = "Inyanga Crackows +2"
    }

    sets.idle={
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Befouled Crown",
        body="Azimuth Coat",
        hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
        legs="Assiduity Pants",
        feet="Geomancy Sandals",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Renaye Ring",
        right_ring="Fortified Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Pet: "Regen"+5',}},
    }

    sets.idle.Pet = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Azimuth Hood",
        body="Azimuth Coat",
        hands="Geomancy Mitaines",
        legs="Psycloth Lappas",
        feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
        neck={ name="Bagua Charm", augments={'Path: A',}},
        waist="Isa Belt",
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Renaye Ring",
        right_ring="Stikini Ring",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -1%','Damage taken-3%',}},
    }

    sets.precast = {}

    sets.precast["Full Circle"] = {
        head = "Azimuth Hood",
    }

    sets.precast.FC = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Befouled Crown",
        body="Azimuth Coat",
        hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
        legs="Geomancy Pants",
        feet="Regal Pumps",
        neck="Loricate Torque",
        waist="Eschan Stone",
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Pet: "Regen"+5',}},
    }

    -- sets.precast['Geomancy'] = set_combine(sets.precast.FC, {
    --     main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    --     sub="Culminus",
    --     range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    --     head="Azimuth Hood",
    --     body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    --     hands="Geomancy Mitaines",
    --     legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
    --     feet="Azimuth Gaiters",
    --     neck={ name="Bagua Charm", augments={'Path: A',}},
    --     waist="Eschan Stone",
    --     left_ear="Infused Earring",
    --     right_ear="Loquac. Earring",
    --     left_ring="Renaye Ring",
    --     right_ring="Stikini Ring",
    --     back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -1%','Damage taken-3%',}},
    -- })

    sets.precast['Enhancing Magic'] = {}
    sets.precast['Stoneskin'] = {}
    sets.precast['Healing Magic'] = {}
    sets.precast['Cure'] = {}
    sets.precast['Curaga'] = sets.precast['Cure']

    sets.midcast = {}

    sets.midcast.Cure = {}
    sets.midcast.CureBonus = {}

    sets.midcast.FC = {
        main="Solstice",
        sub="Culminus",
        range="Dunna",
        head="Jhakri Coronal +1",
        neck="Bagua Charm",
        left_ear="Lifestorm Earring",
        right_ear="Psystorm Earring",
        body="Azimuth Coat",
        hands="Jhakri Cuffs +1",
        left_ring="Stikini Ring",
        right_ring="Etana Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Pet: "Regen"+5',}},
        waist="Eschan Stone",
        legs="Psycloth Lappas",
        feet="Jhakri Pigaches +1",
    }

    sets.midcast["Enfeebling Magic"] = sets.midcast.FC
    -- sets.midcast.FC = {
    --     main="",
    --     sub="",
    --     range="",
    --     head="",
    --     neck="",
    --     left_ear="",
    --     right_ear="",
    --     body="",
    --     hands="",
    --     left_ring="",
    --     right_ring="",
    --     back="",
    --     waist="",
    --     legs="",
    --     feet="",
    -- }

    sets.midcast['IndiSpell'] = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Azimuth Hood",
        body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
        hands="Geomancy Mitaines",
        legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
        feet="Azimuth Gaiters",
        neck={ name="Bagua Charm", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Renaye Ring",
        right_ring="Stikini Ring",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -1%','Damage taken-3%',}},
    }
    
    sets.midcast['GeoSpell'] = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Azimuth Hood",
        body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
        hands="Geomancy Mitaines",
        legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
        feet="Azimuth Gaiters",
        neck={ name="Bagua Charm", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Infused Earring",
        right_ear="Loquac. Earring",
        left_ring="Renaye Ring",
        right_ring="Stikini Ring",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +15','Pet: Damage taken -1%','Damage taken-3%',}},
    }

    sets.midcast.MagicAccuracy = {

    }

    sets.midcast['Elemental Magic'] = {
        main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
        sub="Culminus",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Jhakri Coronal +1",
        body="Azimuth Coat",
        hands="Jhakri Cuffs +1",
        legs="Azimuth Tights",
        feet="Jhakri Pigaches +1",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Psystorm Earring",
        left_ring="Arvina Ringlet +1",
        right_ring="Jhakri Ring",
        back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Pet: "Regen"+5',}},
    }

end

function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()
    -- local equipSet = {}
    -- add_to_chat(200, 'precast')
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
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    end
end

-- function job_post_midcast(spell, action, spellMap, eventArgs)
--     local equipSet = {}
--     if spell.skill == 'Geomancy' then
--         equip(sets.midcast[spellMap])
--         add_to_chat(140, spellMap)
--     end
-- end

function customize_idle_set(idleSet)
    check_special_ring_equipped()
    if state.CP.current == 'on' then
        equip(sets.CapacityPoints)
        disable('back')
    else
        enable('back')
    end

    if state.Dynamis.current == 'on' then
        equip(sets.JSENeck)
        disable('neck')
    else
        enable('neck')
    end
    --  Checking player stats
    --  Checking player stats
    -- if player.mpp < 51 then
    --     idleSet = set_combine(idleSet, sets.latent_refresh)
    -- end

    --  If in an assault or salvage zone, equip refresh ring
    -- if zones_toau_ring:contains(world.area) then
    --     idleSet = set_combine(idleSet, sets.ToAU)
    -- end

    --  If in an Adoulin zone, equip body piece if available
    -- if zones_adoulin_body:contains(world.area) then
    --     idleSet = set_combine(idleSet, sets.Adoulin)
    -- end

    return idleSet
end


function select_default_macro_book(isSubJobChange)
    -- Default macro set/book
    -- set_macro_page(1, 4)
end