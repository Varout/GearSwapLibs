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

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    include('COR_Roll_Values.lua')
    include('common_functions.lua')
    include('common_lists.lua')
    determine_haste_group()
end


--  Beagle's change mode to switch between DD gun and Rolls gun
--  /equip range "weapon"
--  /macro book #
--  /macro set #

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
--  ----------------------------------------------------------------------------------------------------
--  Information about custom commands
--  ----------------------------------------------------------------------------------------------------
function custom_instructions()
    add_to_chat(200, "Manhoso's COR Custom commands:")
    add_to_chat(200, "* Ctrl + , | Spectral Jig")
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal',  'Hybrid')
    state.RangedMode:options('Normal', 'Acc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    -- state.DynaMode = M(false, "Dyna Mode")
    -- state.BuffMode = M(true, "Buff Mode")

    options.ammo_warning_limit = 5


    -- Additional local binds
    send_command('bind mmstop gs c reset DefenseMode')
    send_command('bind mail gs c cycle IdleMode')
    --send_command('bind ^` input /ja "Double-up" <me>')
    --send_command('bind !` input /ja "Bolter\'s Roll" <me>')

    --send_command('bind ^- gs c cycleback mainqd')
    --send_command('bind ^= gs c cycle mainqd')
    --send_command('bind !- gs c cycle altqd')
    --send_command('bind != gs c cycleback altqd')
    --send_command('bind ^[ gs c toggle selectqdtarget')
    --send_command('bind ^] gs c toggle usealtqd')

    --  ^ is Ctrl
    if player.sub_job == 'DNC' then
        send_command('bind ^, input /ja "Spectral Jig" <me>')
        -- send_command('unbind ^.')
    elseif player.sub_job == "RDM" or player.sub_job == "WHM" then
        --send_command('bind ^, input /ma "Sneak" <stpc>')
        --send_command('bind ^. input /ma "Invisible" <stpc>')
    else
        --send_command('bind ^, input /item "Silent Oil" <me>')
        --send_command('bind ^. input /item "Prism Powder" <me>')
    end

    -- send_command('bind @x gs c toggle Dyna')
    --send_command('bind @h gs c cycle HasteMode')

    custom_instructions()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
--    send_command('unbind ^`')
--    send_command('unbind !`')
--    send_command('unbind ^-')
--    send_command('unbind ^=')
--    send_command('unbind !-')
--    send_command('unbind !=')
--    send_command('unbind ^[')
--    send_command('unbind ^]')
    send_command('unbind ^,')
--    send_command('unbind ^.')
--    send_command('unbind @x')
--    send_command('unbind @h')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    include('Manhoso_COR_GearSets.lua')
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
    -- if Armor == 'PDT' then
    --     equip(sets.PDT)
    -- elseif Armor == 'MDT' then
    --     equip(sets.MDT)
    -- elseif Armor == 'Kiting' then
    --     equip(sets.Kiting)
    -- elseif new == 'Engaged' then
    --     equipSet = sets.engaged
    --     if Armor == 'Hybrid' and equipSet["Hybrid"] then
    --         equipSet = equipSet["Hybrid"]
    --     end
    -- end
end

function job_precast(spell, action, spellMap, eventArgs)
    -- add_to_chat(060, spell.type .. ' | ' .. spell.action_type)
    if job_type_magic_user:contains(player.sub_job) then
        check_debuff_silenced(spell, eventArgs)
    end

    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- Gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        local equipSet
        equipSet = sets.precast.CorsairRoll
        if buffactive['Snake Eye'] then
            equipSet = set_combine(equipSet, sets.precast.JA['Snake Eye'])
        end
        equip(equipSet)
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
            equip(gear.ObiDark)
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(gear.ObiFire)
        -- elseif spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
        --     equip(sets.Obi)
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
    -- if buffactive['Reive Mark'] then
    --     equip(sets.Reive)
    --     disable('neck')
    -- else
    --     enable('neck')
    -- end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()
    check_ammo_pouch_equipped()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" then
        idleSet = set_combine(idleSet, sets.idle.refresh)
    end
    return idleSet
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
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

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- Physical weaponskills
                bullet_name = gear.BulletWS
            else
                -- Magical weaponskills
                bullet_name = gear.BulletMA
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.BulletQD
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.BulletRA
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
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.BulletRA then
--            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.BulletQD and available_bullets.count <= bullet_min_count then
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

--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------
windower.register_event('zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(sets.idle)
    end
)