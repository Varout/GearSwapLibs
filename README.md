# GearSwap Libs for FFXI by Varout (Varrout on Phoenix)

Most luas have the ability to lock in certain rings to make sure they aren't unequipped when casting spells or buffs wear off.
e.g. You've just finished an event, your buffs are on cooldown and you've got a Warp Ring on, as a buff wears off there is a check to see if you have a Warp Ring equipped and if so, it is locked in place until manually unequipped.

## Varrout (Varout on Titan)

The character I've been playing on and off since 2004.  Mains are White Mage and Dragoon.

### White Mage (WHM)

#### Custom GearSwap Commands
- Windows Key + C: Toggles the Cursna casting mode between single target (Gambanteinn[Potency]) & area of effect (Yagrush)
- Windows Key + M: Brings up the map because I'm lazy
- Windows Key + 1: Takes into account recasts and casts the highest available Raise spell on selected target
- Windows Key + 2: Takes into account recasts and casts the highest available Reraise spell

#### Dependencies
- `Mote-Include.lua`
- `common_lists.lua`
- `common_functions.lua`

### Dragoon (DRG)

Rework in progress

### Scholar (SCH)

Rework in progress

## Manhoso

### Corsair (COR)

Rework in progress

## Custom LUA filess

### Custom Functions
&nbsp;&nbsp;File: `custom_functions.lua`<br/>
&nbsp;&nbsp;&nbsp;&nbsp;About: Contains custom functions which are used throughout many lua scripts. Extracted for easy reusability.


&nbsp;&nbsp;&nbsp;&nbsp;File: `custom_lists.lua`<br/>
&nbsp;&nbsp;&nbsp;&nbsp;About: Contains custom lists like areas and spell maps, extending what is already included in the default `Mote-Include.lua` suite.