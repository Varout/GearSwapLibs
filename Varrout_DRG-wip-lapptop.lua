function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    --  user customised lists
    include('common_lists.lua')
end

function job_setup()

end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('Normal')

    state.CP = M(false, "CP Mode")
    state.Dynamis = M(false, "Dynamis Mode")
    state.Debug = M(false, "Debug Mode")

    send_command('bind @c gs c toggle CP')
    send_command('bind @x gs c toggle Dynamis')
    send_command('bind @z gs c toggle Debug')
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @z')
end

function init_gear_sets()
    --  Area specific
    sets.Adoulin = {
        body       = "Councilor's Garb"
    }
    sets.CP  = {
        back       = "Mecisto. Mantle"
    }
    sets.JSENeck = {
        neck       = ""
    }
    sets.AhtUrhganRing = {
        left_ring  = "Balrahn's Ring"
    }

    sets.idle = {
        body = "Visharp Mail +2",
        hands = "Visharp F. G. +1"
    }

    sets.idle.Refresh = {

    }

    --  Initialising Empty Sets
    sets.precast = {}
    sets.midcast = {}

    sets.precast["Food"] = {
        body = "Pelt. Plackart +1"
    }

    --  Precast Weapon Skill Sets
    sets.precast.WS = {
        left_ear = "Sherida Earring",
        right_ear = "Ishvara Earring",
        legs = "Vishap Brais +2"
    }
    sets.precast.WS["Stardiver"] = {}
    sets.precast.WS["Camlann's Torment"] = {}
    sets.precast.WS["Drakesbane"] = {}
    sets.precast.WS["Impulse Drive"] = {}
    sets.precast.WS["Sonic Thrust"] = {}
    sets.precast.WS["Leg Sweep"] = {}
    sets.precast.WS["Penta Thrust"] = {}

    --  Precast Job Ability Sets
    sets.precast.JA = {
        body = "Vishap Mail +2"
    }
    sets.precast.JA["Call Wyvern"] = {}
    sets.precast.JA["Ancient Circle"] = {
        legs = "Vishap Brais +2"
    }
    sets.precast.JA["Dragon Breaker"] = {}
    sets.precast.JA["Spirit Surge"] = {
        body = "Pteroslaver Mail"
    }
    sets.precast.JumpBase = {
        ammo       = "Vanir Battery",
        head       = "Flam. Zucchetto +2",
        body       = "Vishap Mail +2",
        hands      = "Vishap F. G. +1",
        legs       = "Flamma Dirs +2",
        feet       = "Vishap Greaves +1",
        neck       = "Asperity Necklace",
        waist      = "Ioskeha Belt",
        left_ear   = "Sherida Earring",
        right_ear  = "Digni. Earring",
        left_ring  = "Niqmaddu Ring",
        right_ring = "Flamma Ring",
        back       = { name     = "Brigantia's Mantle",
                       augments = {'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    sets.precast.JA["Jump"] = set_combine(sets.precast.JumpBase, {

    })
    sets.precast.JA["High Jump"] = set_combine(sets.precast.JumpBase, {
        legs = "Vishap Brais +2"
    })
    sets.precast.JA["Spirit Jump"] = set_combine(sets.precast.JumpBase, {
        legs = "Pelt. Cuissots +1",
        feet = "Pelt. Schynbalds"
    })
    sets.precast.JA["Soul Jump"] = set_combine(sets.precast.JumpBase, {
        legs = "Pelt. Cuissots +1"
    })
    sets.precast.JA["Super Jump"] = {}
    sets.precast.JA["Spirit Link"] = {
        head = "Vishap Armet +1",
        hands = "Pel. Vambraces +1",
        feet = "Ptero. Greaves +1"
    }
    sets.precast.JA["Angon"] = {
        hands = "Ptero. Fin. Gaunt."
    }
    sets.precast.JA["Deep Breathing"] = {
        head = "Ptero. Armet +2"
    }
    sets.precast.JA["Fly High"] = {}
    sets.precast.JA["Spirit Bond"] = {}
    sets.precast.WyvernHP = {}
    sets.precast.JA.SmitingBreath = {
        head = "Ptero. Armet +2",
        legs = "Ptero. Brais +1"
    }
    sets.precast.JA.RestoringBreath = {
        head = "",
        legs = "Vishap Brais +2"
    }

    --  Precast Fast Cast Sets
    sets.precast.FC = {}

    --  Midcast Sets
    sets.midcast.JA = {}
    sets.midcast.JA.SmitingBreath = {
        head = "Ptero. Armet +2",
        legs = "Ptero. Brais +1"
    }

    sets.midcast.Trust = {
        head       = "Vishap Armet +1",
        body       = "Vishap Mail +2",
        hands      = "Vishap Finger Gauntlets +1",
        legs       = "vishap brais +2",
        feet       = "Vishap Greaves +1"
    }

    --  Engaged Sets
end

------------------------------------------------------------------
-- Buff Change Events
------------------------------------------------------------------
function user_buff_change()
    check_equipment_special_ring()

end

function job_buff_change()
    check_equipment_special_ring()

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    check_equipment_special_ring()

    --  Substitute Spirit Jump for Jump if Spirit is on recast
    --  Substitute Soul Jump for High Jump if Soul is on recast
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if spell.english == 'Spirit Jump' then
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Jump" <t>')
            add_to_chat(100, '*** Spirit Jump Aborted: Timer on Cooldown -- Downgrading to Jump ***')
            eventArgs.cancel = true
            return
        end
    elseif spell.english == 'Soul Jump' then
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "High Jump" <t>')
            add_to_chat(100, '*** Soul Jump Aborted: Timer on Cooldown -- Downgrading to High Jump ***')
            eventArgs.cancel = true
            return
        end
    elseif spell.action_type == 'Magic' and buffactive['Silence'] then
        -- If silenced, use what's available to remove it, otherwise you're screwed
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

-- function job_post_midcast(spell, action, spellMap, eventArgs)

-- end

------------------------------------------------------------------
-- Customise Melee & Idle Sets
------------------------------------------------------------------
-- function customize_melee_set(meleeSet)

-- end

function get_idle_set(idleSet)
    --  Equipment lock sets
    check_equipment_special_ring()
    check_status_cp()
    check_status_dynamis()

    if zones_adoulin:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    if zones_toau_ring:contains(world.area) and job_type_mage:contains(player.sub_job) then
        idleSet = set_combine(idleSet, sets.AhtUrhganRing)
    end

    return idleSet
end

function select_default_macro_book(isSubJobChange)
    -- set_macro_page(1, 4)
    if player.sub_job:contains(job_type_mage) then
        set_macro_page(1, 6)
    elseif player.sub_job:contains(job_type_melee) then
        set_macro_page(2, 6)
    else
        set_macro_page(2, 6)
    end

    if not isSubJobChange then
        send_command('wait 2; input /lockstyleset 004')
    end
end

------------------------------------------------------------------
-- Custom functions
------------------------------------------------------------------
--  Locks the correct ring slot if a listed ring is equipped
--  Unlocks the slot if the ring is no longer detected
function check_equipment_special_ring()
    if special_rings:contains(player.equipment.ring1) then
        windower.add_to_chat(9, "Ring1 locked")
        special_ring_equipped = true
        disable("ring1")
    elseif special_rings:contains(player.equipment.ring2) then
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

function check_status_dynamis()
    if state.Dynamis.current == 'on' then
        equip(sets.JSENeck)
        disable('neck')
    else
        enable('neck')
    end
end

function check_status_cp()
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
end
