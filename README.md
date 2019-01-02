# Puppet Gearswap for Windower
Please keep in mind that this **currently** a work in progress and any feed back you can provide will be helpful in improving this gearswap for puppets everywhere

- [Puppet Gearswap for Windower](#puppet-gearswap-for-windower)
- [Requirements](#requirements)
- [Features](#features)
  - [Offense Mode](#offense-mode)
  - [Hybrid Mode](#hybrid-mode)
  - [Defense Mode](#defense-mode)
  - [Kiting Mode](#kiting-mode)
  - [Idle Mode](#idle-mode)
  - [Auto Maneuvers Toggle:](#auto-maneuvers-toggle)
  - [Lock Pet DT Set](#lock-pet-dt-set)
  - [Predict:](#predict)
  - [Pet Mode:](#pet-mode)
      - [Current Styles:](#current-styles)
- [TODO](#todo)


# Requirements
Due to the flexibilty that Mote-Libs offers, you will need this in gearswap folder to be able to utilize this gearswap.

You can find and download from the below link:

https://github.com/Kinematics/Mote-libs

# Features

## Offense Mode
`F9` - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).

These are for when you are fighting with or without Pet
When you are IDLE and Pet is ENGAGED that is handled by the Idle Mode

## Hybrid Mode
`Ctrl+F9` - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).

Used when you are Engaged with Pet
Used when you are Idle and Pet is Engaged

## Defense Mode
`Ctrl+F10` - Cycle type of Physical Defense Mode in use.
`F10` - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
`Alt+F12` - Turns off any emergency defense mode.

## Kiting Mode
`Alt+F10` 

## Idle Mode
`F12` - Update currently equipped gear, and report current status.
`Ctrl-F12` - Cycle Idle Mode.

Defaults to PetDT for when set to Idle
        
Will set IdleMode to Idle when Pet becomes Engaged and you are Idle

So, if you wish to go into a fight in MasterDT when first approaching to get Pet Engaged it will auto switch

## Lock Weapon
`Ctrl+` ` This will lock your current weapon in place.

## Auto Maneuvers Toggle:
Currently, the way this works is it will simply recast the maneuver that wears off. This way you can cast any maneuvers you want and it will simply attempt to maintain what you have active.
- `ALT + E`

## Lock Pet DT Set
This allows the user to lock the DT set for the pet in place and block all other gearswapping.
- `ALT + D`
  
## Predict:
This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
- `Alt+F6 or //gs c predict`
 
## Pet Mode:
This will change the mode of the pet and the style of the pet.


#### Current Styles:
`Plan is to get this working with AutoControl Addon for helping change attachments automatically`

| Modes | Styles |||||
|-------|--------|-------|---------|-------|-------|
| Tank  | Normal | PDT   | MDT     | Range | DD    |
| DD    | Normal | Bone  | Spam    | OD    | ODACC |
| MAGE  | Normal | Heal  | Support | MB    | DD    |

- `ALT+F7` Cycles forward on Pet Modes
- `CTRL+F7` Cycles back on Pet Modes 
- `ALT+F8` Cycles forward on Pet Styles
- `CTRL+F8` Cycles backward on Pet Styles

# TODO
- [ ] Testing as needed for changes to gearsets
- [ ] Add the ability to change Attachments with AutoControl Windower Addon