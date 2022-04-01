-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:

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

function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    --  Load custom string sets for specific items and areas
    include('common_lists.lua')
end

function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{
        "LightSpirit",
        "DarkSpirit",
        "FireSpirit",
        "EarthSpirit",
        "WaterSpirit",
        "AirSpirit",
        "IceSpirit",
        "ThunderSpirit"
    }

    avatars = S{
        "Carbuncle", "Alexander", "Cait Sith",
        "Fenrir", "Diabolos", "Odin",
        "Ifrit",
        "Titan",
        "Leviathan",
        "Garuda", "Siren",
        "Shiva",
        "Ramuh"
    }

    bloodPactRageMagic = S{
        "Meteorite", "Holy Mist",                                       --  Carbuncle
        "Level ? Holy",                                                 --  Cait Sith
        "Lunar Bay", "Impact",                                          --  Fenrir
        "Nether Blast", "Night Terror",                                 --  Diabolos
        "Stone II", "Stone IV", "Geocrush",                             --  Titan
        "Water II", "Water IV", "Grand Fall",                           --  Leviathan
        "Aero II", "Aero IV", "Wind Blade",                             --  Garuda
        "Sonic Buffet", "Tornado II",                                   --  Siren
        "Fire II", "Fire IV", "Burning Strike", "Flaming Crush", "Meteor Strike", "Conflag Strike",     --  Ifrit
        "Blizzard II", "Blizzard IV", "Heavenly Strike",                --  Shiva
        "Thunder II", "Thunder IV", "Thunderspark", "Thunderstorm",     --  Ramuh
    }

    bloodPactWardMagicDebuff = S{

    }

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

    pacts.nuke2 = {
        ['Ifrit']='Fire II',
        ['Shiva']='Blizzard II',
        ['Garuda']='Aero II',
        ['Titan']='Stone II',
        ['Ramuh']='Thunder II',
        ['Leviathan']='Water II'
    }

    pacts.nuke4 = {
        ['Ifrit']='Fire IV',
        ['Shiva']='Blizzard IV',
        ['Garuda']='Aero IV',
        ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV',
        ['Leviathan']='Water IV'
    }

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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
       state.OffenseMode:options('Normal')
       state.CastingMode:options('Normal')
       state.IdleMode:options('Normal')

    select_default_macro_book()
end

function init_gear_sets()

    sets = {}

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    --  Precast
    sets.precast = {}

    sets.precast.JA["Astral Flow"]      = { head="Glyphic Horn" }
    sets.precast.JA["Mana Cede"]        = { hands="Beckoner's Bracers" }
    sets.precast.JA["Elemental Siphon"] = {
        main="Tumafyrig",
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +2",
        neck="Caller's Pendant",
        ear1="Andoaa Earring",
        ear2="Smn. Earring",
        body="Beckoner's Doublet",
        hands={ name="Telchine Gloves", augments={'Pet: "Mag.Atk.Bns."+18','"Elemental Siphon"+35','Enh. Mag. eff. dur. +3',}},
        ring1="Evoker's Ring",
        ring2="Stikini Ring",
        back="Conveyance Cape",
        waist="Cimmerian Sash",
        legs="Tatsu. Sitagoromo",
        feet="Beckoner's Pigaches"
    }

    sets.precast.JA["Blood Pact: Ward"] = {
        ammo="Sancus Sachet",         --BP2 -6
        head="Glyphic Horn",          --BP  -7
        body="Glyphic Doublet +1",    --BP2 -2
        hands="Glyphic Bracers",      --BP  -5
        legs="Glyphic Spats",         --BP  -5
    }

    sets.precast.JA["Blood Pact: Rage"] = sets.precast.JA["Blood Pact: Ward"]

    sets.precast.FC = {}

    sets.precast.WS = {}

    --  Midcast
    sets.midcast = {}

    sets.idle = {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Sancus Sachet",
        head="Convoker's Horn +2",
        neck="Bathy Choker +1",
        ear1="Gifted Earring",
        ear2="Moonshade Earring",
        body="Hagondes Coat +1",
        hands="Inyanga Dastanas +2",
        ring1="Defending Ring",
        ring2="Inyanga Ring",
        back="Solemnity Cape",
        waist="Fucho-no-Obi",
        legs="Inyanga Shalwar +2",
        feet="Inyanga Crackows +2"
    }

    sets.idle.Avatar = {
        main="Gridarvor",
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +2",
        neck="Shulmanu Collar",
        ear1="Lugalbanda Earring",
        ear2="Moonshade Earring",
        body="Glyphic Doublet +1",
        hands="Convoker's Bracers +2",
        ring1="Varar Ring",
        ring2="Varar Ring",
        back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
        waist="Incarnation Sash",
        legs="Assiduity Pants +1",
        feet="Convoker's Pigaches +2"
    }

    sets.idle.Spirit = {
        main="Gridarvor",
        sub="Vox Grip",
        ammo="Sancus Sachet",
        head="Convoker's Horn +2",
        neck="Caller's Pendant",
        ear1="Andoaa Earring",
        ear2="Moonshade Earring",
        body="Glyphic Doublet +1",
        hands="Serpentes Cuffs",
        ring1="Evoker's Ring",
        ring2="Sangoma Ring",
--        back="Samanisi Cape",
        waist="Fucho-no-Obi",
        legs="Glyphic Spats",
        feet="Herald's Gaiters"
    }

    --  Melee
    sets.engaged = {}
end

