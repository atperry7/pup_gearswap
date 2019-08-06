# Puppet Gearswap for Windower

- [Puppet Gearswap for Windower](#puppet-gearswap-for-windower)
- [Requirements](#requirements)
- [Features](#features)
  - [Window Position](#window-position)
  - [Offense Mode](#offense-mode)
  - [Hybrid Mode](#hybrid-mode)
  - [Defense Mode](#defense-mode)
  - [Kiting Mode](#kiting-mode)
  - [Idle Mode](#idle-mode)
  - [Lock Weapon](#lock-weapon)
  - [Auto Maneuvers Toggle](#auto-maneuvers-toggle)
  - [Emergency Lock Pet DT Set](#emergency-lock-pet-dt-set)
  - [Predict](#predict)
  - [Pet Mode and Pet Styles](#pet-mode-and-pet-styles)
      - [Current Styles](#current-styles)
  - [SET FTP](#set-ftp)
  - [Hide Window](#hide-window)
  - [Notes On Pet Equipping Weaponskill Gear](#notes-on-pet-equipping-weaponskill-gear)
  - [Notes on Equipping Enmity Gear](#notes-on-equipping-enmity-gear)
  - [TODO](#todo)

This has become much more stable. Gearsets are in a place where they will not likely change. 

Most of the testing now involves ensuring the most flexible gear swapping in at the correct moment for various situations a Puppetmaster may find themselves in.

Please keep in mind that this **currently** a work in progress and any feed back you can provide will be helpful in improving this gearswap for puppets everywhere.

# Requirements
Mote-Libs is used for this gearswap. By default Windower/Gearswap provides this within its lib folder.

[Jump To Table of Contents](#puppet-gearswap-for-windower)

# Features

## Window Position
To adjust the window position you change the values in job_setup

    Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    
    Default:
    setupTextWindow(0, 0)  
    
    Example:
    setupTextWindow(1400, 600)

The window is now draggable, but it does not currently save the settings of the window.

## Offense Mode
These are for when you are fighting with or without Pet
When you are IDLE and Pet is ENGAGED that is handled by the Idle Mode

Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
- `F9`
- `//gs c cycle OffenseMode`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Hybrid Mode
Used when you are Engaged with Pet
Used when you are Idle and Pet is Engaged

Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
- `Ctrl+F9`
- `//gs c cycle HybridMode`


[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Defense Mode
Cycle type of Physical Defense Mode in use.
- `Ctrl+F10`
- `//gs c cycle PhysicalDefenseMode`

Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
- `F10`
- `//gs c cycle PhysicalDefenseMode`

Turns off any emergency defense mode.
- `Alt+F12`
- `//gs c cycle DefenseMode`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Kiting Mode
- `Alt+F10` 
- `//gs c toggle Kiting`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Idle Mode
Defaults to PetDT for when set to Idle
        
Will set IdleMode to Idle when Pet becomes Engaged and you are Idle

So, if you wish to go into a fight in MasterDT when first approaching to get Pet Engaged it will auto switch

- `F12` - Update currently equipped gear, and report current status.
- `Ctrl-F12` - Cycle Idle Mode.
- `//gs c update`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Lock Weapon
This will lock your current weapon in place.
- `Ctrl+tilda`
- `//gs c toggle LockWeapon`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Auto Maneuvers Toggle
Currently, the way this works is it will simply recast the maneuver that wears off. This way you can cast any maneuvers you want and it will simply attempt to maintain what you have active.
- `ALT + E`
- `//gs c toggle AutoMan`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Emergency Lock Pet DT Set
This allows the user to lock the DT set for the pet in place and block all other gearswapping.
- `ALT + D`
- `//gs c toggle LockPetDT`

[Jump To Table of Contents](#puppet-gearswap-for-windower)
  
## Predict
This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
- `Alt+F6` 
- `//gs c predict`

[Jump To Table of Contents](#puppet-gearswap-for-windower)
 
## Pet Mode and Pet Styles
This will change the mode of the pet and the style of the pet.

Current Modes for Pet are:
- Tank
- DD
- Mage

[Jump To Table of Contents](#puppet-gearswap-for-windower)

#### Current Styles
These are the current styles that each Pet Mode contains:

| Modes | Styles |||||
|-------|--------|-------|---------|-------|-------|
| Tank  | Normal | PDT   | MDT     | Range | DD    |
| DD    | Normal | Bone  | Spam    | OD    | ODACC |
| Mage  | Normal | Heal  | Support | MB    | DD    |

Cycles forward on Pet Modes
- `ALT+F7` 
- `//gs c cycle PetModeCycle`

Cycles back on Pet Modes 
- `CTRL+F7`
- `//gs c cycleback PetModecycle`

Cycles forward on Pet Styles
- `ALT+F8` 
- `//gs c cycle PetStyleCycle`

Cycles backward on Pet Styles
- `CTRL+F8` 
- `//gs c cycleback PetStyleCycle`

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## SET FTP
If player is idle and puppet is engaged while in DD Mode or a DD Style the puppet will now switch between a NO FTP and FTP set based on your choosing.

Now have the ability to switch to FTP with the below command:
- `//gs c setftp`

## HUB Window
You can hide the entire HUB Window by using the below command
- `//gs c hub all`

You can hide the State from the Window by using the below command:
- `//gs c hub state` 

You can hide the Mode from the Window by using the below command
- `//gs c hub mode`

You can hide the Options from the Window by using the below command
- `//gs c hub options`

You can toggle default keybinds set up for cycles/modes on menu by using the below command
- `//gs c hub keybinds`

You can activate the lite mode using:
- `//gs c hub lite`

## Notes On Pet Equipping Weaponskill Gear
This is currently how we determine when to equip a pets Weaponskill Gear prior to it using:

When the player has less than 1000 TP we will skip equipping the Pets Weaponskill Gear unless the pet is in PetStyle SPAM or DD, otherwise if player has TP we equip the Pets Weaponskill after the player.

The gearswap will further check the PetMode for:
- If PetMode is Tank and the Style is NOT set to DD or SPAM.
      - The gearswap will not equip Pet Weaponskill Gear
- If PetMode is Mage
      - The gearswap will not equip Pet Weaponskill Gear

If we pass the above checks then the gearswap will equip Pet Weaponskill Gear prior to the pet using its weaponskill.

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## Notes on Equipping Enmity Gear
This is how we determine to equip pet enmity gear:

If a Fire or Light Maneuver is active and the pet has any of the following attachments:
- Strobe
- Strobe II
- Flashbulb

We will equip enmity gear when the recast time is less than 2 seconds. Once the pet uses its ability
then the player will revert back to the previous gear.

One item to be aware of is that this currenly reads the chat log for when the pet performs the skill. If you are out of range of seeing this message then you have chance to simply staying in Enmity Gear. If you need to be futher way, then you want to consider locking in Pet DT Gear.

[Jump To Table of Contents](#puppet-gearswap-for-windower)

## TODO
- [ ] Add the ability to change Attachments with AutoControl Windower Addon

[Jump To Table of Contents](#puppet-gearswap-for-windower)
