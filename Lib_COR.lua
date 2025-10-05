-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten / Modified: Arislan, Varrout)
-------------------------------------------------------------------------------------------------------------------
--[[    Custom Features:

        QuickDraw Selector      Cycle through available primary and secondary shot types,
                                  and trigger with a single macro
        Haste Detection         Detects current magic haste level and equips corresponding engaged set to
                                  optimize delay reduction (automatic)
        Haste Mode              Toggles between Haste II and Haste I recieved, used by Haste Detection [WinKey-H]
        Auto-Lockstyle          Automatically locks specified equipset on file load
        Custom UI               Custom UI to show shortcuts and states
--]]

-------------------------------------------------------------------------------------------------------------------
--[[    Custom commands:

    gs c qd
        Uses the currently configured shot on the target, with either <t> or <stnpc> depending on setting.

    Configuration commands:

    gs c cycle qdelement (Windows Key + Q), gs c cycleback QdElement (Windows Key + E)
        Cycles through the available Quick Draw Elements (excluding Light & Darks Shots). Default: Fire Shot

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
    mage_subjobs = S{'WHM', 'RDM', 'SCH'}

    state.IdleMode:options('Normal', 'MagicEvasion')
    state.OffenseMode:options('Normal', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'Accuracy')
    state.MovementMode = M{['description'] = 'Movement Mode', 'Normal', 'Fast'}
    state.HasteMode = M{['description'] = 'Haste Mode', 'Haste I', 'Haste II'}

    --  QuickDraw Selector: Mode, and Element
    state.QdMode = M{['description'] = "QD Mode", "Attack", "Hybrid"}
    state.QdElement = M{['description'] = 'QD Element', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
    state.QdElement:set('Fire Shot')

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
    determine_haste_group()
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    gear.RAbullet = "Devastating Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Devastating Bullet"
    gear.QDbullet = "Hauksbok Bullet"
    options.ammo_warning_limit = 5

    --  Keybinds (! = ALT / @ = WIN / ^ = CTRL)
    --  Job Ability Shortcuts
    send_command('bind @b input /ja "Bolter\'s Roll" <me>')

    --  Cycle through Quick Draw elements
    send_command('bind @w gs c cycle QdElement')
    send_command('bind @e gs c cycleback QdElement')
    send_command('bind @t gs c cycle QdMode')
    --  Quick Draw actions
    send_command('bind @` gs c qd')
    send_command('bind @1 gs c qdlight')
    send_command('bind @2 gs c qddark')

    --  Cycle through different modes
    send_command('bind @h gs c cycle HasteMode')
    send_command('bind ^f9 gs c cycle IdleMode')
    send_command('bind ^f10 gs c cycle OffenseMode')
    send_command('bind ^f11 gs c cycle WeaponskillMode')
    send_command('bind ^f12 gs c cycle MovementMode')

    handle_sneak_invis_assignments()

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    --  Job Ability Shortcuts
    send_command('unbind @b')   --  Bolter's Roll

    send_command('unbind ^,')   --  Sneak (or Spectral Jig)
    send_command('unbind ^.')   --  Invisible

    --  Cycle through Quick Draw elements
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @t')
    --  Quick Draw actions
    send_command('unbind @`')   --  Quick Draw with selected element
    send_command('unbind @1')   --  Light Shot
    send_command('unbind @2')   --  Dark Shot

    --  Cycle through different modes
    send_command('unbind @h')   --  HastMode
    send_command('unbind ^f9')  --  IdleMode
    send_command('unbind ^f10') --  OffenseMode
    send_command('unbind ^f11') --  WeaponskillMode
    send_command('unbind ^f12') --  MovementMode
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        if state.QdElement:contains(spell.english) then
            equip(sets.precast.CorsairShot[state.QdMode.current])
        end
        -- Check that proper ammo is available if we're using ranged attacks or similar.
        do_bullet_checks(spell, spellMap, eventArgs)

    elseif spell.action_type == 'Magic' and buffactive['Silence'] then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
        send_command('input /echo *!! Silenced ~ Using Echo Drop @ '..player.inventory['Echo Drops'].count..' Left !!*')

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
            equip(sets.FireObi)
        -- elseif spell.type == 'CorsairShot' and (spell.element == world.weather_element or spell.element == world.day_element) then
        --     equip(sets.Obi)
        end
    end
end


function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        --  Local States
        local has_triple_shot = buffactive["Triple Shot"] or false
        local has_aftermath = buffactive["Aftermath: Lv.1"] or buffactive["Aftermath: Lv.2"] or buffactive["Aftermath: Lv.3"] or false

        local midcastSet = sets.midcast.RA

        --  Both Empyrean and Mythic Aftermath give: Occasionally deals double or triple damage
        if has_aftermath and (player.equipment.range == gear.WeaponEmpyrean or player.equipment.range == gear.WeaponMythic) then
            midcastSet = set_combine(midcastSet, sets.midcast.RA['Armageddon']['Aftermath'])
        end

        --  Make the most of Triple Shot if it's active
        if has_triple_shot then
            midcastSet = set_combine(midcastSet, sets.midcast['Triple Shot'])
        end

        if is_in_ts_sweet_spot(spell.target.distance, spell.target.model_size) then
            midcastSet = set_combine(midcastSet, sets.midcast['Trus Shot'])
        end

        equip(midcastSet)
        eventArgs.handled = true
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if not idleSet then
        idleSet = sets.idle[state.IdleMode.current]
    end

    if mage_subjobs:contains(player.sub_job) then
        idleSet = set_combine(idleSet, sets.idle['Refresh'])
    end

    --  If in town
    if areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.town)
    end

    --  If sneak or invisible active
    if buffactive["Sneak"] or buffactive["Invisible"] or state.MovementMode.current == 'Fast' then
        idleSet = set_combine(idleSet, sets.movement)
    end

    return idleSet
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands
-------------------------------------------------------------------------------------------------------------------
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'qd' then
        send_command('@input /ja "' .. state.QdElement.current .. '" <t>')
    elseif cmdParams[1]:lower() == 'qdlight' then
        send_command('@input /ja "Light Shot" <t>')
    elseif cmdParams[1]:lower() == 'qddark' then
        send_command('@input /ja "Dark Shot" <t>')
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Subjob Change
-------------------------------------------------------------------------------------------------------------------
function sub_job_change(newSubjob, oldSubjob)
    handle_sneak_invis_assignments()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--[[
    The min and max values here seem to be static, and it is useful to use the distance add-on
    while on COR and your sweet-spot will be when the colours are blue
    Code tacken from DistancePlus by Sammeh
]]
function is_in_ts_sweet_spot(target_distance, target_model_size)
    local t = windower.ffxi.get_mob_by_target('t')
    local s = windower.ffxi.get_mob_by_target('me')

    local trueshotmin = s.model_size + t.model_size + 3.0209
    local trueshotmax = s.model_size + t.model_size + 4.3189
    if t.model_size > 1.6 then
        trueshotmax = trueshotmax + 0.1
        trueshotmin = trueshotmin + 0.1
    end

    return (t.distance:sqrt() <= trueshotmax and t.distance:sqrt() >= trueshotmin)
end


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

    local geo_haste = 580
    local haste = 33
    local mighty_guard = 604

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


function define_roll_values()
    rolls = {
        ["Corsair's Roll"]      = { lucky = 5, unlucky = 9,  bonus = "Experience Points" },
        ["Ninja Roll"]          = { lucky = 4, unlucky = 8,  bonus = "Evasion" },
        ["Hunter's Roll"]       = { lucky = 4, unlucky = 8,  bonus = "Accuracy" },
        ["Chaos Roll"]          = { lucky = 4, unlucky = 8,  bonus = "Attack" },
        ["Magus's Roll"]        = { lucky = 2, unlucky = 6,  bonus = "Magic Defense" },
        ["Healer's Roll"]       = { lucky = 3, unlucky = 7,  bonus = "Cure Potency Received" },
        ["Drachen Roll"]        = { lucky = 4, unlucky = 8,  bonus = "Pet Magic Accuracy/Attack" },
        ["Choral Roll"]         = { lucky = 2, unlucky = 6,  bonus = "Spell Interruption Rate" },
        ["Monk's Roll"]         = { lucky = 3, unlucky = 7,  bonus = "Subtle Blow" },
        ["Beast Roll"]          = { lucky = 4, unlucky = 8,  bonus = "Pet Attack" },
        ["Samurai Roll"]        = { lucky = 2, unlucky = 6,  bonus = "Store TP" },
        ["Evoker's Roll"]       = { lucky = 5, unlucky = 9,  bonus = "Refresh" },
        ["Rogue's Roll"]        = { lucky = 5, unlucky = 9,  bonus = "Critical Hit Rate" },
        ["Warlock's Roll"]      = { lucky = 4, unlucky = 8,  bonus = "Magic Accuracy" },
        ["Fighter's Roll"]      = { lucky = 5, unlucky = 9,  bonus = "Double Attack Rate" },
        ["Puppet Roll"]         = { lucky = 3, unlucky = 7,  bonus = "Pet Magic Attack/Accuracy" },
        ["Gallant's Roll"]      = { lucky = 3, unlucky = 7,  bonus = "Defense" },
        ["Wizard's Roll"]       = { lucky = 5, unlucky = 9,  bonus = "Magic Attack" },
        ["Dancer's Roll"]       = { lucky = 3, unlucky = 7,  bonus = "Regen" },
        ["Scholar's Roll"]      = { lucky = 2, unlucky = 6,  bonus = "Conserve MP" },
        ["Naturalist's Roll"]   = { lucky = 3, unlucky = 7,  bonus = "Enh. Magic Duration" },
        ["Runeist's Roll"]      = { lucky = 4, unlucky = 8,  bonus = "Magic Evasion" },
        ["Bolter's Roll"]       = { lucky = 3, unlucky = 9,  bonus = "Movement Speed" },
        ["Caster's Roll"]       = { lucky = 2, unlucky = 7,  bonus = "Fast Cast" },
        ["Courser's Roll"]      = { lucky = 3, unlucky = 9,  bonus = "Snapshot" },
        ["Blitzer's Roll"]      = { lucky = 4, unlucky = 9,  bonus = "Attack Delay" },
        ["Tactician's Roll"]    = { lucky = 5, unlucky = 8,  bonus = "Regain" },
        ["Allies's Roll"]       = { lucky = 3, unlucky = 10, bonus = "Skillchain Damage" },
        ["Miser's Roll"]        = { lucky = 5, unlucky = 7,  bonus = "Save TP" },
        ["Companion's Roll"]    = { lucky = 2, unlucky = 10, bonus = "Pet Regain and Regen" },
        ["Avenger's Roll"]      = { lucky = 4, unlucky = 8,  bonus = "Counter Rate" },
    }
end


function display_roll_info(spell)
    rollinfo = rolls[spell.english]

    if rollinfo then
        add_to_chat(104, '[ Lucky: ' .. tostring(rollinfo.lucky) .. ' / Unlucky: ' .. tostring(rollinfo.unlucky) .. ' ] ' .. spell.english..': ' .. rollinfo.bonus)
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
    -- if player.sub_job == 'DNC' then
        -- set_macro_page(2, 7)
        -- send_command('wait 2; input /lockstyleset 100')
    -- else
        set_macro_page(1, 2)
        send_command('wait 2; input /lockstyleset 003')
    -- end
end


function handle_sneak_invis_assignments()
    if player.sub_job == 'DNC' then
        send_command('bind ^, input /ja "Spectral Jig" <me>')
        send_command('unbind ^.')
    elseif mage_subjobs:contains(player.sub_job) then
        send_command('bind ^, input /ma "Sneak" <stpc>')
        send_command('bind ^. input /ma "Invisible" <stpc>')
    else
        send_command('bind ^, input /item "Silent Oil" <me>')
        send_command('bind ^. input /item "Prism Powder" <me>')
    end
end


windower.register_event(
    'zone change',
    function()
        equip(customize_idle_set())
    end
)