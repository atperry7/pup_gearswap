# Puppet Gearswap for Windower
Please keep in mind that this **currently** a work in progress and any feed back you can provide will be helpful in improving this gearswap for puppets everywhere

- [Puppet Gearswap for Windower](#puppet-gearswap-for-windower)
- [Requirements](#requirements)
- [Features](#features)
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
- [x] Update Readme with better format
- [X] Test cycle commands for various Mode and Styles
- [X] Test Auto Maneuvers with new toggle feature
- [X] Create better gear sets with better variable names
- [X] Improve the functionality of the Predict Function
- [X] Update gearsets with better naming convention
- [ ] Set up gearsets for different Modes/Styles to offer more options for a puppet
- [ ] Add a better list of planned functionality