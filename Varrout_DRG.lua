-- *** Credit goes to Flippant & Martel for helping me with this Gearswap *** --
-- ** I Use Some of Motenten's Functions ** --
-- Last Updated: 05/03/14 7:30 AM *Changed HB Rule* --


toau_zones = S{
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


function get_sets()
    AccIndex = 1
    AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. Most of These Sets Are Empty So You Need To Edit Them On Your Own. Remember To Check What The Combined Set Is For Each Sets. --
    AttIndex = 1
    AttArray = {"LowATT","HighATT","LowContent"} -- LowATT Is The Same As LowACC Set. MidACC & HighACC Take Priority Over These 2 Sets(HighATT & LowContent). --
    IdleIndex = 2
    IdleArray = {"Movement","Regen","Refresh"} -- Default Idle Set Is Movement --
    Armor = 'None'
    Twilight = 'None'
    Rancor = 'OFF' -- Set Default Rancor ON or OFF Here --
    Brais = 'ON' -- Set Default Brais ON or OFF Here --
    Samurai_Roll = 'OFF' -- Set Default SAM Roll ON or OFF Here --
    target_distance = 5.15 -- Set Default Distance Here --
    select_default_macro_book() -- Change Default Macro Book At The End --

    NM_For_Brais = S{} -- Add More NM Here For High Jump --

    HB_Mage_SubJob = S{"WHM","RDM","BLM","BLU","SCH"} -- 50% Healing Breath Trigger SubJob --
    HB_DD_SubJob = S{"PLD","DRK","BRD","NIN"} -- 33% Healing Breath Trigger SubJob --
    sc_map = {SC1="Drakesbane", SC2="SpiritJump", SC3="SoulJump"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --

    sets.Idle = {}
    -- Idle/Town Sets --
    sets.Idle.Regen = {
        ammo    = "Vanir Battery",
        head    = "Valorous Mask",
        neck    = "Bathy Choker +1",
        ear1    = "Infused Earring",
        -- ear2    = "Dignitary's Earring",
        ear2    = "Moonshade Earring",
        body    = "Vishap Mail +2",
        hands   = "Sulevia's Gauntlets +2",
        ring1   = "Defending Ring",
        ring2   = "Sheltered Ring",
        back    = { name="Brigantia's Mantle",
                    augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        waist   = "Ioskeha Belt",
        legs    = "Sulevia's Cuisses +2",
        feet    = "Sulevia's Leggings +2"
    }
    sets.Idle.Refresh = set_combine( sets.Idle.Regen, {
        ear2    = "Moonshade Earring"
    })
    sets.Idle.ToAU = set_combine(sets.Idle.Refresh, {
        ring1   = "Balrahn's Ring"
    })
    -- sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}

    -- TP Base Set --
    sets.TP = {}

    -- Ryunohige(AM3 Down) TP Sets --
    sets.TP["Shining One"] = {
        main    = "Kaja Lance",
        sub     = "Utu Grip",
        ammo    = "Vanir Battery",
        head    = "Flamma Zucchetto +2",
        neck    = "Asperity Necklace",
        ear1    = "Sherida Earring",
        ear2    = "Dignitary's Earring",
        body    = "Flamma Korazin +2",
        hands   = "Sulevia's Gauntlets +2",
        ring1   = "Niqmaddu Ring",
        ring2   = "Flamma Ring",
        back    = { name="Brigantia's Mantle",
                    augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
        waist   = "Ioskeha Belt",
        legs    = "Sulevia's Cuisses +2",
        feet    = "Flamma Gambieras +2"}

    -- Ryunohige(AM3 Up) TP Sets --
    -- sets.TP.Oathkeeper
    -- sets.TP.Upukirex
    -- sets.TP.Ryunohige

    -- WS Base Set --
    sets.WS = {}

    -- WS Sets --
    sets.WS.Drakesbane = {
        ammo="Knobkierrie",
        head="Valorous Mask",
        neck="Light Gorget",
        ear1="Sherida Earring",
        ear2="Dignitary's Earring",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
        ring1="Niqmaddu Ring",
        ring2="Rajas Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
        waist="Fotia Belt",
        legs="Vishap Brais +2",
        feet="Sulevia's Leggings +2"
    }

    sets.WS.Stardiver = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        neck="Shadow Gorget",
        ear1="Sherida Earring",
        ear2="Dignitary's Earring",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
        ring1="Niqmaddu Ring",
        ring2="Pyrosoul Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
        waist="Fotia Belt",
        legs="Vishap Brais +2",
        feet="Sulevia's Leggings +2"
    }

    sets.WS["Camlann's Torment"] = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        neck="Light Gorget",
        ear1="Sherida Earring",
        ear2="Ishvara Earring",
        body="Flamma Korazin +2",
        hands="Sulevia's Gauntlets +2",
        ring1="Niqmaddu Ring",
        ring2="Pyrosoul Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
        waist="Fotia Belt",
        legs="Vishap Brais +2",
        feet="Sulevia's Leggings +2"
    }

    -- JA Sets --
    sets.JA = {}
    sets.JA.Jump = {
        ammo    = "Knobkierrie",
        head    = "Sulevia's Mask +1",
        neck    = "Asperity Necklace",
        ear1    = "Steelflash Earring",
        ear2    = "Bladeborn Earring",
        body    = "Vishap Mail +2",
        hands   = "Vishap Finger Gauntlets +1",
        ring1   = "Flamma Ring",
        ring2   = "Rajas Ring",
        back    = "Brigantia's Mantle",
        waist   = "Goading Belt",
        legs    = "Flamma Dirs +2",
        feet    = "Vishap Greaves +1"}

    sets.JA["High Jump"] = set_combine(sets.JA.Jump,{
        legs    = "Vishap brais +2"})

    sets.JA["Spirit Jump"] = set_combine(sets.JA.Jump,{
        feet    = "Peltast's Schynbalds",
        legs    = "Peltast's Cuissots +1"})

    sets.JA["Soul Jump"] = set_combine(sets.JA.Jump,{
        legs    = "Peltast's Cuissots +1"})

    sets.JA.Angon = {ammo="Angon",ear1="Dragoon's Earring",hands="Pteroslaver Finger Gauntlets"}
    sets.JA["Ancient Circle"] = {legs="vishap brais +2"}
    sets.JA['Call Wyvern'] = {body="Pteroslaver Mail"}

    sets.Pet = {}
    sets.Pet.WyvernHP = {
        head="Ptero. Armet +1",
        neck="Lancer's Torque",
        ear1="Lancer's Earring",
        ear2="Dragoon's Earring",
        body="Wyvern Mail",
        hands="Crusher's Gauntlets",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        legs="vishap brais +2",
        feet="Ptero. Greaves +1"
    }

    sets.JA["Spirit Link"] = set_combine(sets.Pet.WyvernHP, {
        head="Vishap Armet +1",
        hands="Peltast's Vambraces +1"
    })
    sets.Pet["Restoring Breath"] = set_combine(sets.Pet.WyvernHP)
    sets.Pet["Smiting Breath"] = set_combine(sets.Pet.WyvernHP)
    sets.Pet["Steady Wing"] = set_combine(sets.Pet.WyvernHP)

    -- Healing Breath Trigger --
    sets.HealingBreathTrigger = set_combine(sets.Pet.WyvernHP, {
        head="Vishap Armet +1"
    })

    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {
        hands="Leyline Gloves",
        ear1="Loquac. Earring",
        ring1="Evanescence Ring",
    }

    sets.Midcast = {}
    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT, {
        head="Otomi Helm",
        hands="Cizin Mufflers +1",
        waist="Goading Belt",
        legs="Ares' Flanchard +1",
        feet="Huginn Gambieras"
    })

    sets.Midcast.Trust = {
        head="Vishap Armet +1",
        body="Vishap Mail +1",
        hands="Vishap Finger Gauntlets +1",
        legs="vishap brais +2",
        feet="Vishap Greaves +1"
    }
