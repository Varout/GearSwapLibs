local rolls = {
    ["Allies's Roll"]     = { lucky = 3, unlucky = 10, bonus="Skillchain Damage" },
    ["Avenger's Roll"]    = { lucky = 4, unlucky = 8,  bonus="Counter Rate" },
    ["Beast Roll"]        = { lucky = 4, unlucky = 8,  bonus="Pet Attack" },
    ["Blitzer's Roll"]    = { lucky = 4, unlucky = 9,  bonus="Attack Delay" },
    ["Bolter's Roll"]     = { lucky = 3, unlucky = 9,  bonus="Movement Speed" },
    ["Caster's Roll"]     = { lucky = 2, unlucky = 7,  bonus="Fast Cast" },
    ["Chaos Roll"]        = { lucky = 4, unlucky = 8,  bonus="Attack" },
    ["Choral Roll"]       = { lucky = 2, unlucky = 6,  bonus="Spell Interruption Rate" },
    ["Companion's Roll"]  = { lucky = 2, unlucky = 10, bonus="Pet Regain and Regen" },
    ["Corsair's Roll"]    = { lucky = 5, unlucky = 9,  bonus="Experience Points" },
    ["Courser's Roll"]    = { lucky = 3, unlucky = 9,  bonus="Snapshot" },
    ["Dancer's Roll"]     = { lucky = 3, unlucky = 7,  bonus="Regen" },
    ["Drachen Roll"]      = { lucky = 4, unlucky = 8,  bonus="Pet Magic Accuracy/Attack" },
    ["Evoker's Roll"]     = { lucky = 5, unlucky = 9,  bonus="Refresh" },
    ["Fighter's Roll"]    = { lucky = 5, unlucky = 9,  bonus="Double Attack Rate" },
    ["Gallant's Roll"]    = { lucky = 3, unlucky = 7,  bonus="Defense" },
    ["Healer's Roll"]     = { lucky = 3, unlucky = 7,  bonus="Cure Potency Received" },
    ["Hunter's Roll"]     = { lucky = 4, unlucky = 8,  bonus="Accuracy" },
    ["Magus's Roll"]      = { lucky = 2, unlucky = 6,  bonus="Magic Defense" },
    ["Miser's Roll"]      = { lucky = 5, unlucky = 7,  bonus="Save TP" },
    ["Monk's Roll"]       = { lucky = 3, unlucky = 7,  bonus="Subtle Blow" },
    ["Naturalist's Roll"] = { lucky = 3, unlucky = 7,  bonus="Enh. Magic Duration" },
    ["Ninja Roll"]        = { lucky = 4, unlucky = 8,  bonus="Evasion" },
    ["Puppet Roll"]       = { lucky = 3, unlucky = 7,  bonus="Pet Magic Attack/Accuracy" },
    ["Rogue's Roll"]      = { lucky = 5, unlucky = 9,  bonus="Critical Hit Rate" },
    ["Runeist's Roll"]    = { lucky = 4, unlucky = 8,  bonus="Magic Evasion" },
    ["Samurai Roll"]      = { lucky = 2, unlucky = 6,  bonus="Store TP" },
    ["Scholar's Roll"]    = { lucky = 2, unlucky = 6,  bonus="Conserve MP" },
    ["Tactician's Roll"]  = { lucky = 5, unlucky = 8,  bonus="Regain" },
    ["Warlock's Roll"]    = { lucky = 4, unlucky = 8,  bonus="Magic Accuracy" },
    ["Wizard's Roll"]     = { lucky = 5, unlucky = 9,  bonus="Magic Attack" },
}

function display_roll_info(spell)
    rollinfo = rolls[spell.english]

    if rollinfo then
        add_to_chat(104,
        '[ Lucky: ' .. tostring(rollinfo.lucky) ..
        ' / Unlucky: ' .. tostring(rollinfo.unlucky) .. ' ] ' ..
        spell.english .. ': ' .. rollinfo.bonus
    )
    end
end