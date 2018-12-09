# Puppet Gearswap for Windower
Please keep in mind that this **currently** a work in progress and any feed back you can provide will be helpful in improving this gearswap for puppets everywhere

- [Puppet Gearswap for Windower](#puppet-gearswap-for-windower)
- [Requirements](#requirements)
- [Features](#features)
  - [Auto Maneuvers Toggle:](#auto-maneuvers-toggle)
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
- ALT + E
  
## Predict:
This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
- //gs c predict
 
## Pet Mode:
This will allow you to cycle between different modes for your pet.

This will change the mode of the pet and the style of the pet.
Current Modes: TANK, DD, Mage

#### Current Styles:
Tank: Normal, PDT, MDT, RANGE
DD: Normal, Bone, Spam, OD, ODACC
Mage: Normal, Heal, Support, MB, DD

- ALT+F7 Cycles forward on Pet Modes
- CTRL+F7 Cycles back on Pet Modes 
- ALT+F8 Cycles Forward on Pet Styles
- CTRL+F8 Cycles backward on Pet Styles

# TODO
- [x] Update Readme with better format
- [ ] Test cycle commands for various Mode and Styles
- [ ] Test Auto Maneuvers with new toggle feature
- [ ] Create better gear sets with better variables
- [ ] Improve the functionality of the Predict Function
- [ ] Add a better list of planned functionality