end

function pretarget(spell,action)
    if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    elseif spell.english == "Spirit Jump" and not pet.isvalid then -- Change Spirit Jump To Jump If Wyvern Is Not Present --
        cancel_spell()
        send_command('input /ja Jump <t>')
    elseif spell.english == "Soul Jump" and not pet.isvalid then -- Change Soul Jump To High Jump If Wyvern Is Not Present --
        cancel_spell()
        send_command('input /ja "High Jump" <t>')
    elseif spell.english == "Dismiss" and pet.hpp < 100 then -- Cancel Dismiss If Wyvern's HP Is Under 100% --
        cancel_spell()
        add_to_chat(123, spell.english .. ' Canceled: [' .. pet.hpp .. ']')
        return
    -- elseif spell.english == "Call Wyvern" and pet.isvalid then -- Change Call Wyvern To Dismiss If Wyvern Is Present --
    --     cancel_spell()
    --     send_command('Dismiss')
    elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('Aggressor')
    elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
        cancel_spell()
        send_command('ThirdEye')
    elseif spell.english == "Meditate" and player.tp > 2000 then -- Cancel Meditate If TP Is Above 2000 --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
    elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        return
    end
end

function precast(spell,action)
    if spell.english == 'Ranged' then
        equip({ammo="Pebble"})
    elseif spell.type == "WeaponSkill" then
        if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
            cancel_spell()
            add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
            return
        else
            equipSet = sets.WS
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if equipSet[AccArray[AccIndex]] then
                equipSet = equipSet[AccArray[AccIndex]]
            end
            if equipSet[AttArray[AttIndex]] then
                equipSet = equipSet[AttArray[AttIndex]]
            end
            if player.tp > 299 or buffactive.Sekkanoki then -- Equip Kokou's Earring When You Have 300 TP or Sekkanoki --
                equipSet = set_combine(equipSet,{ear1="Kokou's Earring"})
            end
            if spell.english == "Drakesbane" and string.find(spell.target.name,'Dynamis Lord') then -- Equip Phorcys Korazin When You Use Drakesbane On DL & ADL --
                equipSet = set_combine(equipSet,{body="Phorcys Korazin"})
            end
            equip(equipSet)
        end
    elseif spell.type == "JobAbility" then
        equipSet = sets.JA
        if equipSet[spell.english] then
            equipSet = equipSet[spell.english]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if spell.english == "High Jump" and NM_For_Brais:contains(spell.target.name) and Brais == 'ON' then -- Use vishap brais +2 Toggle To Equip vishap brais +2 For High Jump --
            equipSet = set_combine(equipSet,{legs="vishap brais +2"})
        end
        equip(equipSet)
    elseif spell.action_type == 'Magic' then
        if buffactive.silence or spell.target.distance > 16+target_distance then
            cancel_spell()
            add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
            return
        else
            if string.find(spell.english,'Utsusemi') then
                if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
                    cancel_spell()
                    add_to_chat(123,'Utsusemi Canceled: [3+ Images]')
                    return
                else
                    equip(sets.Precast.FastCast)
                end
            else
                equip(sets.Precast.FastCast)
            end
        end
    elseif spell.type == "Waltz" then
        refine_waltz(spell,action)
        equip(sets.Waltz)
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    elseif spell.type == "PetCommand" then
        equip(sets.Pet[spell.english])
    end

    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end

