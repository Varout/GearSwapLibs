# GearSwap Libs for FFXI by Varout (Varrout on Phoenix)

## Progress Tracking

### Eargon Weapon NMs

_To be revised_<br />
Used to track progress towards an Eargon weapon.

### Mythic Weapon Progress

_Updates to be made_<br />
Used to track progress towards a Mythic weapon.
Also has a table to keep track of your Salvage runs if you want to do that.

### SoA Progress

Used to track progress towards getting Ygnas Trust and upgrading your ring to +1.

### Weather Gear

Used to track progress towards weather related gear with an end goal being the item that combines all 8 elements:

- Hachirin-no-Obi
- Fotia Gorget
- Fotia Belt

Most luas have the ability to lock in certain rings to make sure they aren't unequipped when casting spells or buffs wear off.
e.g. You've just finished an event, your buffs are on cooldown and you've got a Warp Ring on, as a buff wears off there is a check to see if you have a Warp Ring equipped and if so, it is locked in place until manually unequipped.

## Varrout (Varout on Titan)

The character I've been playing on and off since 2004. Mains are White Mage and Dragoon.

### White Mage (WHM)

#### Custom GearSwap Commands

- `Windows Key + C`: Toggles the Cursna casting mode between single target (Gambanteinn[Potency]) & area of effect (Yagrush)
- `Windows Key + M`: Brings up the map because I'm lazy
- `Windows Key + 1`: Takes into account recasts and casts the highest available Raise spell on selected target
- `Windows Key + 2`: Takes into account recasts and casts the highest available Reraise spell

#### Dependencies

- `Mote-Include.lua`
- `Varrout_WHM_GearSets.lua`
- `common_functions.lua`
- `common_lists.lua`

### Dragoon (DRG)

#### Custom GearSwap Commands

_none_

#### Dependencies

- `Mote-Include.lua`
- `Varrout_DRG_GearSets.lua`
- `common_functions.lua`
- `common_lists.lua`

### Scholar (SCH)

Rework in progress

## Manhoso

### Corsair (COR)

#### Custom GearSwap Commands

- `Ctrl + ,`: (DNC) Does 'Spectral Jig'

#### Dependencies

- `Mote-Include.lua`
- `Manhoso_COR_GearSets.lua`
- `COR_Roll_Values.lua`
- `common_functions.lua`
- `common_lists.lua`

## Custom LUA filess

### COR Roll Values

**File:** `COR_Roll_Values.lua`<br />
**About:** Contains a list of all Corsair Phantom Rolls with information about their luck and unlucky numbers.<br />
**Use:** Import using `include('COR_Roll_Values.lua)` in your `get_sets()`. In `job_aftercast(spell, action, spellMap, eventAgrs)` you can include something along the lines of:

```lua
if spell.type == 'CorsairRoll' and not spell.interrupted then
    display_roll_info(spell)
end
```

### Custom Functions

**File:** `custom_functions.lua`<br />
**About:** Contains custom functions which are used throughout many lua scripts. Extracted for easy reusability.

### Custom Lists

**File:** `custom_lists.lua`<br />
**About:** Contains custom lists like areas and spell maps, extending what is already included in the default `Mote-Include.lua` suite.
