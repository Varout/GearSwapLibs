-- map_raise_ids = M{
--     ['Raise'] = 12,    ['Raise II'] = 13,    ['Raise III'] = 140,   ['Arise'] = 494
-- }
-- map_reraise_ids = M{
--     ['Reraise'] = 135, ['Reraise II'] = 141, ['Reraise III'] = 142, ['Reraise IV'] = 848
-- }

cure_names = S{
    'Cure', 'Curaga', 'Cura'
}
player_tp_lock = 700
--  ----------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
--  ----------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('common_lists.lua')
    include('common_functions.lua')

    --  Make sure all gear is unlocked after we swap
    equipment_unlock_all()
end

--  ----------------------------------------------------------------------------------------------------
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked
--  ----------------------------------------------------------------------------------------------------
function job_setup()
    --  White mage specific
    state.Buff["Divine Seal"]     = buffactive["Divine Seal"]     or false
    state.Buff["Divine Caress"]   = buffactive["Divine Caress"]   or false
    state.Buff["Afflatus Solace"] = buffactive["Afflatus Solace"] or false
    state.Buff["Afflatus Misery"] = buffactive["Afflatus Misery"] or false

    --  Scholar specific
    state.Buff["Sublimation: Activated"] = buffactive["Sublimation: Activated"] or false
    state.Buff["Sublimation: Complete"]  = buffactive["Sublimation: Complete"]  or false

    --  Black Magic Specific
    state.Buff.ElementalSeal = buffactive['Elemental Seal'] or false
end

--  ----------------------------------------------------------------------------------------------------
--
--  ----------------------------------------------------------------------------------------------------
function user_setup()
    --  Default states for automatic gear selection, needs to be defined for Mote-Include to run autonomously
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    --  Which macro book to default to when changing jobs
    select_default_macro_book(false)

    --  Special states to track for White Mage
    state.CP = M(false, "CP Mode")              --  CP Mode: WHM is mastered, so likely won't need this anymore
    state.Dynamis = M(false, "Dynamis Mode")    --  Dynamis Mode: To force the dynamis neck piece to stay equipped
    state.Debug = M(false, "Debug Mode")        --  Debug Mode: Helpful for outputting information in the LUA. Not set up
    state.OhShi = M(false, "OhShi Mode")
    state.Weapons = M(false, "Weapons Mode")

    --  Where @ is the Windows Key
    send_command('bind @c gs c toggle CP')      --  Windows Key + C: Toggle CP Mode
    send_command('bind @x gs c toggle Dynamis') --  Windows Key + X: Toggle Dynamis Mode
    send_command('bind @m input /map')          --  Windows Key + M: Show map, because I'm lazy af
    send_command('bind @1 gs c rr4')            --  Windows Key + 1: Reraise 4
    send_command('bind @z gs c toggle Debug')   --  Windows Key + z: Togger Debug Mode
    send_command('bind @v gs c toggle OhShi')   --  Windows Key + v: Toggle OhShi Mode. Good for kiting
    send_command('bind @n gs c toggle Weapons')

    --  Set up lockstyle set
    -- randomise_lockstyle()
end

function user_unload()
    send_command('unbind @c')
    send_command('unbind @x')
    send_command('unbind @m')
    send_command('unbind @1')
    send_command('unbind @z')
    send_command('unbind @v')
    send_command('unbind @n')
end