function midcast(spell,action)
    if spell.english == 'Ranged' then
        equip({ammo="Pebble"})
    elseif spell.type == "Trust" then
        equip(sets.Midcast.Trust)
    elseif spell.action_type == 'Magic' then
        if string.find(spell.english,'Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
                send_command('@wait 1.7;cancel Copy Image*')
            end
            equip(sets.Midcast.Haste)
        elseif spell.english == 'Monomi: Ichi' then
            if buffactive['Sneak'] then
                send_command('@wait 1.7;cancel sneak')
            end
        elseif HB_Mage_SubJob:contains(player.sub_job) and pet.isvalid then
            equip(sets.HealingBreathTrigger)
        elseif HB_DD_SubJob:contains(player.sub_job) and player.hpp < 34 and pet.isvalid then
            equip(sets.HealingBreathTrigger)
        else
           equip(sets.Midcast.Haste)
        end
     end
end

function aftercast(spell,action)
    if not string.find(spell.english,'Breath') then
        status_change(player.status)
    elseif not spell.interrupted then
        if spell.type == "WeaponSkill" then
            send_command('wait 0.2;gs c TP')
        elseif string.find(spell.english,'Jump') then
            send_command('wait 0.2;gs c TP')
        elseif spell.english == "Angon" then -- Angon Timer/Countdown --
            timer_angon()
            send_command('wait 80;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;timers delete "Angon";input /p '..spell.name..': [OFF]')
        elseif spell.english == "Ancient Circle" then -- Ancient Circle Countdown --
            send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
        end
    end
end

function status_change(new,old)
    -- if Armor == 'PDT' then
    --     equip(sets.PDT)
    -- elseif Armor == 'MDT' then
    --     equip(sets.MDT)
    -- else
    if new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
        if equipSet[player.equipment.main] then
            equipSet = equipSet[player.equipment.main]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
            if Rancor == 'ON' then -- Default Rancor Toggle Is Rancorous Mantle --
                equipSet = set_combine(equipSet["AM3"],sets.TP.Rancor)
            else -- Use Rancor Toggle For Brigantia's Mantle --
                equipSet = equipSet["AM3"]
            end
        end
        if buffactive.Ionis and equipSet["Ionis"] then
            equipSet = equipSet["Ionis"]
        end
        if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
            equipSet = equipSet["STP"]
        end
        equip(equipSet)
    else
        -- equip(sets.Idle[IdleArray[IdleIndex]])

        -- add_to_chat(123, world.area)
        -- add_to_chat(123, toau_zones:contains(zone))

        if toau_zones:contains(world.area) then
            equip(sets.Idle.ToAU)
        else
            equip(sets.Idle[IdleArray[IdleIndex]])
        end


    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end

function buff_change(buff,gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    elseif buff == 'weakness' then -- Weakness Timer --
        if gain then
            send_command('timers create "Weakness" 300 up')
        else
            send_command('timers delete "Weakness"')
        end
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
        equip({neck="Berserker's Torque"})
    else
        if not midaction() and not pet_midaction() then
            status_change(player.status)
        end
    end
end

function pet_midcast(spell,action)
    if string.find(spell.english,'Breath') then
        equip(sets.Pet["Restoring Breath"])
    end
end

function pet_aftercast(spell,action)
    status_change(player.status)
end

function pet_change(pet,gain)
    status_change(player.status)
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
    if command == 'C1' then -- Accuracy Level Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
        status_change(player.status)
    elseif command == 'C9' then -- Attack Toggle --
        AttIndex = (AttIndex % #AttArray) + 1
        add_to_chat(158,'Attack Level: '..AttArray[AttIndex])
        status_change(player.status)
    elseif command == 'C5' then -- Auto Update Gear Toggle --
        status_change(player.status)
        add_to_chat(158,'Auto Update Gear')
    elseif command == 'C2' then -- Hybrid Toggle --
        if Armor == 'Hybrid' then
            Armor = 'None'
            add_to_chat(123,'Hybrid Set: [Unlocked]')
        else
            Armor = 'Hybrid'
            add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
        end
        status_change(player.status)
    elseif command == 'C7' then -- PDT Toggle --
        if Armor == 'PDT' then
            Armor = 'None'
            add_to_chat(123,'PDT Set: [Unlocked]')
        else
            Armor = 'PDT'
            add_to_chat(158,'PDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C15' then -- MDT Toggle --
        if Armor == 'MDT' then
            Armor = 'None'
            add_to_chat(123,'MDT Set: [Unlocked]')
        else
            Armor = 'MDT'
            add_to_chat(158,'MDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C16' then -- Rancor Toggle --
        if Rancor == 'ON' then
            Rancor = 'OFF'
            add_to_chat(123,'Rancor: [OFF]')
        else
            Rancor = 'ON'
            add_to_chat(158,'Rancor: [ON]')
        end
        status_change(player.status)
    elseif command == 'C10' then -- vishap brais +2 Toggle --
        if Brais == 'ON' then
            Brais = 'OFF'
            add_to_chat(123,'vishap brais +2: [OFF]')
        else
            Brais = 'ON'
            add_to_chat(158,'vishap brais +2: [ON]')
        end
        status_change(player.status)
    elseif command == 'C17' then -- SAM Roll Toggle --
        if Samurai_Roll == 'ON' then
            Samurai_Roll = 'OFF'
            add_to_chat(123,'SAM Roll: [OFF]')
        else
            Samurai_Roll = 'ON'
            add_to_chat(158,'SAM Roll: [ON]')
        end
        status_change(player.status)
    elseif command == 'C3' then -- Twilight Toggle --
        if Twilight == 'Twilight' then
            Twilight = 'None'
            add_to_chat(123,'Twilight Set: [Unlocked]')
        else
            Twilight = 'Twilight'
            add_to_chat(158,'Twilight Set: [locked]')
        end
        status_change(player.status)
    elseif command == 'C8' then -- Distance Toggle --
        if player.target.distance then
            target_distance = math.floor(player.target.distance*10)/10
            add_to_chat(158,'Distance: '..target_distance)
        else
            add_to_chat(123,'No Target Selected')
        end
    elseif command == 'C6' then -- Idle Toggle --
        IdleIndex = (IdleIndex % #IdleArray) + 1
        add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
        status_change(player.status)
    elseif command == 'TP' then
        add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end

function timer_angon()
    local duration = 90
    send_command('timers create "Angon" '..tostring(duration)..' down')
end

function refine_waltz(spell,action)
    if spell.type ~= 'Waltz' then
        return
    end

    if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
        return
    end

    local newWaltz = spell.english
    local waltzID

    local missingHP

    if spell.target.type == "SELF" then
        missingHP = player.max_hp - player.hp
    elseif spell.target.isallymember then
        local target = find_player_in_alliance(spell.target.name)
        local est_max_hp = target.hp / (target.hpp/100)
        missingHP = math.floor(est_max_hp - target.hp)
    end

    if missingHP ~= nil then
        if player.sub_job == 'DNC' then
            if missingHP < 40 and spell.target.name == player.name then
                add_to_chat(123,'Full HP!')
                cancel_spell()
                return
            elseif missingHP < 150 then
                newWaltz = 'Curing Waltz'
                waltzID = 190
            elseif missingHP < 300 then
                newWaltz = 'Curing Waltz II'
                waltzID = 191
            else
                newWaltz = 'Curing Waltz III'
                waltzID = 192
            end
        else
            return
        end
    end

    local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50, ['Curing Waltz IV'] = 65, ['Curing Waltz V'] = 80}
    local tpCost = waltzTPCost[newWaltz]

    local downgrade

    if player.tp < tpCost and not buffactive.trance then

        if player.tp < 20 then
            add_to_chat(123, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
            cancel_spell()
            return
        elseif player.tp < 35 then
            newWaltz = 'Curing Waltz'
        elseif player.tp < 50 then
            newWaltz = 'Curing Waltz II'
        elseif player.tp < 65 then
            newWaltz = 'Curing Waltz III'
        elseif player.tp < 80 then
            newWaltz = 'Curing Waltz IV'
        end

        downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
    end

    if newWaltz ~= spell.english then
        send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
        if downgrade then
            add_to_chat(158, downgrade)
        end
        cancel_spell()
        return
    end

    if missingHP > 0 then
        add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
    end
end

function find_player_in_alliance(name)
    for i,v in ipairs(alliance) do
        for k,p in ipairs(v) do
            if p.name == name then
                return p
            end
        end
    end
end

function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book()
end

function set_macro_page(set,book)
    if not tonumber(set) then
        add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
        return
    end

    if book then
        if not tonumber(book) then
            add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
    else
        send_command('@input /macro set '..tostring(set))
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    else
        set_macro_page(2, 6)
    end
    send_command('wait 2; input /lockstyleset 004')
end