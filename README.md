# Recent Changes
The entire structure is being reworked. I have started to pull out various functions into their own section within the PUP-LIB folder to help better maintain these various functions.

To Install: Move the older version out of the Gearswap Data Folder. Then move the new PUP.lua and the PUP-LIB folder (with all of its contents) in the Gearswap Data Folder.

## Gearswap GUI
Under Pet Skills the two have been renamed:
- `Maneuver Queue` is now `Maneuvers Maintained`
- `Current Queue` is now `Maneuvers To Recast`

### Upcoming
- Work on the Lite Version - Better support for screen sizes
- Reworking the Mode section to reflect the exact mode you are in at the time (should allow for better visibility into the exact set you should have on) -- This may or may not work, still figuring out

## Pet Auto Equip Weaponskill Gear
This has been completely reworked. This now properly locks from changing gear once threshold is hit and allows customizing.

This will only activate when the:
    - PetMode is DD
    - PetStyle is Spam, DD or Bone (regardless of PetMode)
    - Player is not fighting or Offense Mode is Trusts

Two new defaults have been added and are changeable within the PUP.lua under job_setup() (don't have to go into the PUP-LIB at all for this):
- `PET_MIN_TP_TO_WEAPONSKILL`
    - This is to set the mininmum amount of TP you want your pet to have before equiping TP gear (pet is fighting only)

- `PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER`
    - This is the seconds of how long to keep the pet weaponskill gear equipped before reverting to previous set

Two new commands have been introduced (this allows you to change the defauls temporarily)
- `//gs c wstimer 5`
    - This allows you the pass in the seconds that you will stay in the pet weaponskill gear while waiting on pet
- `//gs c tpmin 850`
    - This is when we will start the Pet Weaponskill Timer and first change into Pet Weapon Skill Gear

## Auto Maneuver
A few extra checks have been added to try and prevent any looping of maneuvers.

### Upcoming
I am adding in a debuff tracker so we don't attempt to recast while under an effect that would prevent you from casting to start with.

## Other
Pet Predict will no longer happen when you press F12 - your gear will still reset
- This can still be used with `//gs c predict`

### Upcoming
- Add support for Aftermath Sets
- Investigate logic around Enmity Sets - I want to make sure we don't stay in this to long, it may be better to miss a swap than stay in this for to long, may need to look into tracking debuffs on pet
- Investigate leveraging Packets over watching Chat for certain items