-- NOTE: I do not play run, so this will not be maintained for 'active' use.
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--  Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    --  Load and initialize the include file.
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')
end


--  Setup vars that are user-independent.
function job_setup()
    --  Icons for custom timers for Runes.
    -- runes.icons = {
    --     ['Ignis'] = 'spells/00288.png',
    --     ['Gelus'] = 'spells/00289.png',
    --     ['Flabra'] = 'spells/00290.png',
    --     ['Tellus'] = 'spells/00291.png',
    --     ['Sulpor'] = 'spells/00292.png',
    --     ['Unda'] = 'spells/00293.png',
    --     ['Lux'] = 'spells/00294.png',
    --     ['Tenebrae'] = 'spells/00295.png'
    -- }

    --  Table of entries
    -- rune_timers = T{}
    -- entry = rune, index, expires

    -- if player.main_job_level >= 65 then
    --     max_runes = 3
    -- elseif player.main_job_level >= 35 then
    --     max_runes = 2
    -- elseif player.main_job_level >= 5 then
    --     max_runes = 1
    -- else
    --     max_runes = 0
    -- end

    --  BLU Specific. Commented for now
    -- blue_magic_maps = {}
    -- blue_magic_maps.Enmity = S{
    --     'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl',
    --     'Sheep Song', 'Chaotic Eye'
    -- }
    -- blue_magic_maps.Cure = S{
    --     'Wild Carrot'
    -- }
    -- blue_magic_maps.Buffs = S{
    --     'Cocoon', 'Refueling'
    -- }
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
function user_setup()
    -- state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    -- state.WeaponskillMode:options('Normal', 'Acc')
    -- state.PhysicalDefenseMode:options('PDT')
    -- state.IdleMode:options('Regen', 'Refresh')

    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('Normal', 'PDT', 'MDT')

    state.Runes = M{['description']='Runes', "Tellus", "Unda", "Flabra", "Ignis", "Gelus", "Sulpor", "Lux", "Tenebrae"}

    -- send_command('bind ^` input //gs c cycle Runes')
    -- send_command('bind !` input /ja "Vivacious Pulse" <me>')
    -- send_command('bind @` input //gs c rune')
    -- select_default_macro_book()

    state.CP = M(false, "CP Mode")
    state.Dynamis = M(false, "Dynamis Mode")
    state.Debug = M(false, "Debug Mode")

    send_command('bind @c gs c toggle CP')
    send_command('bind @x gs c toggle Dynamis')
    send_command('bind @z gs c toggle Debug')
end


function user_unload()
    -- send_command('unbind ^`')
    -- send_command('unbind !`')
    -- send_command('unbind @`')
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @z')
end


