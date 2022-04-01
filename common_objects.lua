-------------------------------------------------------------------------------------------------------------------
--  White Magic
-------------------------------------------------------------------------------------------------------------------

DivineCaress = {}
DivineCaress.statusActive = false
DivineCaress.slot = 'hands'
DivineCaress.midcast = {
    hands = "Ebers Mitts +1"    --  Divine Caress +3
}
function DivineCaress.toggle(status)
    if status then
        DivineCaress.status = true
        equip(DivineCaress.midcast)
        disable(DivineCaress.slot)
    else
        DivineCaress.status = false
        enable(DivineCaress.slot)
    end
end