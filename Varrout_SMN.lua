-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:

    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.

    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.

        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.

    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    --  Load common lua lists and functions
    include('common_lists.lua')
    include('common_functions.lua')

    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren", "Atmos"}

    magicalRagePacts = S{
        'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon','Ruinous Omen',
        'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV',
        'Thunderspark','Burning Strike','Meteorite','Nether Blast','Flaming Crush',
        'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm',
        'Holy Mist','Lunar Bay','Impact','Night Terror','Level ? Holy','Conflag Strike'}
    meritBloopPacts = S{'Meteor Strike','Heavenly Strike','Wind Blade','Geocrush','Grand Fall','Thunderstorm'}

    pacts = {}
    pacts.cure = {
        ['Carbuncle']='Healing Ruby'
    }
    pacts.curaga = {
        ['Carbuncle']='Healing Ruby II',
        ['Garuda']='Whispering Wind',
        ['Leviathan']='Spring Water'
    }
    pacts.buffoffense = {
        ['Carbuncle']='Glittering Ruby',
        ['Ifrit']='Crimson Howl',
        ['Garuda']='Hastega',
        ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'
    }
    pacts.buffdefense = {
        ['Carbuncle']='Shining Ruby',
        ['Shiva']='Frost Armor',
        ['Garuda']='Aerial Armor',
        ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor',
        ['Fenrir']='Ecliptic Howl',
        ['Diabolos']='Noctoshield',
        ['Cait Sith']='Reraise II'
    }
    pacts.buffspecial = {
        ['Ifrit']='Inferno Howl',
        ['Garuda']='Fleet Wind',
        ['Titan']='Earthen Armor',
        ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby',
        ['Fenrir']='Heavenward Howl',
        ['Cait Sith']='Raise II'
    }
    pacts.debuff1 = {
        ['Shiva']='Diamond Storm',
        ['Ramuh']='Shock Squall',
        ['Leviathan']='Tidal Roar',
        ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus',
        ['Cait Sith']='Eerie Eye'
    }
    pacts.debuff2 = {
        ['Shiva']='Sleepga',
        ['Leviathan']='Slowga',
        ['Fenrir']='Lunar Roar',
        ['Diabolos']='Somnolence'
    }
    pacts.sleep = {
        ['Shiva']='Sleepga',
        ['Diabolos']='Nightmare',
        ['Cait Sith']='Mewing Lullaby'
    }
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {
        ['Ifrit']='Flaming Crush',
        ['Shiva']='Rush',
        ['Garuda']='Predator Claws',
        ['Titan']='Mountain Buster',
        ['Ramuh']='Volt Strike',
        ['Leviathan']='Spinning Dive',
        ['Carbuncle']='Meteorite',
        ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',
        ['Cait Sith']='Regal Scratch'
    }
    pacts.bp75 = {
        ['Ifrit']='Meteor Strike',
        ['Shiva']='Heavenly Strike',
        ['Garuda']='Wind Blade',
        ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm',
        ['Leviathan']='Grand Fall',
        ['Carbuncle']='Holy Mist',
        ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror',
        ['Cait Sith']='Level ? Holy',
        ['Siren']='Hysteric Assault'
    }
    pacts.astralflow = {
        ['Ifrit']='Inferno',
        ['Shiva']='Diamond Dust',
        ['Garuda']='Aerial Blast',
        ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt',
        ['Leviathan']='Tidal Wave',
        ['Carbuncle']='Searing Light',
        ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen',
        ['Cait Sith']="Altana's Favor",
        ['Siren']='Clarsach Call'
    }
    pacts.pb99 = {
        ['Ifrit']='Conflag Strike',     --  Fire damage, burn
        ['Shiva']='Rush',               --  Lv70
        ['Garuda']='Predator Claws',    --  Lv70
        ['Titan']='Crag Throw',         --  Single hit, slow
        ['Ramuh']='Volt Strike',        --  3-Hit, Stun
        ['Leviathan']='Spinning Dive',  --  Lv70
        ['Carbuncle']='Meteorite',      --  Lv70
        ['Fenrir']='Impact',            --  Dark damage
        ['Diabolos']='Blindside',       --  Single hit
        ['Cait Sith']='Regal Gash',     --  3-Hit
        ['Siren']='Hysteric Assault'    --  Lv70
    }

    -- Wards table for creating custom timers
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60,      ['Earthen Armor'] = 60,     ['Inferno Howl'] = 60,
        ['Heavenward Howl'] = 60,   ['Rolling Thunder'] = 120,  ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180,     ['Frost Armor'] = 180,      ['Lightning Armor'] = 180,
        ['Ecliptic Growl'] = 180,   ['Glittering Ruby'] = 180,  ['Hastega'] = 180,
        ['Noctoshield'] = 180,      ['Ecliptic Howl'] = 180,    ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
