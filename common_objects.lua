-------------------------------------------------------------------------------------------------------------------
--  White Magic
-------------------------------------------------------------------------------------------------------------------
DivineCaress = {}
DivineCaress.statusActive = false
DivineCaress.slot = 'hands'
DivineCaress.midcast = {
    hands = "Ebers Mitts +3"    --  Divine Caress +4
}
function DivineCaress.toggle(isActive)
    DivineCaress.statusActive = isActive
    if status then
        equip(DivineCaress.midcast)
        disable(DivineCaress.slot)
    else
        enable(DivineCaress.slot)
    end
end