function init_gear_sets()

    --  Gear sets for specific conditions and commands
    --  Neck equipment to lock in while in dynamis
    sets.JSENeck = {
        neck       = "Cleric's Torque"
    }

    --  Equipment that enhances the charge rate of Sublimation
    sets.Sublimation = {
        waist      = "Embla Sash"
    }

    --  Equipment only active during reives
    sets.Reives = {
        neck       = "Arciela's Grace +1"
    }

    --  Set for summoning Trusts. All iLevel 119
    sets.Trust = {
        main       = "Bolelabunga",
        sub        = "Ammurapi Shield",
        ammo       = "Homiliary",
        head       = "Inyanga Tiara +2",
        body       = "Inyanga Jubbah +2",
        hands      = "Inyanga Dastanas +2",
        legs       = "Inyanga Shalwar +2",
        feet       = "Inyanga Crackows +2"
    }

    sets.idle = {
        main       = "Bolelabunga",
        sub        = "Ammurapi Shield",
        ammo       = "Homiliary",
        head       = "Inyanga Tiara +2",
        neck       = "Loricate Torque +1",
        left_ear   = "Infused Earring",
        right_ear  = "Moonshade Earring",
        body       = "Theophany Briault +3",
        hands      = "Inyanga Dastanas +2",
        left_ring  = "Defending Ring",
        right_ring = "Inyanga Ring",
        back       = { name     = "Alaunus's Cape",
                       augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
        waist      = "Fucho-no-obi",
        legs       = "Inyanga Shalwar +2",
        feet       = "Inyanga Crackows +2"
    }

    sets.resting = {
        main       = "Boonwell Staff",      -- +18
        sub        = "Ariesian Grip",       -- +1
        ammo       = "Mana Ampulla",        -- +2
        head       = "Orvail Corona +1",    -- +4
        neck       = "Eidolon Pendant +1",  -- +6
        left_ear   = "Glorious Earring",    -- +0
        right_ear  = "Moonshade Earring",   -- +0
        body       = "Chelona Blazer",      -- +8   (Nice to have +1)
        hands      = "Nares Cuffs",         -- +4
        left_ring  = "Star Ring",           -- +1
        right_ring = "Angha Ring",          -- +2
        back       = "Felicitas Cape",      -- +3
        waist      = "Austerity Belt",      -- +4
        legs       = "Nisse Slacks",        -- +4
        feet       = "Chelona Boots"        -- +5   (Nice to have +1)
    }

--  Setting the base set: precast
    sets.precast = {}

--  --------------------
--  AF/Relic JA Sets
--  --------------------
    sets.precast["Devotion"]    = { head = "Piety Cap +3" }
    sets.precast["Benediction"] = { body = "Piety Briault +3" }

    sets.precast.FC = {
        main       = "Oranyan",                            -- FC +10%
        sub        = "Clerisy Strap",                      -- FC +02%
        ammo       = "Incantor Stone",                     -- FC +02%
        head       = "Revealer's Crown",                   -- FC +05%
        neck       = "Cleric's Torque",                    -- FC +06%
        left_ear   = "Loquac. Earring",                    -- FC +02%
        right_ear  = "Etiolation Earring",                 -- FC +01%
        body       = "Inyanga Jubbah +2",                  -- FC +14%
        hands      = "Fanatic Gloves",                     -- FC +07%
        left_ring  = "Evanescence Ring",                   -- Spell Interruption down 05%
        right_ring = "Kishar Ring",                        -- FC +04%
        back       = { name     = "Alaunus's Cape",        -- FC +10%, Spell Interruption down 10%
                       augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist      = "Embla Sash",                         -- FC +05%
        legs       = { name     = "Kaykaus Tights",        -- FC +06%, Spell Interruption down 10%
                       augments = {'MP+60','Spell interruption rate down +10%','"Cure" spellcasting time -5%',}},
        feet       = "Regal Pumps +1"                      -- FC +04% - +06%       (Nice to have +1)
    }

    sets.precast['Enhancing Magic'] = set_combine(sets.precast.FC, {
        head       = "Umuthi Hat",
        waist      = "Siegel Sash"
    })

    sets.precast['Stoneskin'] = set_combine(sets.precast['Enhancing Magic'], {
        head       = "Umuthi Hat",              --  Stoneskin Cast Time -15%
        hands      = "Carapacho Cuffs",         --  Stoneskin Cast Time -15%
        legs       = "Querkening Brais"         --  Stoneskin Cast Time -10%
    })

    sets.precast['Healing Magic'] = set_combine(sets.precast.FC, {
        legs       = "Ebers Pantaloons +1"      --  Healing Magic Cast Time -13%
    })

    sets.precast['Cure'] = set_combine(sets.precast['Healing Magic'], {
        main       = "Ababinili +1",            --  Cure Cast Time -11%
        sub        = "Clerisy Strap",           --  FC +02%
        head       = "Piety Cap +3",            --  Cure Cast Time -15%, Haste +6%
        left_ear   = "Nourishing Earring +1",   --  Cure Cast Time -4%
        right_ear  = "Mendicant's Earring",     --  Cure Cast Time -5%, Conserve MP +3
        body       = "Heka's Kalasiris",        --  Cure Cast Time -15%
        feet       = "Hygieia Clogs +1"         --  Cure Cast Time -18%, Haste +3%, Conserve MP +5
    })

    --------------------
    --  midcast Sets  --
    --------------------
    sets.midcast = {}

    sets.midcast.Caress = {
        hands      = "Ebers Mitts +1"              --  Divine Caress +1
    }

    --  The Twilight Cape gives an extra 5% on matched day/weather effect
    --  Hachirin-no-Obi gives 10% on matched day/weather effect
    sets.midcast.WeatherBoost = {
        back       = "Twilight Cape",
        waist      = "Hachirin-no-Obi"
    }

    --  Complete different sets for base cure potency, and set for day/weather match
    sets.midcast.Cure = {
        main       = "Raetic Rod",
        sub        = "Sors Shield",
        ammo       = "Quartz Tathlum +1",
        head       = { name     = "Vanya Hood",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body       = "Theo. Briault +3",
        hands      = "Theophany Mitts +3",
        legs       = "Ebers Pant. +1",
        feet       = { name     = "Vanya Clogs",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck       = "Colossus's Torque",
        waist      = "Bishop's Sash",
        left_ear   = "Glorious Earring",
        right_ear  = "Beatific Earring",
        left_ring  = "Janniston Ring",
        right_ring = "Menelaus's Ring",
        back       = { name     = "Alaunus's Cape",
                       augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
    }

    sets.midcast.CureBonus = {
        main       = "Raetic Rod",
        sub        = "Sors Shield",
        ammo       = "Quartz Tathlum +1",
        head       = { name     = "Vanya Hood",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body       = "Theo. Briault +3",
        hands      = "Theophany Mitts +3",
        legs       = "Ebers Pant. +1",
        feet       = { name     = "Vanya Clogs",
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck       = { name     = "Cleric's Torque",
                       augments = {'Path: A',}},
        waist      = "Hachirin-no-Obi",
        left_ear   = "Glorious Earring",
        right_ear  = "Nourish. Earring +1",
        left_ring  = "Janniston Ring",
        right_ring = "Menelaus's Ring",
        back       = "Twilight Cape",
    }

    --  Healing Magic: 615
    sets.midcast.NASpell = {
        main       = "Yagrush",                     --  AoE Status Removal
        sub        = "Sors Shield",                 --  Nothing special, just some extra defense and evasion
        ammo       = "Incantor Stone",              --  Healing Magic +00
        head       = "Vanya Hood",                  --  Healing Magic +20, Cursna +0
        neck       = "Colossus's Torque",           --  Healing Magic +07 (Lightsday +10.  There is a torque which gives +10 to all magic skills)
        left_ear   = "Beatific Earring",            --  Healing Magic +04
        right_ear  = "Healing Earring",             --  Healing Magic +03
        body       = "Ebers Bliaud +1",             --  Healing Magic +24
        hands      = "Theophany Mitts +3",          --  Healing Magic +21
        left_ring  = "Sirona's Ring",               --  Healing Magic +10
        right_ring = "Menelaus's Ring",             --  Cure +5%, Healing Magic +15, Cursna +20
        back       = "Altruistic Cape",             --  Healing Magic +05
        waist      = "Bishop's Sash",               --  Healing Magic +05
        legs       = "Ebers Pantaloons +1",         --  Healing Magic +00, Divine Benison +2
        feet       = { name     = "Vanya Clogs",    --  Healing Magic +40, Cursna +5
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
    }

    sets.midcast.Cursna = set_combine(sets.midcast.NASpell, {
        -- main="Gambanteinn",                      --  Cursna +100 (Very very nice to have.  Goals.  But would I really use this in place of a Yagrush?)
        neck       = "Debilis Medallion",           --  Healing Magic +00, Cursna +15
        hands      = "Fanatic Gloves",              --  Healing Magic +10, Cursna +15
        left_ring  = "Haoma's Ring",                --  Healing Magic +08, Cursna +15
        right_ring = "Menelaus's Ring",             --  Healing Magic +15, Cursna +20
        back       = { name     = "Alaunus's Cape", --  Healing Magic +00, Cursna +25
                       augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        legs       = "Theophany Pantaloons +3",     --  Healing Magic +00, Cursna +21
        feet       = { name     = "Vanya Clogs",    --  Healing Magic +40, Cursna +5
                       augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}        -- Gendewitha Galoshes +1: +10 Cursna.  Not sure if it'll be better than what I already have
    })

    sets.midcast['Enhancing Magic'] = {
        main       = "Oranyan",                     --  Enhancing Maigc duration +10%
        sub        = "Ammurapi Shield",             --  Enhancing magic duration +10%
        ammo       = "Hydrocera",                   --  Enhancing Maigc +0
        head       = "Befouled Crown",              --  Enhancing Maigc +16
        neck       = "Colossus's Torque",           --  Enhancing Maigc +7
        left_ear   = "Augmenting Earring",          --  Enhancing Maigc +3
        right_ear  = "Andoaa Earring",              --  Enhancing Maigc +5
        body       = "Anhur Robe",                  --  Enhancing Maigc +12
        hands      = { name     = "Telchine Gloves",
                       augments = {'DEF+19','"Elemental Siphon"+35','Enh. Mag. eff. dur. +8',}},
        left_ring  = "Stikini Ring",                --  All magic +5
        right_ring = "Stikini Ring",                --  All magic +5
        back       = "Fi Follet Cape",              --  Enhancing Maigc +8
        waist      = "Olympus Sash",                --  Enhancing Maigc +5
        legs       = "Piety Pantaloons +3",         --  Enhancing Maigc +26
        feet       = "Theophany Duckbills +3"       --  Enhancing Magic +21, Enhancing Magic Duration +10%
    }

    sets.midcast.Barspell = set_combine(sets.midcast['Enhancing Magic'], {
        head       = "Ebers Cap +1",                --  Set: Occationally negates damage with correct barpsell
        body       = "Ebers Bliaud +1",             --  Set: Occationally negates damage with correct barpsell
        hands      = "Ebers Mitts +1",              --  Set: Occationally negates damage with correct barpsell
        legs       = "Piety Pantaloons +3",         --  Barspell +36
        feet       = "Ebers Duckbills +1"           --  Set: Occationally negates damage with correct barpsell
    })

    sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
        neck       = "Nodens Gorget",               --  Stoneskin +30
        left_ear   = "Earthcry Earring",            --  Stoneskin +10
        waist      = "Siegel Sash",                 --  Stoneskin +20
        legs       = "Haven Hose"                   --  Stoneskin +20
        -- legs    = "Shedir Seraweels"         --  Stoneskin +35
    })

    --  Regen Potency/Duration set
    --  +46 Duration
    --  +76% Potency from gear
    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
        main       = "Bolelabunga",                 --  Regen Potency +10%
        head       = "Inyanga Tiara +2",            --  Regen Potency +14%
        body       = "Piety Briault +3",            --  Regen Potency +52%
        hands      = "Ebers Mitts +1",              --  Regen Duration +22
        legs       = "Theophany Pantaloons +3"      --  Regen Duration +24
    })

    sets.midcast['Shell'] = set_combine(sets.midcast['Enhancing Magic'], {
        left_ring  = "Sheltered Ring",              --  Enhances Protect & Shell
    })

    sets.midcast['Protect'] = set_combine(sets.midcast['Enhancing Magic'], {
        left_ring  = "Sheltered Ring",              --  Enhances Protect & Shell
    })

    sets.midcast['Auspice'] = set_combine(sets.midcast['Enhancing Magic'], {
        feet       = "Ebers Duckbills +1"           --  Auspice +15
    })

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
        main       = "Vadose Rod"                   --  Aquaveil +1
        -- legs    = "Shedir Seraweels"         --  Enhances Aquaveil
    })

    sets.midcast['Erase'] = set_combine(sets.midcast['Enhancing Magic'], {
        main       = "Yagrush",
        sub        = "Ammurapi Shield",             --  Enhancing magic duration +10%
        neck       = "Cleric's Torque"              --  Erase +1        (Nice to have +1 or 2)
    })

    --  Base set for magic accuracy for Divine and Enfeebling
    sets.midcast.MagicAcc = {
        main       = "Blurred Staff",               --  +20 Magic Accuracy, +228 Magic Accuracy Skill
        sub        = "Enki Strap",                  --  +10 Magic Accuracy
        ammo       = "Hydrocera",                   --  +06 Magic Accuracy
        head       = "Inyanga Tiara +2",            --  +44 Magic Accuracy
        neck       = "Erra Pendant",                --  +17 Magic Accuracy
        left_ear   = "Psystorm Earring",            --  +12 Magic Accuracy: Set
        right_ear  = "Lifestorm Earring",           --  +12 Magic Accuracy: Set
        body       = "Inyanga Jubbah +2",           --  +46 Magic Accuracy
        hands      = "Inyanga Dastanas +2",         --  +43 Magic Accuracy, +20 All magic
        left_ring  = "Stikini Ring",                --  +08 Magic Accuracy, +05 All magic
        right_ring = "Stikini Ring",                --  +08 Magic Accuracy, +05 All magic
        back       = { name     = "Alaunus's Cape", --  +20 Magic Accuracy
                       augments = {'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
        waist      = "Aswang Sash",                            --  +03 Magic Accuracy
        legs       = "Inyanga Shalwar +2",          --  +45 Magic Accuracy
        feet       = "Piety Duckbills +3"           --  +36 Magic Accuracy
    }

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MagicAcc, {
        body       = "Theophany Briault +3",
        right_ring = "Kishar Ring",
        waist      = "Casso Sash",
        legs       = { name     = "Chironic Hose",
                       augments = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })

    sets.midcast['Divine Magic'] = set_combine(sets.midcast.MagicAcc, {
        hands      = "Piety Mitts +3",
        waist      = "Bishop's Sash",
        legs       = "Theophany Pantaloons +3"
    })

    sets.midcast['Banish'] = set_combine(sets.midcast.Divine, {
        neck       = "Sanctity Necklace",          --  +10 Magic Accuracy, +10 Magic Attack Bonus
        left_ear   = "Dignitary's Earring",        --  +10 Magic Accuracy
        right_ear  = "Hecate's Earring",           --  +06 Magic Attack Bonus, +3% Magic Crit. Hit
        back       = "Disperser's Cape",           --  Potency of Banish vs. Undead +7
        waist      = "Aswang Sash",                --  +03 Magic Attack Bonus
        legs       = { name     = "Chironic Hose",
                       augments = {'Pet: DEX+13','Accuracy+3','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    })

    sets.midcast['Holy'] = sets.midcast['Banish']

    --  Melee sets
    sets.melee = {}

    sets.melee.Engaged = {
        head       = "Theophany Cap +3",
        body       = "Theo. Briault +3",
        hands      = "Theophany Mitts +3",
        legs       = "Th. Pant. +3",
        feet       = "Theo. Duckbills +3",
        neck       = "Asperity Necklace",
        waist      = "Cetl Belt",
        left_ear   = "Steelflash Earring",
        right_ear  = "Bladeborn Earring",
        left_ring  = "Rajas Ring",
        right_ring = "K'ayres Ring",
        back       = { name     = "Alaunus's Cape",
                       augments = {'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
    }

    sets.melee.WS = {}
    sets.melee.WS['Realmrazer'] = {}
    sets.melee.WS['Hexa Strike'] = {}
    sets.melee.WS['Black Halo'] = {}
    sets.melee.WS['Mystic Boon'] = {}

    sets.OhShi = {
        main       = "Terra's Staff",
        sub        = "Enki Strap",
        ammo       = "Homiliary",
        head       = "Inyanga Tiara +2",
        body       = "Inyanga Jubbah +2",
        hands      = "Inyan. Dastanas +2",
        legs       = "Inyanga Shalwar +2",
        feet       = "Hippo. Socks +1",
        neck       = "Loricate Torque +1",
        waist      = "Isa Belt",
        left_ear   = "Infused Earring",
        right_ear  = { name     = "Moonshade Earring",
                       augments = {'MP+25','Latent effect: "Refresh"+1',}},
        left_ring  = "Defending Ring",
        right_ring = "Gelatinous Ring",
        back       = { name     = "Alaunus's Cape",
                       augments = {'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%','Damage taken-5%',}},
    }

end


function job_precast(spell, action, spellMap, eventArgs)
    -- if player.tp > player_tp_lock then
    --     melee_equip_lock()
    -- end

    check_special_ring_equipped()

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
    elseif spell.name == "Sublimation" and buffactive['Weakness'] then
        --  If weakend, don't waste your Sublimation
        cancel_spell()
        send_command('input /echo *!! Weakend ~ Cancelling Sublimation !!*')
        eventArgs.cancel = true
        return
    elseif spell.name == "Addendum: White" then
        --  No need to waste a strategem on this
        cancel_spell()
        eventArgs.cancel = true
        return
    elseif spell.type == "Trust" then
        equip(sets.Trust)
    elseif spell.name == 'Dia' then
        cancel_spell()
        send_command('input /ma "Dia II" <t>')
    elseif spell.name == 'Reraise' then
        cancel_spell()
        send_command('input /ma "Reraise IV" <me>')
    end

    -- if spell.english == 'Lunge' then
    --     local abil_recasts = windower.ffxi.get_ability_recasts()
    --     if abil_recasts[spell.recast_id] > 0 then
    --         send_command('input /jobability "Swipe" <t>')
    --         add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
    --         eventArgs.cancel = true
    --         return
    --     end
    -- end

    --  I'm not likely to have 4+ images on WHM with /NIN, but leave as is
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



function job_post_midcast(spell, action, spellMap, eventArgs)

    -- if player.tp > player_tp_lock then
    --     melee_equip_lock()
    -- end

    local equipSet = {}

    if (spell.action_type == 'Magic' and spell.skill ~= 'Enhancing Magic') or spell.name == 'Erase' then
        spell_element_match = spell.element == world.weather_element or spell.element == world.day_element
        -- add_to_chat(100, tostring(spellMap))
        if spell.name == 'Erase' then
            equipSet = sets.midcast['Erase']

        elseif (spell.skill == 'Enfeebling Magic' or spell.skill == 'Divine Magic') then
            if spell.skill == 'Enfeebling Magic' then
                equipSet = sets.midcast['Enfeebling Magic']
            elseif spell.skill == 'Divine Magic' then
                equipSet = sets.midcast['Divine Magic']

                if spellMap == 'Banish' or spellMap == 'Holy' then
                    equipSet = sets.midcast['Banish']
                end
            end

            if spell_element_match then
                equipSet = set_combine(equipSet, sets.midcast.WeatherBoost)
            end

        elseif (spell.skill == 'Healing Magic' and not cure_names:contains(spellMap))then
            equipSet = sets.midcast.NASpell

            --  If Divine Caress is active
            if state.Buff.DivineCaress then
                equipSet = set_combine(equipSet, sets.midcast.Caress)
            end

            --  Cursna removal gear is most important. Combine last
            if spell.name == 'Cursna' then
                equipSet = set_combine(equipSet, sets.midcast.Cursna)
            end

        elseif cure_names:contains(spellMap) then
            if spell_element_match then
                equipSet = sets.midcast.CureBonus
            else
                equipSet = sets.midcast.Cure
            end

        elseif spell.type == "Trust" then
            equipSet = sets.Trust
        end

        equip(equipSet)
        eventArgs.handled = true
        return
    end
end


function customize_idle_set(idleSet)
    -- if state.Debug.current == 'on' then
    --    windower.add_to_chat(9, "Currently in: " .. world.area)
    -- end

    -- if player.tp < player_tp_lock then
    --     melee_equip_unlock()
    -- end
    check_special_ring_equipped()

    --  Checking special states
    if state.CP.current == 'on' then
        equip(sets.CP)
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

    if state.OhShi.current == 'on' then
        equip(sets.OhShi)
        equipment_lock_all()
    else
        equipment_unlock_all()
    end

    if state.Weapons.current == 'on' then
        equipment_lock_specific({'main', 'sub',})
    else
        equipment_unlock_specific({'main', 'sub',})
    end

    --  Checking player stats
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    --  If in an assault or salvage zone, equip refresh ring
    if zones_toau_ring:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ToAU)
    end

    --  If in an Adoulin zone, equip body piece if available
    if zones_adoulin_body:contains(world.area) then
        idleSet = set_combine(idleSet, sets.Adoulin)
    end

    --  Check if sublimation is active
    if state.Buff["Sublimation: Activated"] then
        idleSet = set_combine(idleSet, sets.Sublimation)
    end

    return idleSet
end

function user_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        melee_equip_lock()
    elseif oldStatus == 'Engaged' then
        melee_equip_unlock()
    end
end

--  Job specific ability changes, mostly here to handy Sublimation
function job_buff_change(buff, gain, eventArgs)
    if state.Buff["Sublimation: Activated"] then
        equip(sets.Sublimation)
    elseif buff == "Sublimation: Activated" and not gain then
        equip(sets.idle)
    end
end


function job_self_command(cmdParams, eventArgs)

    -- if cmdParams[1]:lower() == 'test' then
    --     add_to_chat(100, reraiseIV)
    -- end

    --  Make Reraise easy to handle
    if (string.find(cmdParams[1]:lower(), 'rr')) and (not buffactive["Reraise"]) then
        local reraise_level = cmdParams[1]:gsub('rr', '')
        if reraise_level == '0' then
            send_command('@input /echo *** Cancelling: No reraise level stated. ***')
        elseif reraise_level == '1' then
            send_command('@input /ma "Reraise" <me>')
        elseif reraise_level == '2' then
            send_command('@input /ma "Reraise II" <me>')
        elseif reraise_level == '3' then
            send_command('@input /ma "Reraise III" <me>')
        elseif reraise_level == '4' then
            send_command('@input /ma "Reraise IV" <me>')
        else
            send_command('@input /echo *** Cancelling: Something weird happened. ***')
        end
        eventArgs.handled = true
        return
    elseif cmdParams[1]:lower() == 'reraise' then
        send_command('@input /echo *** Cancelling: Reraise already active. ***')
        eventArgs.handled = true
        return
    end

    --  Make Raise easy to handle
    if cmdParams[1]:lower() == 'raise' then
        local raise_level = cmdParams[2]
        if reraise_level == 'nil' then
            send_command('@input /echo *** Cancelling. No Raise Level Stated. ***')
        elseif reraise_level == '1' then
            send_command('@input /ma "Raise" <me>')
        elseif reraise_level == '2' then
            send_command('@input /ma "Raise II" <me>')
        elseif reraise_level == '3' then
            send_command('@input /ma "Raise III" <me>')
        elseif reraise_level == '4' then
            send_command('@input /ma "Arise" <me>')
        else
            send_command('@input /echo *** What are you even doing? ***')
        end
        eventArgs.handled = true
        return
    end
end


function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book(true)
end


function select_default_macro_book(isSubJobChange)
    -- Default macro set/book
    set_macro_page(1, 4)

    if not isSubJobChange then
        -- randomise_lockstyle()
    end
end


--  ----------------------------------------------------------------------------------------------------
--                      User defined functions
--  ----------------------------------------------------------------------------------------------------

--  Checks to see if a special ring is equipped in either ring slot.
--  Locks the slot while the ring is in there until it is changed.
--  Definition in: common_lists.lua
function check_special_ring_equipped()
    if equip_lock_rings:contains(player.equipment.left_ring) then
        is_ring_locked = true
        disable("left_ring")
    elseif equip_lock_rings:contains(player.equipment.right_ring) then
        is_ring_locked = true
        disable("right_ring")
    elseif is_ring_locked then
        is_ring_locked = false
        equipment_unlock_specific({'left_ring', 'right_ring',})
    end
end


--  Lock weapon and sub slots
function melee_equip_lock()
    equipment_lock_specific({'main', 'sub',})
end


--  Unlock weapon and sub slots
function melee_equip_unlock()
    equipment_unlock_specific({'main', 'sub',})
end