--    wards.icons = {
--        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
--        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
--        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
--        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
--        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
--        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
--        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
--        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
--        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
--        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
--        ['Fleet Wind']      = 'abilities/00074.png', --
--    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
--    state.OffenseMode:options('None', 'Normal', 'Acc')
--    state.CastingMode:options('Normal', 'Resistant')
--    state.IdleMode:options('Normal', 'PDT')

    gear.perp_staff = {name=""}

    select_default_macro_book()
end


function job_handle_equipping_gear(playerStatus, eventArgs)
    check_special_ring_equipped()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.ArtefactHead  = "Convoker's Horn +2"
    gear.ArtefactBody  = "Convoker's Doublet +2 "
    gear.ArtefactHands = "Convoker's Bracers +2"
    gear.ArtefactLegs  = "Convoker's Spats +2"
    gear.ArtefactFeet  = "Convoker's Pigaches +2"

    gear.RelicHead  = "Glyphic Horn +1"
    gear.RelicBody  = "Glyphic Doublet +1"
    gear.RelicHands = "Glyphic Bracers +1"
    gear.RelicLegs  = "Glyphic Spats +1"
    gear.RelicFeet  = "Glyphic Pigaches +1"

    gear.EmpyreanHead  = "Beckoner's Horn +1"
    gear.EmpyreanBody  = "Beckoner's Doublet +1"
    gear.EmpyreanHands = "Beckoner's Bracers +1"
    gear.EmpyreanLegs  = "Beckoner's Spats +1"
    gear.EmpyreanFeet  = "Beckoner's Pigaches +1"

    gear.EmpyreanEarring = "Beckoner's Earring +1"
    gear.DynamisNeck     = ""

    gear.AmbuscadeCapePhys  = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}}
    gear.AmbuscadeCapeMagic = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10',}}

    gear.ApogeeFeetPhys  = { name="Apogee Pumps", augments={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}}
    gear.ApogeeFeedMagic = { name="Apogee Pumps", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}}

    gear.MerlinicHandsMagicAtt = { name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+27','Blood Pact Dmg.+4','Pet: DEX+7','Pet: Mag. Acc.+7',}}
    gear.MerlinicHandsPhysAtt  = { name="Merlinic Dastanas", augments={'Pet: Attack+18 Pet: Rng.Atk.+18','Blood Pact Dmg.+9','Pet: CHR+4','Pet: Mag. Acc.+2',}}

    --------------------------------------
    -- Idle/Resting/Defense/Etc Sets
    --------------------------------------
    -- Resting sets
    sets.resting = {
        main        = "Boonwell Staff",
        sub         = "Ariesian Grip",
        ammo        = "Mana Ampulla",
        head        = "Orvail Corona +1",
        body        = "Chelona Blazer",
        hands       = "Nares Cuffs",
        legs        = "Nisse Slacks",
        feet        = "Chelona Boots",
        neck        = "Eidolon Pendant +1",
        waist       = "Austerity Belt",
        left_ear    = { name     = "Moonshade Earring",
                        augments = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Angha Ring",
        right_ring  = "Star Ring",
        back        = "Felicitas Cape",
    }

    -- Idle sets
    sets.idle = {
        main        = { name     = "Mpaca's Staff",
                        augments = {'Path: A',}},
        sub         = "Enki Strap",
        ammo        = "Sancus Sachet",
        head        = gear.ArtefactHead,
        body        = "Shomonjijoe +1",
        hands       = "Inyan. Dastanas +2",
        legs        = "Inyanga Shalwar +2",
        feet        = "Inyan. Crackows +2",
        neck        = { name     = "Loricate Torque +1",
                        augments = {'Path: A',}},
        waist       = "Platinum Moogle Belt",
        left_ear    = { name     = "Moonshade Earring",
                        augments = {'MP+25','Latent effect: "Refresh"+1',}},
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Stikini Ring +1",
        right_ring  = "Inyanga Ring",
        back        = "Solemnity Cape",
    }

    sets.idle.LatentRefresh = {
        waist="Fucho-no-Obi",
    }

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick

    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.

    -- -perp gear:
    -- Gridarvor: -5
    -- gear.RelicHead: -4
    -- gear.EmpyeanBody: -6
    -- Evoker's Ring: -1
    -- gear.ArtefactFeet: -5
    -- total: -18

    -- Can make due without either the head or the body, and use +refresh items in those slots.
    --  Idle.  Pet not engaged.  +10 Refresh.  Pet Regain, Regen, Damage taken -5%
    sets.idle.Avatar = {
        main        = { name     = "Gridarvor",
                        augments = {'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub         = "Vox Grip",
        ammo        = "Sancus Sachet",
        head        = gear.ArtefactHead,
        body        = "Shomonjijoe +1",
        hands       = gear.ArtefactHands,
        legs        = "Assid. Pants +1",
        feet        = gear.ApogeeFeetPhys,
        neck        = "Caller's Pendant",
        waist       = "Isa Belt",
        left_ear    = "Lodurr Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Stikini Ring +1",
        right_ring  = "Evoker's Ring",
        back        = gear.AmbuscadeCapePhys,
    }

    sets.idle.Avatar.Favor = {
        head=gear.EmpyreanHead
    }

    sets.idle.Avatar.Melee = {
        main        = { name     = "Gridarvor",
                        augments = {'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub         = "Vox Grip",
        ammo        = "Sancus Sachet",
        head        = gear.ArtefactHead,
        body        = "Shomonjijoe +1",
        hands       = gear.ArtefactHands,
        legs        = gear.ArtefactLegs,
        feet        = gear.ApogeeFeetPhys,
        neck        = "Shulmanu Collar",
        waist       = "Incarnation Sash",
        left_ear    = "Lugalbanda Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Varar Ring +1",
        right_ring  = "Varar Ring +1",
        back        = gear.AmbuscadeCapePhys,
    }

    sets.idle.Spirit = set_combine(sets.idle.Avatar, {
        legs        = gear.RelicLegs,
        neck        = "Incanter's Torque",
        waist       = "Lucidity Sash",
    })

    --------------------------------------
    -- Summonging Magic Related Sets
    --------------------------------------
    sets.SummoningMagic = {
        main        = { name     = "Espiritus",         --  +15
                        augments = {'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub         = "Vox Grip",                       --  + 3
        -- ammo="Sancus Sachet",
        head        = gear.ArtefactHead,                --  +17
        body        = gear.EmpyreanBody,                --  +14
        hands       = "Lamassu Mitts +1",               --  +22
        legs        = gear.EmpyreanLegs,                --  +20
        -- feet="",
        neck        = "Incanter's Torque",              --  +10
        waist       = "Lucidity Sash",                  --  + 7
        left_ear    = "Lodurr Earring",                 --  +10
        right_ear   = "Andoaa Earring",                 --  + 5
        left_ring   = "Stikini Ring +1",                --  + 8
        right_ring  = "Evoker's Ring",                  --  +10
        back        = { name     = "Conveyance Cape",   --  +10
                        augments = {'Summoning magic skill +2','Pet: Enmity+14','Blood Pact Dmg.+1','Blood Pact ab. del. II -2',}},
    }

    sets.precast.JA["Elemental Siphon"] = set_combine(sets.SummoningMagic, {
        ammo        = "Esper Stone +1",                 --  +20
        hands       = { name     = "Telchine Gloves",   --  +35
                        augments = {'Pet: "Mag.Atk.Bns."+18','"Elemental Siphon"+35','Enh. Mag. eff. dur. +3',}},
        legs        = "Tatsu. Sitagoromo",              --  +20
        feet        = gear.EmpyreanFeet,                --  +60
    })

    sets.perp = {}
    sets.perp.Alexander = sets.SummoningMagic


    --------------------------------------
    -- Precast Sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {
        head        = gear.RelicHead
    }

    sets.precast.JA['Mana Cede'] = {
        hands=gear.EmpyreanHands
    }

    -- Pact delay reduction gear
    sets.precast.BloodPact = {
        --  Totall BP: -16 (capped at -15)
        head        = "Accord Hat +1",              --  BP: -9
        hands       = gear.RelicHands,              --  BP: -6
        --  Total BP2: -13
        main        = { name     = "Espiritus",     --  BP2: -2
                        augments = {'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        ammo        = "Sancus Sachet",              --  BP2: -6
        body        = gear.RelicBody,               --  BP2: -2
        feet        = gear.RelicFeet,               --  BP2: -1
        back        = "Conveyance Cape",            --  BP2: -2 (Max -3)
    }

    sets.precast.BloodPactWard = sets.precast.BloodPact
    sets.precast.BloodPactRage = sets.precast.BloodPact

    -- Fast cast sets for spells
    sets.precast.FC = {
        main        = "Oranyan",            -- FC +7%
        sub         = "Clerisy Strap",      -- FC +2%
        head        = "Revealer's Crown",   -- FC +5%
        body        = "Inyanga Jubbah +2",  -- FC +14%
        hands       = "Shrieker's Cuffs",   -- 0%, Resist Silence +25
        legs        = "Orvail Pants +1",    -- FC +5%
        feet        = "Regal Pumps +1",     -- FC +4~7%
        neck        = "Baetyl Pendant",     -- FC +4%
        waist       = "Embla Sash",         -- FC +5%
        left_ear    = "Loquac. Earring",    -- FC +2%
        right_ear   = "Etiolation Earring", -- FC +1%
        left_ring   = "Medada's Ring",      -- FC +10%
        right_ring  = "Lebeche Ring",       -- Quick Magic +2%
        back        = "Perimede Cape",      -- Quick Magic +4%
    }

    sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, {
        waist       = "Siegel Sash"
    })

    sets.precast.FC["Stoneskin"] = set_combine(sets.precast.FC["Enhancing Magic"], {
        head        = "Umuthi Hat",
        hands       = "Carapacho Cuffs",
        legs        = "Doyen Pants",
    })

    sets.precast.FC["Healing Magic"] = set_combine(sets.precast.FC, {
        main        = "Vadose Rod",
        sub         = "Culminus"
    })

    sets.precast.FC["Cure"] = set_combine({sets.precast.FC["Healing Magic"],
        main        = "Vadose Rod",
        sub         = "Sors Shield",
        head        = { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = "Heka's Kalasiris",
        legs        = "Doyen Pants",
        feet        = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        right_ear   = "Mendi. Earring",
        back        = "Pahtli Cape",
    })
    sets.precast.FC["Curaga"] = sets.precast.FC["Cure"]

    sets.precast.WS = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------
    sets.midcast.Cure = {
        main        = "Raetic Rod",
        sub         = "Sors Shield",
        ammo        = "Quartz Tathlum +1",
        head        = { name     = "Vanya Hood",
                        augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        body        = "Heka's Kalasiris",
        hands       = "Inyan. Dastanas +2",
        legs        = "Assid. Pants +1",
        feet        = { name     = "Vanya Clogs",
                        augments = {'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        neck        = "Incanter's Torque",
        waist       = "Bishop's Sash",
        left_ear    = "Beatific Earring",
        right_ear   = "Meili Earring",
        left_ring   = "Jann. Ring +1",
        right_ring  = "Sirona's Ring",
        back        = "Altruistic Cape",
    }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        waist       = "Hachirin-no-Obi",
        back        = "Twilight Cape",
    })

    sets.midcast["Enhancing Magic"] = {
        main        = "Oranyan",
        sub         = "Fulcio Grip",
        ammo        = "Sancus Sachet",
        head        = "Befouled Crown",
        body        = "Anhur Robe",
        hands       = "Inyan. Dastanas +2",
        legs        = "Shedir Seraweels",
        feet        = { name     = "Telchine Pigaches",
                        augments = {'Enh. Mag. eff. dur. +8',}},
        neck        = "Incanter's Torque",
        waist       = "Embla Sash",
        left_ear    = "Mimir Earring",
        right_ear   = "Andoaa Earring",
        left_ring   = "Stikini Ring +1",
        right_ring  = "Stikini Ring",
        back        = "Merciful Cape",
    }

    sets.midcast["Aquaveil"] = set_combine(sets.midcast["Enhancing Magic"], {
        main        = "Vadose Rod",
        legs        = "Shedir Seraweels",
        waist       = "Emphatikos Rope",
    })

    sets.midcast["Stoneskin"] = set_combine(sets.midcast["Enhancing Magic"], {
        neck        = "Nodens Gorget",
        legs        = "Shedir Seraweels",
        right_ear   = "Earthcry Earring",
        waist       = "Siegel Sash",
    })

    sets.midcast["Barspell"] = set_combine(sets.midcast["Enhancing Magic"], {
        legs        = "Shedir Seraweels",
    })

    -- Avatar pact sets.  All pacts are Ability type.

    sets.midcast.Pet.BloodPactWard = sets.SummoningMagic

    sets.midcast.Pet.DebuffBloodPactWard = {
        main        = { name     = "Espiritus",
                        augments = {'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub         = "Vox Grip",
        ammo        = "Sancus Sachet",
        head        = gear.ArtefactHead,
        body        = gear.ArtefactBody,
        hands       = gear.ArtefactHands,
        legs        = gear.ArtefactLegs,
        feet        = gear.ArtefactFeet,
        neck        = "Adad Amulet",
        waist       = "Incarnation Sash",
        left_ear    = "Lugalbanda Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Tali'ah Ring",
        right_ring  = "Evoker's Ring",
        back        = gear.AmbuscadeCapeMagic,
    }

    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard

    sets.midcast.Pet.PhysicalBloodPactRage = {
        main        = { name     = "Gridarvor",
                        augments = {'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub         = "Elan Strap",
        ammo        = "Sancus Sachet",
        head        = { name     = "Apogee Crown +1",
                        augments = {'Pet: Attack+25','Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+8',}},
        body        = gear.RelicBody,
        hands       = gear.MerlinicHandsPhysAtt,
        legs        = { name     = "Helios Spats",
                        augments = {'Pet: "Mag.Atk.Bns."+26','Pet: Crit.hit rate +3',}},
        feet        = gear.ApogeeFeetPhys,
        neck        = "Shulmanu Collar",
        waist       = "Regal Belt",
        left_ear    = "Lugalbanda Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Varar Ring +1",
        right_ring  = "Varar Ring +1",
        back        = gear.AmbuscadeCapePhys,
    }

    sets.midcast.Pet.PhysicalBloodPactRage['Garuda'] = set_combine(sets.midcast.Pet.PhysicalBloodPactRage, {
        head        = "Kurara Hachigane",
    })

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = {
        main        = { name     = "Gridarvor",
                        augments = {'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
        sub         = "Elan Strap",
        ammo        = "Sancus Sachet",
        head        = gear.ArtefactHead,
        body        = gear.ArtefactBody,
        hands       = gear.ArtefactHands,
        legs        = gear.ArtefactLegs,
        feet        = gear.ArtefactFeet,
        neck        = "Shulmanu Collar",
        waist       = "Klouskap Sash",
        left_ear    = "Lugalbanda Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Varar Ring +1",
        right_ring  = "Varar Ring +1",
        back        = gear.AmbuscadeCapePhys,
    }

    sets.midcast.Pet.MagicalBloodPactRage = {
        main        = { name     = "Espiritus",
                        augments = {'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
        sub         = "Elan Strap",
        ammo        = "Sancus Sachet",
        head        = { name     = "Apogee Crown +1",
                        augments = {'Pet: Attack+25','Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+8',}},
        body        = gear.ArtefactBody,
        hands       = gear.MerlinicHandsMagicAtt,
        legs        = { name="Helios Spats", augments={'Pet: "Mag.Atk.Bns."+26','Pet: Crit.hit rate +3',}},
        feet        =  gear.ApogeeFeedMagic,
        neck        = "Adad Amulet",
        waist       = "Regal Belt",
        left_ear    = "Lugalbanda Earring",
        right_ear   = gear.EmpyreanEarring,
        left_ring   = "Varar Ring +1",
        right_ring  = "Varar Ring +1",
        back        = gear.AmbuscadeCapeMagic,
    }

    sets.midcast.Pet.MagicalBloodPactRage['Ifrit'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
        ring2       = "Fervor Ring"
    })

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage

    sets.midcast.Pet.MeritBP = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {
        body        = gear.RelicBody,
        hands       = gear.RelicHands,
        legs        = gear.RelicLegs,
        feet        = gear.RelicFeet,
    })

    sets.midcast.Trust = {
        main        = "Bolelabunga",
        sub         = "Ammurapi Shield",
        ammo        = "Sancus Sachet",
        head        = "Inyanga Tiara +2",
        body        = "Inyanga Jubbah +2",
        hands       = "Inyanga Dastanas +2",
        legs        = "Inyanga Shalwar +2",
        feet        = "Inyanga Crackows +2"
    }

--     sets.perp = {}
--     -- Caller's Bracer's halve the perp cost after other costs are accounted for.
--     -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
--     -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
--     -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
--     -- sets.perp.Day = {hands="Caller's Bracers +2"}
--     -- sets.perp.Weather = {neck="Caller's Pendant",hands="Caller's Bracers +2"}
--     -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
-- --    sets.perp.Carbuncle = {main="Bolelabunga",sub="Genbu's Shield",
-- --        head=gear.ArtefactHead,body="Hagondes Coat",hands="Carbuncle Mitts",legs="Nares Trews",feet=gear.ArtefactFeet}
--     -- Diabolos's Rope doesn't gain us anything at this time
--     --sets.perp.Diabolos = {waist="Diabolos's Rope"}
--     sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

--     sets.perp.staff_and_grip = {main=gear.perp_staff,sub="Vox Grip"}

--     -- Defense sets
--     sets.defense.PDT = {main=gear.Staff.PDT,
--         head="Hagondes Hat",neck="Wiglen Gorget",ear1="Gifted Earring",ear2="Loquacious Earring",
--         body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
-- --        back="Umbra Cape",
--         waist="Fucho-no-Obi",legs="Hagondes Pants",feet="Hagondes Sabots"}

--     sets.defense.MDT = {
--         head="Hagondes Hat",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
--         body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
-- --        back="Umbra Cape",
--         waist="Fucho-no-Obi",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet="Herald's Gaiters"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Normal melee group
    -- sets.engaged = sets.idle.Avatar
        -- {ammo="Sancus Sachet",
        -- head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        -- back="Conveyance Cape",
        -- waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if meritBloopPacts:contains(spell.name) then
        equip(sets.midcast.Pet.MeritBP)
        eventArgs.handled = true
        return
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
--    else
--        select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    elseif spell.type == 'Trust' then
        return 'Trust'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        -- if pet.element == world.day_element then
        --     idleSet = set_combine(idleSet, sets.perp.Day)
        -- end
        -- if pet.element == world.weather_element then
        --     idleSet = set_combine(idleSet, sets.perp.Weather)
        -- end
        -- if sets.perp[pet.name] then
        --     idleSet = set_combine(idleSet, sets.perp[pet.name])
        -- end
        -- gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        -- if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name] or player.wardrobe2[gear.perp_staff.name]) then
        --     idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        -- end

        --  Decide which pet set to equip: Avatar or Spirit
        if avatars:contains(pet.name) then
            idleSet = sets.idle.Avatar
        else
            idleSet = sets.idle.Spirit
        end

        --  Check if Avatar's Favor is active
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end

        --  Equip TP/Melee set if Engaged
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    else
        --  No pet, so just laten refresh
        idleSet = sets.idle

        if player.mpp < 51 then
            idleSet = set_combine(idleSet, sets.idle.LatentRefresh)
        end
    end

    -- add_to_chat(100, tostring(pet.isvalid))
    -- add_to_chat(100, tostring(pet.name))
    -- add_to_chat(100, tostring(state.Buff["Avatar's Favor"]))

    --  Return built idle set
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'pact' then
        handle_pacts(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end

    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end

    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end

    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end

    local storm = elements.storm_of[element]

    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease

    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end

    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end

    local command = ''
    local releaseWait = 0

    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end

    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end

    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end

    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1

    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end

        command = command..'input /pet "Release" <me>;'
    end

    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end

    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
--        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end

    local pact = cmdParams[2]:lower()

    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end

    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end

        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end

        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'

--        if wards.icons[spell_name] then
--            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
--        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
--    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
--    end

    -- Default macro set/book
    set_macro_page(3, 3)
end


windower.register_event('zone change',
    function()
        equipment_unlock_specific({"left_ring", "right_ring",})
        equip(sets.idle)
    end
)