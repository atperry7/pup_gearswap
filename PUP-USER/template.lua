function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).

        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).

        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode

        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.

        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    -- Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    -- The actual Pet Mode and Pet Style cycles
    -- Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    -- Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    -- Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

    --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[
        This will toggle the CP Mode
        //gs c toggle CP
    ]]
    state.CP = M(false, "CP")
    CP_CAPE = "Aptitude Mantle +1"

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    -- Example customGearLock = T{"head", "waist"}
    customGearLock = T {}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP")
    send_command("bind = gs c clear")

    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 0
    pos_y = 500
    setupTextWindow(pos_x, pos_y)
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")
    send_command("unbind end")
    send_command("unbind =")
end

function pet_weaponskill_setup()
    -- This is to set the mininmum amount of TP you want your pet to have before equiping TP gear (pet is fighting only)
    PET_MIN_TP_TO_WEAPONSKILL = 850
    -- This is the seconds of how long to keep the pet weaponskill gear equipped before reverting to previous set
    PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER = 5
end

function init_gear_sets()
    -- Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    -- | |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    -- | | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    -- | |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"

    -- Adjust to your reforge level
    -- Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +2" -- Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +2" -- Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +2" -- Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +2" -- Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" -- Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"

    Visucius = {}
    Visucius.PetDT = {
        name = "Visucius's Mantle",
        augments = {"Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20", "Accuracy+20 Attack+20",
                    "Pet: Accuracy+4 Pet: Rng. Acc.+4", 'Pet: "Regen"+10', "Pet: Damage taken -5%"}
    }
    Visucius.PetMagic = {
        name = "Visucius's Mantle",
        augments = {"Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20", "Accuracy+20 Attack+20",
                    "Pet: Accuracy+4 Pet: Rng. Acc.+4", 'Pet: "Regen"+10', "Pet: Damage taken -5%"}
    }

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    -- This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {}

    -------------------------------------Fastcast
    sets.precast.FC = {
        -- Add your set here
    }

    -------------------------------------Midcast
    sets.midcast = {} -- Can be left empty

    sets.midcast.FastRecast = {
        -- Add your set here
    }

    -------------------------------------Kiting
    sets.Kiting = {
        feet = "Hermes' Sandals"
    }

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads",
        body = "Passion Jacket"
    })

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {
        feet = Empy_Karagoz.Feet_Tatical
    }

    sets.precast.JA["Ventriloquy"] = {
        legs = Relic_Pitre.Legs_PMagic
    }

    sets.precast.JA["Role Reversal"] = {
        feet = Relic_Pitre.Feet_PMagic
    }

    sets.precast.JA["Overdrive"] = {
        body = Relic_Pitre.Body_PTP
    }

    sets.precast.JA["Repair"] = {
        ammo = "Automat. Oil +3",
        feet = Artifact_Foire.Feet_Repair_PMagic
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar +1",
        body = "Karagoz Farsetto",
        hands = Artifact_Foire.Hands_Mane_Overload,
        back = "Visucius's Mantle",
        ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {
        back = "Visucius's Mantle"
    }

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        -- Add your set here
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        -- Add your set here
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
        -- Add your set here
    })

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {})

    -------------------------------------Idle
    --[[
        Player is Idle.
        Pet is NOT active.
        Idle Mode (Ctrl-F12) = MasterDT.
    ]]
    sets.idle.MasterDT = {
        -- Add your set here
    }

    -------------------------------------Engaged
    --[[
        Player is Engaged.
        Offense Mode (F9) = Master (Pet is not active or not prioritized for gear).
        Hybrid Mode (Ctrl-F9) = Normal.
    ]]
    sets.engaged.Master = {
        -- Add your set here
    }

    -------------------------------------Acc
    --[[
        Player is Engaged.
        Offense Mode (F9) = Master.
        Hybrid Mode (Ctrl-F9) = Acc.
    ]]
    sets.engaged.Master.Acc = {
        -- Add your set here
    }

    -------------------------------------TP
    --[[
        Player is Engaged.
        Offense Mode (F9) = Master.
        Hybrid Mode (Ctrl-F9) = TP.
    ]]
    sets.engaged.Master.TP = {
        -- Add your set here
    }

    -------------------------------------DT
    --[[
        Player is Engaged.
        Offense Mode (F9) = Master.
        Hybrid Mode (Ctrl-F9) = DT.
    ]]
    sets.engaged.Master.DT = {
        -- Add your set here
    }

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Player is Engaged.
        Offense Mode (F9) = MasterPet (Player and Pet are fighting together).
        Hybrid Mode (Ctrl-F9) = Normal.
    ]]
    sets.engaged.MasterPet = {
        -- Add your set here
    }

    -------------------------------------Acc
    --[[
        Player is Engaged.
        Offense Mode (F9) = MasterPet.
        Hybrid Mode (Ctrl-F9) = Acc.
    ]]
    sets.engaged.MasterPet.Acc = {
        -- Add your set here
    }

    -------------------------------------TP
    --[[
        Player is Engaged.
        Offense Mode (F9) = MasterPet.
        Hybrid Mode (Ctrl-F9) = TP.
    ]]
    sets.engaged.MasterPet.TP = {
        -- Add your set here
    }

    -------------------------------------DT
    --[[
        Player is Engaged.
        Offense Mode (F9) = MasterPet.
        Hybrid Mode (Ctrl-F9) = DT.
    ]]
    sets.engaged.MasterPet.DT = {
        -- Add your set here
    }

    -------------------------------------Regen
    --[[
        Player is Engaged.
        Offense Mode (F9) = MasterPet.
        Hybrid Mode (Ctrl-F9) = Regen.
    ]]
    sets.engaged.MasterPet.Regen = {
        -- Add your set here
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
        -- Add your set here
    }

    sets.midcast.Pet.Cure = {
        -- Add your set here
    }

    sets.midcast.Pet["Healing Magic"] = {
        -- Add your set here
    }

    sets.midcast.Pet["Elemental Magic"] = {
        -- Add your set here
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
        -- Add your set here
    }

    sets.midcast.Pet["Dark Magic"] = {
        -- Add your set here
    }

    sets.midcast.Pet["Divine Magic"] = {
        -- Add your set here
    }

    sets.midcast.Pet["Enhancing Magic"] = {
        -- Add your set here
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active
        and the base sets.idle will be ignored.
        Player is Idle (not fighting).
        Pet is Idle (not fighting).
        Idle Mode (Ctrl-F12) = Idle.
    ]]
    sets.idle.Pet = {
        head = "Heyoka Cap"
    }

    --[[
        Player is Idle (not fighting).
        Pet is Active and Idle (not fighting).
        Idle Mode (Ctrl-F12) = MasterDT.
    ]]
    sets.idle.Pet.MasterDT = {
        -- Add your set here
    }

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    -- Equipped automatically
    sets.pet.Enmity = {
        -- Add your set here
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
        -- Add your set here
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups]

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = Normal.
        This is the base set when player is idle and pet is fighting.
    ]]
    sets.idle.Pet.Engaged = {
        head = "Taeon Chapeau"
    }

    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = Acc.
    ]]
    sets.idle.Pet.Engaged.Acc = {
        -- Add your set here
    }

    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = TP.
    ]]
    sets.idle.Pet.Engaged.TP = {
        -- Add your set here
    }

    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = DT.
    ]]
    sets.idle.Pet.Engaged.DT = {
        -- Add your set here
    }

    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = Regen.
    ]]
    sets.idle.Pet.Engaged.Regen = {
        -- Add your set here
    }

    --[[
        Player is Idle (not fighting).
        Pet is Engaged.
        Idle Mode (Ctrl-F12) = Idle.
        Hybrid Mode (Ctrl-F9) = Ranged.
    ]]
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
        legs = Empy_Karagoz.Legs_Combat
    })

    -------------------------------------WS
    --[[
        Default pet weaponskill set when state.SetFTP is false.
        Used when pet performs a weaponskill that does not benefit from TP overflow.
    ]]
    sets.midcast.Pet.WSNoFTP = {
        head = "Pitre Taj +2"
        -- Add your set here
    }

    --[[
        Pet weaponskill set used when state.SetFTP is true.
        Used for pet weaponskills that can benefit from TP overflow (WSFTP).
    ]]
    sets.midcast.Pet.WSFTP = {
        head = Empy_Karagoz.Head_PTPBonus
        -- Add your set here
    }

    -- Base set without modifier, uses WSNoFTP by default
    sets.midcast.Pet.WS = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
        head = "Pitre Taj +2"
    })

    -- Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
    })

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
        head = Empy_Karagoz.Head_PTPBonus
    })

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
        -- Add your set here
    }

    -- Resting sets
    sets.resting = {
        -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "WAR" then
        set_macro_page(3, 1)
    elseif player.sub_job == "NIN" then
        set_macro_page(3, 1)
    elseif player.sub_job == "DNC" then
        set_macro_page(3, 1)
    else
        set_macro_page(3, 1)
    end
end
