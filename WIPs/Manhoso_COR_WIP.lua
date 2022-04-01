function get_sets()
    mote_include_version = 2

    include("Mote-Include.lua")
    include("common_lists.lua")
    include("common_functions.lua")
end

function job_setup()

end

function user_setup()
    state.AttackMode = M(true, "Attack Mode")
    state.MeleeMode = M(true, "Melee Mode")

    send_command("bind @b gs c toggle AttackMode")
    send_command("bind @m gs c toggle MeleeMode")

    gear.RangedDamage = "Compensator"
    gear.RangedBuff = "Fomalhaut"

    gear.RABullet = "Chrono Bullet"
    gear.WSBullet = "Chrono Bullet"
    gear.MABullet = "Chrono Bullet"
    gear.QDBullet = "Chrono Bullet"
end

function user_unload()
    send_command("unbind @b")
    send_command("unbind @m")
end

function init_gear_sets()

    --  Sets: Misc
    sets.idle = {
        head="Meghanada Visor +2",
        body="Meg. Cuirie +1",
        hands="Meg. Gloves +1",
        legs="Meg. Chausses +1",
        feet={ name="Lanun Bottes +1", augments={'Enhances "Wild Card" effect',}},
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Tuisto Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Fortified Ring",
        back="Agema Cape",
    }

    sets.idle.refresh = set_combine(sets.idle, {
        head        = "Rawhide Mask",
        legs        = { name        = "Rawhide Trousers",
                        augments    = {'MP+50','"Fast Cast"+5','"Refresh"+1',}},
    })

    sets.idle.DT = set_combine(sets.idle, {})

    sets.latentRefresh = {}

    --  Sets: Precast Job Abilities
    sets.precast.JA['Triple Shot'] = { body = "Chasseur's Frac" }
    sets.precast.JA['Snake Eye']   = { legs = "Lanun Trews +1" }
    sets.precast.JA['Wild Card']   = { feet = "Lanun Bottes" }
    sets.precast.JA['Random Deal'] = { body = "Comm. Frac +2" }

    sets.precast.CorsairRoll = {
        head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
        body="Meg. Cuirie +1",
        hands="Chasseur's Gants +1",
        legs="Meg. Chausses +1",    --  Desultor Tassets
        feet={ name="Lanun Bottes +1", augments={'Enhances "Wild Card" effect',}},
        neck={ name="Loricate Torque +1", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Odnowa Earring +1",
        right_ear="Tuisto Earring",
        left_ring="Barataria Ring",
        right_ring="Luzaf's Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    sets.precast.CorsairRoll["Blitzer's Roll"]   = set_combine(sets.precast.CorsairRoll, { 
        head    = "Chasseur's Tricorne +1"
    })
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {
        body    = "Chasseur's Frac"
    })
    sets.precast.CorsairRoll["Allies' Roll"]     = set_combine(sets.precast.CorsairRoll, {
        hands    = "Chasseur's Gants +1"
    })
    sets.precast.CorsairRoll["Caster's Roll"]    = set_combine(sets.precast.CorsairRoll, {
        legs    = "Chas. Culottes"
    })
    sets.precast.CorsairRoll["Courser's Roll"]   = set_combine(sets.precast.CorsairRoll, {
        feet    = "Chass. Bottes"
    })

    sets.precast.FoldDoubleBust = {
        hands = "Lanun Gants"
    }

    --  Sets: Engaged
    sets.engaged.Melee = {
        head="Meghanada Visor +2",
        body="Meg. Cuirie +1",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Asperity Necklace",
        waist="Cetl Belt",
        left_ear="Mache Earring",
        right_ear="Odr Earring",
        left_ring="Meghanada Ring",
        right_ring="Mummu Ring",
        back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20',}},
    }
    sets.engaged.Ranged = {}

    --  Precast Sets: Ranged Attack
    sets.precast.RA = {
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands={ name="Lanun Gants", augments={'Enhances "Fold" effect',}},
        legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
        feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Beyla Earring",
        right_ear="Enervating Earring",
        left_ring="Dingir Ring",
        right_ring="Mummu Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    sets.precast.CorsairShot = {
        head="Laksa. Tricorne +2",
        body="Laksa. Frac +3",
        hands={ name="Pursuer's Cuffs", augments={'Rng.Atk.+15','STR+7','Phys. dmg. taken -4',}},
        legs="Laksa. Trews +2",
        feet="Chasseur's Bottes",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Eschan Stone",
        left_ear="Friomisi Earring",
        right_ear="Beyla Earring",
        left_ring="Dingir Ring",
        right_ring="Arvina Ringlet +1",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
    }

    --  Precast Sets: Weapon Skills
    sets.precast.WS = {}
    sets.precast.WS["Savage Blade"] = {}
    sets.precast.WS["Last Stand"] = {}
    sets.precast.WS["Wildfire"] = {}
    sets.precast.WS["Leaden Salute"] = {}

    sets.midcast.RA = {
        head="Meghanada Visor +2",
        body="Laksa. Frac +3",
        hands="Meg. Gloves +1",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck={ name="Commodore Charm", augments={'Path: A',}},
        waist="Kwahu Kachina Belt",
        left_ear="Beyla Earring",
        right_ear="Enervating Earring",
        left_ring="Paqichikaji Ring",
        right_ring="Meghanada Ring",
        back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},    
    }

end