function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')

    --  Make sure all gear is unlocked after we swap
    equipment_unlock_all()
end


function job_setup()
    max_ws_distance = 5.15  --  Set max ws abort distance here

    --  Dark Knight Specific
    -- state.Buff[""] = buffactive[""] or false

    --  Warrior Specific
    -- state.Buff[""] = buffactive[""] or false

    --  Samurai Specific
    -- state.Buff[""] = buffactive[""] or false
end


function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options("Acc")
    -- state.HybridMode:options('Normal')
    -- state.CastingMode:options('Normal')
    -- state.IdleMode:options('Normal')

    --  Which macro book to default to when changing jobs
    select_default_macro_book(false)

    --  Special states to track for White Mage
    state.CP = M(false, "CP Mode")              --  CP Mode: Used to lock in CP Cape
    state.Dynamis = M(false, "Dynamis Mode")    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.Debug = M(false, "Debug Mode")        --  Debug Mode: Helpful for outputting information in the LUA. Not set up

    --  Where @ is the Windows Key
    send_command('bind @c gs c toggle CP')      --  Windows Key + C: Toggle CP Mode
    send_command('bind @x gs c toggle Dynamis') --  Windows Key + X: Toggle Dynamis Mode
    send_command('bind @z gs c toggle Debug')   --  Windows Key + z: Togger Debug Mode
end


function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @z')
end


function init_gear_sets()
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
        sub="Utu Grip",
        ammo="Jukukik Feather",
        head={ name="Valorous Mask", augments={'CHR+8','AGI+13','Crit.hit rate+3','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Sulev. Leggings +2",
        neck="Sanctity Necklace",
        waist="Ioskeha Belt",
        left_ear="Infused Earring",
        right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
        left_ring="Sulevia's Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.idle.MP = set_combine(sets.idle, {
        head="Befouled Crown",
    })

    sets.engaged = {}
    sets.engaged["Acc"] = {
        sub="Utu Grip",
        ammo="Jukukik Feather",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Flam. Gambieras +2",
        neck="Asperity Necklace",
        waist="Ioskeha Belt",
        left_ear="Digni. Earring",
        right_ear="Steelflash Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Flamma Ring",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
    }
    sets.engaged["Hybrid"] = {}
    sets.engaged["PDT"] = {}
    sets.engaged["MDT"] = {}

    sets.precast = {}
    sets.precast.FC = {}

    sets.precast.JA = {}

    sets.precast.WS = {
        sub="Utu Grip",
        ammo="Knobkierrie",
        head="Flam. Zucchetto +2",
        body="Sulevia's Plate. +2",
        hands="Flam. Manopolas +2",
        legs="Sulev. Cuisses +2",
        feet="Sulev. Leggings +2",
        neck="Sanctity Necklace",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear="Ishvara Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Flamma Ring",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
    }

    sets.midcast = {}
    sets.midcast["Dark Magic"] = {
        sub="Utu Grip",
        ammo="Hydrocera",
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Casso Sash",
        left_ear="Lifestorm Earring",
        right_ear="Psystorm Earring",
        left_ring="Evanescence Ring",
        right_ring="Kishar Ring",
        back="Merciful Cape",
    }
    sets.midcast["Drain"] = {
        head="Appetence Crown",
        neck="Erra Pendant",
        back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
    }
    sets.midcast["Aspir"] = sets.midcast["Drain"]

end


function job_precast(spell, action, spellMap, eventArgs)
    check_special_ring_equipped()

    if spell.action_type == 'Magic' and buffactive['Silence'] then
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

    elseif spell.type == "WeaponSkill" and spell.target.distance > max_ws_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        return

    end

    local abil_recasts = windower.ffxi.get_ability_recasts()


end


function job_midcast(spell, action, spellMap, eventArgs)
    local equipSet = {}
    local spell_match = spell.element == world.weather_element or spell.element == world.day_element

    if spellMap == "Aspir" then
        equipSet = sets.midcast["Aspir"]
    elseif spellMap == "Drain" then
        equipSet = sets.midcast["Drain"]
    elseif spell.skill == "Dark Magic" then
        equipSet = sets.midcast["Dark Magic"]
    end

    if spell_match then
        equipSet = set_combine(equipSet, {waist="Hachirin-no-obi"})
    end

end

--  Currently used for testing to see what happens with commitment
-- function job_buff_change(buff, gain, eventArgs)

-- end

-- function job_status_change(newStatus, oldStatus, eventArgs)
--     add_to_chat(300, newStatus)
--     add_to_chat(300, oldStatus)
--     add_to_chat(300, "&&&&&&&&&&")
-- end


-- function user_status_change(newStatus, oldStatus, eventArgs)
--     add_to_chat(300, newStatus)
--     add_to_chat(300, oldStatus)
--     add_to_chat(300, "&&&&&&&&&&")
-- end

function customize_melee_set(meleeSet)
    if buffactive['Elvorseal'] then
        meleeSet = set_combine(meleeSet, get_domain_set(player.main_job))
    end
    return meleeSet
end


function customize_idle_set(idleSet)
    --  Gear Specific
    check_special_ring_equipped()
    check_status_cp(state.CP.current == 'on', sets.CP)
    check_status_dynamis(state.Dynamis.current == 'on', sets.JSENeck)

    --  Zone Specific
    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  If in an Adoulin zone, equip body piece if available
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end
end

function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book(true)
end


function select_default_macro_book(isSubJobChange)
    -- Default macro set/book
    set_macro_page(1, 8)
end
