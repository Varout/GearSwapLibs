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
- Tracks Seekers of Adoulin main story progress
- Tracks Seekers of Adoulin and Mog Gardess quest progress
- Tracks Coallition Assignment progress
- Tracks Mog Garden Progress
- Tracks monster rearing progress
- Provides an overview of everything on main sheet
- Includes a few examples of inputs to see how it works, which are easily removed

### Weather Gear

Used to track progress towards weather related gear with an end goal being the item that combines all 8 elements:

- Hachirin-no-Obi
- Fotia Gorget
- Fotia Belt

Most luas have the ability to lock in certain rings to make sure they aren't unequipped when casting spells or buffs wear off.
e.g. You've just finished an event, your buffs are on cooldown and you've got a Warp Ring on, as a buff wears off there is a check to see if you have a Warp Ring equipped and if so, it is locked in place until manually unequipped.

## Varrout (Varout from Titan)

The character I've been playing on and off since 2004. Mains are White Mage and Dragoon.

If you don't set `pocketMode` in your lua to `false`, then the UI will not be loaded by default.  You can still load it by using the mode shortcut below.

- `Windows Key + M`: Brings up the map because I'm lazy

### White Mage (WHM)

#### Custom GearSwap Commands

Modes
- ` Windows Key + Z `: Cycles through location or off of UI
- ` Windows Key + X `: Cycles through idle modes
  - Refresh: Prioritise idle refresh
  - Hybrid: About -30% DT on top of refresh set
  - MagicEvasion: Full DT and magic evasion set
- ` Windows Key + C `: Toggles Cursna Mode
  - Potency: Uses Gambanteinn
  - AoE: Uses Yagrush
- `` Windows Key + ` ``: Toggles Salty Auto-Cancel Refresh When Not Weakend-Mode

Shortcuts
- ` Ctrl + C `: Divine Caress
- ` Windows Key + 1 `: Takes into account recasts and casts the highest available Raise spell on selected target
- ` Windows Key + 2 `: Takes into account recasts and casts the highest available Reraise spell

#### Dependencies

- `Mote-Include.lua`
- `Lib_WHM.lua`
- `common_functions.lua`
- `common_lists.lua`

#### UI Example

![White Mage UI Example](images/ui_whm.png)

### Dragoon (DRG)

There's a great DRG guide here on BG-Wiki: ![Dragoon Guide By Kaius](https://www.bg-wiki.com/ffxi/Dragoon_Guide_By_Kaius)

#### Custom GearSwap Commands

Modes
- `Ctrl + F9 `: Idle Mode
  - Normal: Prioritises idle TP
  - DT: Prioritises reducing idle damage taken
- `Ctrl + F10`: Engaged Mode
  - Normal: Standard engaged mode
  - GlassCannon: Glasscannon mode
  - DT: Full DT mode
  - Fencer: For using /war and Naegling
- `Ctrl + F11`: Weapon Skill Mode
  - Normal: For normal condidions
  - HighBuff: If you have a high buff situation
- `Ctrl + F12`: Movement Mode
  - Normal
  - Fast: Equips Carmine Cuisses +1 on top of the current equip

#### Dependencies

- `Mote-Include.lua`
- `Lib_DRG.lua`
- `common_functions.lua`
- `common_lists.lua`

#### UI Example

![Dragoon UI Example](images/ui_drg.png)

### Scholar (SCH)

#### Custom GearSwap Commands

Modes
- ` Windows Key + X `: Cycles through idle modes
  - Refresh: Prioritise idle refresh
  - Hybrid: About -30% DT on top of refresh set
  - HybridMagEva: Base magic evasion set, but allows for full sublimation set when charging
  - MagicEvasion: Magic Evasion and DT set, does not allow any Sublimation charging gear
- ` Windows Key + C `: Cycles through Casting Moades
  - Normal
  - MagicBurst

Shortcuts
- `Ctrl + C`: Convert + Rapture (if in Light Arts) + Self Cure IV
- `Windows Key + 1`: Takes into account recasts and casts the highest available Raise spell on selected target
- `Windows Key + 2`: Takes into account recasts and casts the highest available Reraise spell

- `Windows Key + 5:` Self-Skillchain: Fragmentation
- `Windows Key + 6:` Self-Skillchain: Fusion
- `Windows Key + 7:` Self-Skillchain: Distortion
- `Windows Key + 8:` Self-Skillchain: Gravitation

- `Ctrl + F5:` Self-Skillchain: Fragmentation
- `Ctrl + F6:` Self-Skillchain: Fusion
- `Ctrl + F7:` Self-Skillchain: Distortion
- `Ctrl + F8:` Self-Skillchain: Gravitation

#### Dependencies

- `Mote-Include.lua`
- `Lib_SCH.lua`
- `common_functions.lua`
- `common_lists.lua`

#### UI Example

![SCH UI Example](images/ui_sch.png)


### Red Mage (RDM)

Rework in progress

### Dark Knight (DRK)

Rework in progress

### Summoner (SMN)

#### Custom Commands

These were built in when I got the lua and are not my work. I can't remember where I got them as it was long ago, so I cannot give credit where credit is due. :(

**Siphon**<br />
Command: `gs c siphon`<br />
Automatically run the process to: dismiss the current avatar; cast appropriate weather; summon the appropriate spirit; Elemental Siphon; release the spirit; and re-summon the avatar.

**Pact**<br />
Command: `gs c pact <PactType>`<br />
Attempts to use the indicated pact type for the current avatar.<br />
PactType can be one of:
- cure
- curaga
- buffOffense
- buffDefense
- buffSpecial
- debuff1
- debuff2
- sleep
- nuke2
- nuke4
- bp70
- bp75 (merits and lvl 75-80 pacts)
- astralflow

#### Dependencies

- `Mote-Include.lua`
- `common_functions.lua`
- `common_lists.lua`

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

### Thief (THF)

Rework in progress

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