function init_gear_sets()
    sets.Adoulin = {
        body       = "Councilor's Garb"
    }
    sets.CP = {
        back       = "Mecistopins Mantle"
    }
    sets.JSENeck = {
        neck       = "Futhark Torque"
    }

    sets.enmity = {
        head       = "Erilaz Galea",
        body       = "Erilaz Surcoat",
        hands      = { name     = "Futhark Mitons",
                       augments = {'Enhances "Sleight of Sword" effect',}},
        legs       = "Erilaz Leg Guards",
        feet       = "Erilaz Greaves +1",
        neck       = "Futhark Torque",
        left_ear   = "Cryptic Earring",
        left_ring  = "Petrov Ring",
        back       = { name     = "Ogma's Cape",
                       augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+2','Enmity+10',}},
    }

    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast = {}

    sets.precast.JA = {}
    -- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.emnity, {
        body       = "Runeist Coat",
        back       = { name     = "Ogma's Cape",
                       augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+2','Enmity+10',}},
    })

    sets.precast.JA['Valiance'] = set_combine(sets.emnity, {
        body       = "Runeist Coat",
        back       = { name     = "Ogma's Cape",
                       augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+2','Enmity+10',}},
    })

    sets.precast.JA['Pflug'] = set_combine(sets.emnity, {
        feet="Runeist Boots +2"
    })

    sets.precast.JA['Lunge'] = {
        ammo       = "Seething Bomblet",
        head       = "Wayfarer Circlet",
        body       = "Wayfarer Robe",
        hands      = "Taeon Gloves",
        legs       = "Wayfarer Slops",
        feet       = "Meg. Jam. +2",
        neck       = "Sanctity Necklace",
        waist      = "Ioskeha Belt",
        left_ear   = "Friomisi Earring",
        right_ear  = "Odr Earring",
        left_ring  = "Petrov Ring",
        right_ring = "Arvina Ringlet +1",
        back       = "Amemet Mantle +1",
    }

    sets.precast.JA['Swipe']            = sets.precast.JA['Lunge']
    sets.precast.JA['Battuta']          = {head="Futhark Bandeau"}
    sets.precast.JA['Liement']          = {body="Futhark Coat +1"}
    sets.precast.JA['Gambit']           = {hands="Runeist Mitons +2"}
    sets.precast.JA['Rayke']            = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat"}
    sets.precast.JA['Swordplay']        = {hands="Futhark Mitons"}
    sets.precast.JA['Vivacious Pulse']  = {head="Erilaz Galea"}
    sets.precast.JA['Provoke']          = sets.enmity
    sets.precast.JA["Inquartata"]       = {legs="Erilaz Leg Guards"}
    -- sets.precast.JA['Embolden']         = {}
    -- sets.precast.JA['One For All']      = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo       = "Yamarang",
        head       = "Runeist Bandeau",
        body       = { name     = "Futhark Coat +1",
                       augments = {'Enhances "Elemental Sforzo" effect',}},
        hands      = "Meg. Gloves +1",
        legs       = { name     = "Rawhide Trousers",
                       augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet       = "Erilaz Greaves +1",
        neck       = "Loricate Torque",
        waist      = "Ioskeha Belt",
        left_ear   ="Loquac. Earring",
        right_ear  = "Infused Earring",
        back       = { name     = "Ogma's Cape",
                       augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+2','Enmity+10',}},
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs       = { name     = "Futhark Trousers +1",
                       augments = {'Enhances "Inspire" effect',}},
    })

    sets.precast.FC['Divine Magic'] = set_combine(sets.precast.FC, {})

    -- sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {})
    -- sets.precast.FC['Utsusemi: Ni'] = sets.precast.FC['Utsusemi: Ichi']

    -- Weaponskill sets
    sets.precast.WS = {
        ammo       = "Voluspa Tathlum",
        head       = "Meghanada Visor +2",
        body       = "Meg. Cuirie +1",
        hands      = "Meg. Gloves +1",
        legs       = "Meg. Chausses +1",
        feet       = "Meg. Jam. +2",
        neck       = "Sanctity Necklace",
        waist      = "Ioskeha Belt",
        left_ear   = "Mache Earring",
        right_ear  = "Odr Earring",
        left_ring  = "Petrov Ring",
        right_ring = "Rajas Ring",
        back={ name="Ogma's Cape", augments={'DEX+10','Accuracy+10 Attack+10','"Dbl.Atk."+10',}},
    }

    sets.precast.WS['Resolution']      = sets.precast.WS
    sets.precast.WS['Dimidiation']     = sets.precast.WS
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS["Resolution"], {belt="Snow Belt"})

    -- sets.precast.WS['Fell Cleave'] = sets.precast.WS['Resolution']
    -- sets.precast.WS['Sanguine Blade'] = {head="Pixie Hairpin +1", neck="Sanctity Necklace", ear1="Hectate's Earring", ear2="Friomisi Earring",
    --         body="Samnhua Coat", hands="Leyline Gloves", ring1="Archon Ring", ring2="Shiva Ring +1",
    --         back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Limbo Trousers",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    -- sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Resolution']
    -- sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Resolution'], {ear2="Ishvara earring"})
    -- sets.precast.WS['Requiescat'] = {ammo="Falcon Eye",
    --     head="Carmine Mask +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Brutal earring",
    --     body="Carmine Mail",hands="Carmine Finger Gauntlets",ring1="Leviathan Ring",ring2="Epona's Ring",
    --     back="Bleating Mantle",waist="Fotia Belt",legs="Carmine Cuisses +1",feet="Carmine Greaves"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
    sets.midcast = {}
    sets.midcast.FC = {}

    -- sets.midcast.EnhancingMagic = {
    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FC, {
        head       = "Erilaz Galea",
        hands      = "Runeist Mitons +2",
        legs       = { name     = "Futhark Trousers +1",
                       augments = {'Enhances "Inspire" effect',}},
        left_ear   = "Augment. Earring",
        right_ear  = "Loquac. Earring",
        left_ring  = "Renaye Ring",
        right_ring = "Stikini Ring",
    })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        head       = { name     = "Futhark Bandeau",
                       augments = {'Enhances "Battuta" effect',}},
    })

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
        legs       = { name     = "Futhark Trousers +1",
                       augments = {'Enhances "Inspire" effect',}},
    })

    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        head       = "Erilaz Galea",
        body       = "Runeist Coat"
    })

    -- sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast['Divine Magic'] = set_combine(sets.midcast.FC, {
        hands      = "Taeon Gloves",
        legs       = "Runeist Trousers +2",
        neck       = "Sanctity Necklace",
        left_ear   = "Lifestorm Earring",
        left_ring  = "Etana Ring",
        right_ring = "Stikini Ring",
    })

    sets.midcast['Flash'] = set_combine(
        sets.midcast['Divine Magic'],
        sets.enmity
    )

    sets.midcast['Healing Magic'] = {}
    -- sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'], {})

    -- sets.midcast['Blue Magic'] = {}
    -- sets.midcast['Blue Magic'].Enmity = sets.enmity
    -- sets.midcast['Blue Magic'].Cure   = sets.midcast.Cure
    -- sets.midcast['Blue Magic'].Buffs  = sets.midcast['Enhancing Magic']

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.idle = {
        main       = "Montante +1",
        sub        = "Pole Grip",
        ammo       = "Voluspa Tathlum",
        head       = "Rawhide Mask",
        body       = { name     = "Futhark Coat +1",
                       augments = {'Enhances "Elemental Sforzo" effect',}},
        hands      = "Meg. Gloves +1",
        legs       = { name     = "Rawhide Trousers",
                       augments = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
        feet       = "Meg. Jam. +2",
        neck       = "Bathy Choker +1",
        waist      = "Ioskeha Belt",
        left_ear   = "Mache Earring",
        right_ear  = "Infused Earring",
        left_ring  = "Meghanada Ring",
        right_ring = "Renaye Ring",
        back       = { name     = "Ogma's Cape",
                       augments = {'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+2','Enmity+10',}},
    }

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Carmine Cuisses +1"}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        ammo       = "Voluspa Tathlum",
        head       = "Meghanada Visor +2",
        body       = "Meg. Cuirie +1",
        hands      = "Runeist Mitons +2",
        legs       = "Runeist Trousers +2",
        feet       = "Meg. Jam. +2",
        neck       = "Loricate Torque",
        waist      = "Ioskeha Belt",
        left_ear   = "Mache Earring",
        right_ear  = "Infused Earring",
        left_ring  = "Petrov Ring",
        right_ring = "Rajas Ring",
        back       = { name     = "Ogma's Cape",
                       augments = {'DEX+10','Accuracy+10 Attack+10','"Dbl.Atk."+10',}},
    }

    sets.engaged.Hybrid = set_combine(sets.engaged, {})
    sets.engaged.PDT    = set_combine(sets.engaged, {})
    sets.engaged.MDT    = set_combine(sets.engaged, {})

    -- sets.engaged.DD = {ammo="Ginsen",
    --     head="Dampening Tam",neck="Lissome Necklace",ear1="Cessance Earring",ear2="Zennaroi Earring",
    --     body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
    --     back="Evasionist's Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
    -- sets.engaged.Acc = set_combine(sets.engaged.DD, {ammo="Falcon Eye",
    --         neck="Iqabi Necklace", hands="Adhemar Wristbands", waist="Kentarch Belt", legs="Herculean Trousers"})
    -- sets.engaged.PDT = {ammo="Falcon Eye",
    --         head="Futhark Bandeau +1", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Zennaroi Earring",
    --         body="Erilaz Surcoat +1", hands="Kurys Gloves", ring1="Defending Ring", ring2="Patricius Ring",
    --         back="Solemnity Cape", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"}
    -- sets.engaged.MDT = {ammo="Falcon Eye",
    --         head="Dampening Tam", neck="Twilight Torque", ear1="Ethereal Earring", ear2="Zennaroi Earring",
    --         body="Erilaz Surcoat +1", hands="Kurys Gloves", ring1="Defending Ring", ring2="Archon Ring",
    --         back="Solemnity Cape", waist="Flume Belt", legs="Eri. Leg Guards +1", feet="Erilaz Greaves +1"}
    -- sets.engaged.repulse = {back="Repulse Mantle"}
end


------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    check_equipment_special_ring()

    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end

    if spell.english == 'Provoke' then
        -- add_to_chat(100, 'Equipping enmity set')
        equip(sets.enmity)
    end

    -- add_to_chat(100, tostring(sets.precast.FC))
    -- if spellMap == 'Utsusemi' then
    --     if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
    --         cancel_spell()
    --         add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
    --         eventArgs.handled = true
    --         return
    --     elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
    --         send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
    --     end
    -- end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
-- function job_post_midcast(spell, action, spellMap, eventArgs)
    -- if spell.english == 'Lunge' or spell.english == 'Swipe' then
    --     local obi = get_obi(get_rune_obi_element())
    --     if obi then
    --         equip({waist=obi})
    --     end
    -- end
-- end


function customize_melee_set(meleeSet)
    local slots_domain_set = {'head', 'body', 'hands', 'legs', 'feet',}
    if buffactive['Vorseal'] then
        meleeSet = set_combine(meleeSet, get_domain_set(player.main_job))
    end
    return meleeSet
end


function user_buff_change(buff, gain, eventArgs)
    check_equipment_special_ring()
end


-- function job_aftercast(spell)
--    if not spell.interrupted then
--        if spell.type == 'Rune' then
--            update_timers(spell)
--        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
--            reset_timers()
--        elseif spell.name == "Swipe" then
--            send_command(trim(1))
--        end
--    end
-- end


-- function customize_melee_set(meleeSet)
-- end


function customize_idle_set(idleSet)

    if state.Debug.current == 'on' then
       windower.add_to_chat(9, "Currently in: " .. world.area)
    end

    --  Check custom statuses
    check_equipment_special_ring()
    check_status_cp()
    check_status_dynamis()

    -- if player.mpp < 51 then
    --     idleSet = set_combine(idleSet, sets.latent_refresh)
    -- end

    -- if toau_zones:contains(world.area) then
    --     idleSet = set_combine(idleSet, sets.ToAU)
    -- end
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    return idleSet
end

-- function job_buff_change(buff, gain, eventArgs)
    -- windower.add_to_chat(9, "Buff: " .. buff .. " has been " .. gain)
    -- windower.add_to_chat(9, buff)
    -- windower.add_to_chat(9, tostring(gain))
    -- windower.add_to_chat(9, tostring(eventArgs))
    -- if buff == 'Protect' and gain then
    --     windower.add_to_chat(4, 'Gained Protect')
    -- elseif buff == 'Protect' and not gain then
    --     windower.add_to_chat(4, 'Lost Protect')
    -- elseif buff == 'Shell' and gain then
    --     windower.add_to_chat(4, 'Gained Shell')
    -- elseif buff == 'Shell' and not gain then
    --     windower.add_to_chat(4, 'Lost Shell')
    -- end
-- end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
-- function job_get_spell_map(spell, default_spell_map)
--     if spell.skill == 'Blue Magic' then
--         for category,spell_list in pairs(blue_magic_maps) do
--             if spell_list:contains(spell.english) then
--                 return category
--             end
--         end
--     end
-- end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- function job_self_command(cmdParams, eventArgs)
--     windower.add_to_chat(4, tostring(cmdParams))
--     windower.add_to_chat(3, tostring(eventArgs))
--     if cmdParams[1]:lower() == 'rune' then
--         send_command('@input /ja '..state.Runes.value..' <me>')
--     end
-- end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if subjob == 'WAR' then
        set_macro_page(1, 4)
    elseif subjob == 'SAM' then
        set_macro_page(3, 4)
    else
        set_macro_page(1, 4)
    end
end


-- function get_rune_obi_element()
--     weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
--     day_rune = buffactive[elements.rune_of[world.day_element] or '']

--     local found_rune_element

--     if weather_rune and day_rune then
--         if weather_rune > day_rune then
--             found_rune_element = world.weather_element
--         else
--             found_rune_element = world.day_element
--         end
--     elseif weather_rune then
--         found_rune_element = world.weather_element
--     elseif day_rune then
--         found_rune_element = world.day_element
--     end

--     return found_rune_element
-- end

-- function get_obi(element)
--     if element and elements.obi_of[element] then
--         return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
--     end
-- end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------
-- Add a new run to the custom timers, and update index values for existing timers.
-- function update_timers(spell)
--    local expires_time = os.time() + 300
--    local entry_index = rune_count(spell.name) + 1

--    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

--    rune_timers:append(entry)
--    local cmd_queue = create_timer(entry).. ';wait 0.05;'

--    cmd_queue = cmd_queue .. trim()

--    add_to_chat(123,'cmd_queue='..cmd_queue)

--    send_command(cmd_queue)
-- end


-- Get the command string to create a custom timer for the provided entry.
-- function create_timer(entry)
--    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) ..'"'
--    local duration = entry.expires - os.time()
--    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down ' .. runes.icons[entry.rune]
-- end


-- Get the command string to delete a custom timer for the provided entry.
-- function delete_timer(entry)
--    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
--    return 'timers d ' .. timer_name .. ''
-- end


-- Reset all timers
-- function reset_timers()
--    local cmd_queue = ''
--    for index,entry in pairs(rune_timers) do
--        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--    end
--    rune_timers:clear()
--    send_command(cmd_queue)
-- end


-- Get a count of the number of runes of a given type
-- function rune_count(rune)
--    local count = 0
--    local current_time = os.time()
--    for _,entry in pairs(rune_timers) do
--        if entry.rune == rune and entry.expires > current_time then
--            count = count + 1
--        end
--    end
--    return count
-- end


-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
-- function trim(n)
--    local cmd_queue = ''
--
--    local to_remove = n or (rune_timers:length() - max_runes)

--    while to_remove > 0 and rune_timers:length() > 0 do
--        local oldest
--        for index,entry in pairs(rune_timers) do
--            if oldest == nil or entry.expires < rune_timers[oldest].expires then
--                oldest = index
--            end
--        end

--        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
--        to_remove = to_remove - 1
--    end

--    return cmd_queue
-- end


-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
-- function prune(rune)
--    local cmd_queue = ''

--    for index,entry in pairs(rune_timers) do
--        if entry.rune == rune then
--            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
--            entry.index = entry.index - 1
--        end
--    end

--    for index,entry in pairs(rune_timers) do
--        if entry.rune == rune then
--            if entry.index == 0 then
--                rune_timers[index] = nil
--            else
--                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
--            end
--        end
--    end

--    return cmd_queue
-- end


--  Locks the correct ring slot if a listed ring is equipped
--  Unlocks the slot if the ring is no longer detected
function check_equipment_special_ring()
    if equip_lock_rings:contains(player.equipment.ring1) then
        windower.add_to_chat(9, 'Ring1 locked')
        special_ring_equipped = true
        equipment_lock_specific({'ring1'})
    elseif equip_lock_rings:contains(player.equipment.ring2) then
        windower.add_to_chat(9, 'Ring2 locked')
        special_ring_equipped = true
        equipment_lock_specific({"ring2"})
    elseif special_ring_equipped then
        windower.add_to_chat(9, 'Unlocking rings')
        special_ring_equipped = false
        equipment_unlock_specific({'ring1', 'ring2'})
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


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

--windower.raw_register_event('zone change',reset_timers)
--windower.raw_register_event('logout',reset_timers)
--windower.raw_register_event('status change',function(new, old)
--    if gearswap.res.statuses[new].english == 'Dead' then
--        reset_timers()
--    end
--end