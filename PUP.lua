----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.
    
    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master")

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

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
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
        //gs c hide hub
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hide mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hide state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hide options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hide keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[
        This will toggle the CP Mode
        //gs c toggle CP
    ]]
    state.CP = M(false, "CP")
    CP_CAPE = ""
    
    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    
    select_default_macro_book()
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
end

function job_setup()
    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    setupTextWindow(0, 0)
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +1" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +1" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +1" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +1" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"

    Visucius = {}
    Visucius.PetDT = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+4 Pet: Rng. Acc.+4",
            'Pet: "Regen"+10',
            "Pet: Damage taken -5%"
        }
    }
    Visucius.PetMagic = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+4 Pet: Rng. Acc.+4",
            'Pet: "Regen"+10',
            "Pet: Damage taken -5%"
        }
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
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
        -- Add your set here
    }

    -------------------------------------Fastcast
    sets.precast.FC = {
        -- Add your set here
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
        -- Add your set here
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads", body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty
    
    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tatical}
    
    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}
    
    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}
    
    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
        -- Add your set here
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        -- Add your set here
    }

    sets.precast.JA["Activate"] = { back = "Visucius's Mantle" }
    
    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
        -- Add your set here
    }

    --Waltz set (chr and vit)
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

	--Special Set for TP over 2,750
	sets.TP_Bonus = {ear2="Cessance Earring"}
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine( sets.precast.WS, {
            -- Add armor here specific to the weapon skill not included in the sets.precast.WS
        }
    )
    
    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {
            -- Add armor here specific to the weapon skill not included in the sets.precast.WS
        }
    )

    sets.precast.WS["Victory Smite"] = set_combine( sets.precast.WS, {
            -- Add armor here specific to the weapon skill not included in the sets.precast.WS
        }
    )

    sets.precast.WS["Shijin Spiral"] = set_combine( sets.precast.WS, {
            -- Add armor here specific to the weapon skill not included in the sets.precast.WS
        }
    )

    sets.precast.WS["Howling Fist"] = set_combine( sets.precast.WS, {
            -- Add armor here specific to the weapon skill not included in the sets.precast.WS
        }
    )

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        -- Add your set here
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        -- Add your set here
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
        -- Add your set here
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
        -- Add your set here
    }

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
       -- Add your set here
    }

	
	-----------------------
	-------    -    -------
	-----    -- --	  -----
	---    ---   ---	---
	-----------------------
	--Special SET for Aftermath IN DEVELOPMENT
	sets.engaged.Master.AM3 = set_combine(sets.engaged.Master, {
		--Add your Gear here 
	})
	sets.engaged.Master.AM2 = set_combine(sets.engaged.Master, {
	    --Add your Gear here
	})
	sets.engaged.Master.AM1 = set_combine(sets.engaged.Master, {
	    --Add your Gear here
	})
	
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
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        -- Add your set here
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = {
        -- Add your set here
    }

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = {
        -- Add your set here
    }

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = {
        -- Add your set here
    }
    
    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
        -- Add your set here
    }

    -----------------------
	-------    -    -------
	-----    -- --	  -----
	---    ---   ---	---
	-----------------------
	--Special SET for Aftermath IN DEVELOPMENT
	sets.engaged.MasterPet.AM3 = set_combine(sets.engaged.Master, {
		-- Add your set here
	})
    
    sets.engaged.MasterPet.AM2 = set_combine(sets.engaged.Master, {
	    -- Add your set here
	})
    
    sets.engaged.MasterPet.AM1 = set_combine(sets.engaged.Master, {
	    -- Add your set here
	})

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
        --Add your set here
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
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {

    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = {

    }

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
        --Add your set here
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
        --Add your set here
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
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
        --Add your set here
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
        --Add your set here
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = {
        --Add your set here
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = {
        --Add your set here
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
        --Add your set here
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
        legs = Empy_Karagoz.Legs_Combat
    })

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        -- Add your set here
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
        -- Add your set here
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}
    
    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
    })
    
    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(sets.midcast.Pet.WSNoFTP, {
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
            head = Empy_Karagoz.Head_PTPBonus, waist = "Incarnation Sash"
        })
    
    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
    })
    
    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {
        -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
    })
    
    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(sets.midcast.Pet.WSFTP, {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
            head = Empy_Karagoz.Head_PTPBonus, back = "Dispersal Mantle"
        })

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

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {
        --Gear added here will overwrite the slots within sets.pet.EmergencyDT
        --Any slot not added will use the default slot from sets.pet.EmergencyDT
    })
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

------------------------------------------------------------------------------------------------------------------------
--------------------------------- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING ---------------------------------
------------------------------------------------------------------------------------------------------------------------

-------------------------------
--------Global Variables-------
-------------------------------

Current_Maneuver = 0
OverCount = 0
NextWS = ""

Master_State = "Idle"
Pet_State = "Idle"
Hybrid_State = "Idle"
Flashbulb_Timer = 45
Strobe_Timer = 30
Strobe_Recast = 0
Flashbulb_Recast = 0
Flashbulb_Time = 0
Strobe_Time = 0

debug_mode = true

time_start = os.time()

--Constants in case we decide to change names down the road, will be much easier
const_dd = "DD"
const_tank = "TANK"
const_mage = "MAGE"
const_PetModeCycle = "PetModeCycle"
const_PetStyleCycle = "PetStyleCycle"
const_stateIdle = "Idle"
const_stateHybrid = "Pet+Master"
const_stateEngaged = "Engaged"
const_stateOverdrive = "Overdrive"
const_petOnly = "Pet Only"
const_masterOnly = "Master Only"

--- SKILLCHAIN TABLE
SC = {}
SC["Valoredge Frame"] = {}
SC["Sharpshot Frame"] = {}
SC["Harlequin Frame"] = {}
SC["Stormwaker Frame"] = {}

SC["Valoredge Frame"]["Stringing Pummel"] = "String Shredder"
SC["Valoredge Frame"]["Victory Smite"] = "String Shredder"
SC["Valoredge Frame"]["Shijin Spiral"] = "Bone Crusher"
SC["Valoredge Frame"]["Howling Fist"] = "String Shredder"

SC["Sharpshot Frame"]["Stringing Pummel"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Victory Smite"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Shijin Spiral"] = "Armor Piercer"
SC["Sharpshot Frame"]["Howling Fist"] = "Arcuballista"
SC["Sharpshot Frame"]["Dragon Kick"] = "Armor Shatterer"
SC["Sharpshot Frame"]["One Inch Punch"] = "Daze"
SC["Sharpshot Frame"]["Spinning Attack"] = "Armor Shatterer"
SC["Sharpshot Frame"]["Base"] = "Arcuballista"

SC["Harlequin Frame"]["Stringing Pummel"] = "Slapstick"
SC["Harlequin Frame"]["Victory Smite"] = "Magic Mortar"
SC["Harlequin Frame"]["Shijin Spiral"] = "Slapstick"
SC["Harlequin Frame"]["Howling Fist"] = "Knockout"

SC["Stormwaker Frame"]["Stringing Pummel"] = "Slapstick"
SC["Stormwaker Frame"]["Victory Smite"] = "Magic Mortar"
SC["Stormwaker Frame"]["Shijin Spiral"] = "Slapstick"
SC["Stormwaker Frame"]["Howling Fist"] = "Knockout"

------------------------------------
------------Text Window-------------
------------------------------------

--Default To Set Up the Text Window
texts = require 'texts'
function setupTextWindow(pos_x, pos_y)
    local tb_name = "pup_gs_helper"
    bg_visible = true
    

    local default_settings = {}
    default_settings.pos = {}
    default_settings.pos.x = pos_x
    default_settings.pos.y = pos_y
    default_settings.bg = {}

    default_settings.bg.alpha = 200
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = bg_visible
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = true
    default_settings.flags.italic = false
    default_settings.padding = 5
    default_settings.text = {}
    default_settings.text.size = 12
    default_settings.text.font = 'Arial'
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 0
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

    pup_text_box = texts.new('${current_string}', default_settings, default_settings)
    pup_text_box.current_string = ''
    pup_text_box:show()
    
end

--Hanldles refreshing the current text window
function refreshWindow()
    textinbox = " "
    textColorNewLine = "\\cr \n"
    textColorEnd = " \\cr"
    textColor = "\\cs(125, 125, 0)"

    --Testing with this variable can ignore for now, works as intended

    if state.textHideHUB.value == true then
        textinbox = " "

        if pup_text_box.current_string ~= textinbox then
            pup_text_box.current_string = textinbox
        end

        return
    end

    if pet.isvalid then
        drawPetInfo()
        drawPetSkills()
    end

    if not state.textHideState.value then
        textinbox = textinbox .. drawTitle("    State    ")
        textinbox =
            textinbox ..
            textColor ..
                "Pet Mode " ..
                    ternary(state.Keybinds.value, "(ALT+F7)", "") ..
                        " : " .. state.PetModeCycle.value .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Pet Style " ..
                    ternary(state.Keybinds.value, "(ALT+F8)", "") ..
                        " : " .. state.PetStyleCycle.value .. textColorNewLine
        -- textinbox = textinbox .. textColor .. "Master : " .. Master_State .. textColorNewLine
        -- textinbox = textinbox .. textColor .. "Pet : " .. Pet_State .. textColorNewLine
        textinbox = textinbox .. textColor .. "Current State: " .. Hybrid_State .. textColorNewLine
    end

    if not state.textHideMode.value then
        textinbox = textinbox .. drawTitle("     Mode     ")
        textinbox =
            textinbox ..
            textColor ..
                "Idle Mode " ..
                    ternary(state.Keybinds.value, "(CTRL+F12)", "") ..
                        " : " .. tostring(state.IdleMode.current) .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Offense Mode " ..
                    ternary(state.Keybinds.value, "(F9)", "") ..
                        " : " .. tostring(state.OffenseMode.current) .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Physical Mode " ..
                    ternary(state.Keybinds.value, "(CTRL-F10)", "") ..
                        " : " .. tostring(state.PhysicalDefenseMode.current) .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Hybrid Mode " ..
                    ternary(state.Keybinds.value, "(CTRL-F9)", "") ..
                        " : " .. tostring(state.HybridMode.current) .. textColorNewLine
    end

    if not state.textHideOptions.value then
        textinbox = textinbox .. drawTitle("  Options  ")
        textinbox =
            textinbox ..
            textColor ..
                "Auto Maneuver " ..
                    ternary(state.Keybinds.value, "(ALT+E)", "") ..
                        " : " .. ternary(state.AutoMan.value, "ON", "OFF") .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Lock Pet DT Set " ..
                    ternary(state.Keybinds.value, "(ALT+D)", "") ..
                        " : " .. ternary(state.LockPetDT.value, "ON", "OFF") .. textColorNewLine
        textinbox =
            textinbox ..
            textColor ..
                "Lock Weapon " ..
                    ternary(state.Keybinds.value, "(ALT+~)", "") ..
                        " : " .. ternary(state.LockWeapon.value, "ON", "OFF") .. textColorNewLine
        textinbox =
            textinbox ..
            textColor .. "Weaponskill FTP: " .. ternary(state.SetFTP.value, "ON", "OFF") .. textColorNewLine
        textinbox =
            textinbox ..
            textColor .. "Custom Gear Lock: " .. ternary(state.CustomGearLock.value, "ON", "OFF") .. textColorNewLine
        textinbox =
            textinbox ..
            textColor .. "Auto Deploy: " .. ternary(state.AutoDeploy.value, "ON", "OFF") .. textColorNewLine
    end

    --Debug Variables that are used for testing
    if debug_mode then
        textinbox = textinbox .. drawTitle("DEBUG")
    end

    if pup_text_box.current_string ~= textinbox then
        pup_text_box.current_string = textinbox
    end
end

--Handles drawing the Pet Info for the Text Box
function drawPetInfo()
    textinbox = textinbox .. drawTitle("   Pet Info   ")
    textinbox = textinbox .. "- \\cs(0, 0, 125)HP : " .. pet.hp .. "/" .. pet.max_hp .. textColorNewLine
    textinbox = textinbox .. "- \\cs(0, 125, 0)MP : " .. pet.mp .. "/" .. pet.max_mp .. textColorNewLine
    textinbox = textinbox .. "- \\cs(255, 0, 0)TP : " .. tostring(pet.tp) .. textColorNewLine
    textinbox =
        textinbox ..
        "- \\cs(255, 0, 0)WS Gear Lock : " ..
            ternary(startedPetWeaponSkillTimer and petWeaponSkillRecast <= 0, "On", "Off") ..
                " ( " .. petWeaponSkillRecast .. " )" .. textColorNewLine
end

--This handles drawing the Pet Skills for the text box
function drawPetSkills()
    --- Recast for enmity gears

    textinbox = textinbox .. drawTitle("  Pet Skills  ")
    -- Strobe recast
    if Strobe_Recast == 0 and (pet.attachments.strobe or pet.attachments["strobe II"]) then
        if buffactive["Fire Maneuver"] then
            textinbox = textinbox .. "\\cs(125, 125, 125)-\\cr \\cs(125,0,0)Strobe\\cr \n"
        else
            textinbox = textinbox .. "\\cs(125, 125, 125)- Strobe\\cr \n"
        end
    elseif pet.attachments.strobe or pet.attachments["strobe II"] then
        textinbox = textinbox .. "\\cs(125, 125, 125)- Strobe (" .. Strobe_Recast .. ")\\cr \n"
    end

    -- Flashbulb recast
    if Flashbulb_Recast == 0 and pet.attachments.flashbulb then
        if buffactive["Light Maneuver"] then
            textinbox = textinbox .. "\\cs(125, 125, 125)-\\cr \\cs(255,255,255)Flashbulb\\cr \n"
        else
            textinbox = textinbox .. "\\cs(125, 125, 125)- Flashbulb\\cr \n"
        end
    elseif pet.attachments.flashbulb ~= nil then
        textinbox = textinbox .. "\\cs(125, 125, 125)- Flashbulb (" .. Flashbulb_Recast .. ")\\cr \n"
    end

    if not pet.attachments.strobe and not pet.attachments["strobe II"] and not pet.attachments.flashbulb then
        textinbox = textinbox .. "\\cs(125, 125, 125)-No Skills To Track\\cr \n"
    end
end

--Creates the Title for a section in the Text Screen
function drawTitle(title)
    return "\\cs(255, 115, 0)" .. pad(tostring(title), 6, "=") .. "\\cr \n"
end

function msg(str)
    send_command("@input /echo *-*-*-*-*-*-*-*-* " .. str .. " *-*-*-*-*-*-*-*-*")
end

------------------------------------
----------Utility Functions---------
------------------------------------

--Used to calculate the Hybrid State of you and your pet
function TotalSCalc()
    if state.PetModeCycle.current == const_dd then
        if buffactive["Overdrive"] then
            Hybrid_State = const_stateOverdrive
        elseif Master_State == const_stateIdle and Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        elseif Master_State == const_stateIdle and Pet_State == const_stateEngaged then
            Hybrid_State = const_petOnly
        elseif Master_State == const_stateEngaged and Pet_State == const_stateEngaged then
            Hybrid_State = const_stateHybrid
        elseif Master_State == const_stateEngaged and Pet_State == const_stateIdle then
            Hybrid_State = const_masterOnly
        end
    elseif state.PetModeCycle.current == const_tank then
        if Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        elseif state.PetStyleCycle.value ~= "DD" and state.PetStyleCycle.value ~= "SPAM" then
            Hybrid_State = const_tank
            handle_set({"IdleMode", "Idle"})
            handle_set({"HybridMode", "DT"})
        end
    elseif state.PetModeCycle.current == const_mage then
        if Master_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_masterOnly
            handle_set({"OffenseMode", "Master"})
        end
    end
end

--Attempts to determine the Puppet Mode and Style
function determinePuppetType()
    local head = pet.head
    local frame = pet.frame

    local ValHead = "Valoredge Head"
    local ValFrame = "Valoredge Frame"

    local HarHead = "Harlequin Head"
    local HarFrame = "Harlequin Frame"

    local SharpHead = "Sharpshot Head"
    local SharpFrame = "Sharpshot Frame"

    local StormHead = "Stormwaker Head"
    local StormFrame = "Stormwaker Frame"

    local SoulHead = "Soulsoother Head"
    local SpiritHead = "Spiritreaver Head"

    --This is based mostly off of the frames from String Theory
    --https://www.bg-wiki.com/bg/String_Theory#Automaton_Frame_Setups

    --Determine Head first, then further determine by body and attachments
    if head == HarHead then --Harlequin Predictions
        if frame == HarFrame and (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then --Magic Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "MAGIC"})
        elseif frame == HarFrame then -- Default
            handle_set({const_PetModeCycle, const_dd})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == ValHead then --Valoredge Predictions
        if frame == SharpFrame then
            if (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then -- DD Tank
                handle_set({const_PetModeCycle, const_tank})
                handle_set({const_PetStyleCycle, const_dd})
            else -- Default
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            end
        elseif frame == ValFrame then -- Default Standard Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SharpHead then -- Sharpshooter Prediction
        if frame == SharpFrame then -- SPAM DD
            if (pet.attachments.inhibitor == true or pet.attachments["inhibitor II"] == true) then
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            else
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "SPAM"})
            end
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == StormHead then --Stormwaker Prediction
        if frame == StormFrame then -- RDM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "SUPPORT"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SoulHead then -- Soulsoother Prediction
        if frame == StormFrame then -- WHM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "HEAL"})
        elseif frame == ValFrame then -- Turtle Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    elseif head == SpiritHead then -- Spiritweaver Prediction
        if frame == StormFrame then -- BLM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, const_dd})
        else
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    end
end

--Various Timers that get reset when you zone
function reset_timers()
    state.AutoMan:reset()
    Current_Maneuver = 0
    refreshWindow()
end

--Traverses a table to see if it contains the given element
function table.contains(table, element)
    for _, value in pairs(table) do
        if string.lower(value) == string.lower(element) then
            return true
        end
    end
    return false
end

--Pads a given chara on both sides (centering with left justification)
function pad(s, l, c)
    local srep = string.rep
    local c = c or " "

    local res1 = srep(c, l) .. s -- pad to half-length s
    local res2 = res1 .. srep(c, l) -- right-pad our left-padded string to the full length

    return res2
end

--Takes a condition and returns a given value based on if it is true or false
function ternary(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end

----------------------------------------------------
----------Windower Hooks/Custom Gearswap------------
----------------------------------------------------

function user_customize_idle_set(idleSet)
    --Custom Idle Group when Pet is Engaged and Master is Idle
    if Master_State:lower() == const_stateIdle:lower() and Pet_State:lower() == const_stateEngaged:lower() then
        if state.HybridMode.current == "Normal" then
            return idleSet
        else
            idleSet = sets.idle.Pet.Engaged[state.HybridMode.current]
            return idleSet
        end
    else
        return idleSet
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Activate" or spell.english == "Deus Ex Automata" then
        TotalSCalc()
        determinePuppetType()
    elseif string.find(spell.english, "Maneuver") then
        equip(sets.precast.JA.Maneuver)
    elseif sets.precast.JA[spell.english] then
        equip(sets.precast.JA[spell.english])
    elseif sets.precast.WS[spell.english] then
        equip(sets.precast.WS[spell.english])
    elseif pet.isvalid then
        if spell.english == "Deploy" and pet.tp >= 950 then
            equip(sets.midcast.Pet.WSNoFTP)
            eventArgs.handled = true
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
end

--Puppet Weaponskill Modifiers
Modifier = {}

Modifier["String Shredder"] = "VIT"
Modifier["Bone Crusher"] = "VIT"
Modifier["Armor Shatterer"] = "DEX"
Modifier["Armor Piercer"] = "DEX"
Modifier["Arcuballista"] = "DEXFTP"
Modifier["Daze"] = "DEXFTP"
Modifier["Slapstick"] = "DEX"
Modifier["Knockout"] = "AGI"

function job_aftercast(spell, action, spellMap, eventArgs)
    if pet.isvalid then
        if SC[pet.frame][spell.english] and pet.tp >= 850 and Pet_State == "Engaged" then
            ws = SC[pet.frame][spell.english]
            modif = Modifier[ws]

            --If its a valid modif
            if modif then
                equip(sets.midcast.Pet.WS[modif])

                add_to_chat(
                    392,
                    "*-*-*-*-*-*-*-*-* [ " ..
                        pet.name .. " is about to " .. ws .. " (" .. modif .. ") ] *-*-*-*-*-*-*-*-*"
                )
            else --Otherwise equip the default Weapon Skill Set
                equip(sets.midcast.Pet.WSNoFTP)
            end

            --Since this will be a new Weapon Skill we just performed best to reset any current timers
            resetWeaponSkillPetTimer()
            --Begin the count down until we may lock out the pet weapon skill set
            startWeaponSkillPetTimer()
            eventArgs.handled = true
        else
            handle_equipping_gear(player.status, Pet_State)
        end
    else
        handle_equipping_gear(player.status, Pet_State)
    end
end

function job_status_change(new, old)
    if new == "Engaged" then
        Master_State = const_stateEngaged
        TotalSCalc()

        if state.AutoDeploy.value == true and pet.isvalid then
            msg('Auto Deploying Pet')

            if windower.ffxi.get_mob_by_target('t').id then
                currentTargetedMonster = windower.ffxi.get_mob_by_target('t').id
            end

            send_command('wait 1; input /pet "Deploy" <t>')
        end
    else
        Master_State = const_stateIdle
        if state.CP.value == true then
            enable("back")
        end

        TotalSCalc()
    end

    handle_equipping_gear(player.status, Pet_State)
end

function job_pet_status_change(new, old)
    if new == "Engaged" then
        Pet_State = const_stateEngaged
        TotalSCalc()
        add_to_chat(392, "*-*-*-*-*-*-*-*-* [ Pet Engaged ] *-*-*-*-*-*-*-*-*")
    else
        Pet_State = const_stateIdle
        TotalSCalc()
        add_to_chat(392, "*-*-*-*-*-*-*-*-* [ Pet Idle ] *-*-*-*-*-*-*-*-*")
    end

    handle_equipping_gear(player.status, Pet_State)
end

AutomatonWeaponSkills =
    T {
    "Slapstick",
    "Knockout",
    "Magic Mortar",
    "Chimera Ripper",
    "String Clipper",
    "Cannibal Blade",
    "Bone Crusher",
    "String Shredder",
    "Arcuballista",
    "Daze",
    "Armor Piercer",
    "Armor Shatterer"
}

function job_pet_aftercast(spell)
    if table.contains(AutomatonWeaponSkills, spell.name) then
        justFinishedWeaponSkill = true
    end

    handle_equipping_gear(player.status, pet.status)
end

--Anytime you change equipment you need to set eventArgs.handled or else you may get overwritten
function job_buff_change(status, gain_or_loss, eventArgs)
    if status == "sleep" and gain_or_loss then
        equip(set_combine(sets.defense.PDT, {neck = "Opo-opo Necklace"}))
        eventArgs.handled = true
    elseif status == "doom" and gain_or_loss then
        send_command("input /p I have befallen to ~~~DOOM~~~ may my end not come to quickly.")
    elseif status == "doom" and gain_or_loss == false then
        send_command("input /p I have avoided the grips of ~~~DOOM~~~ may Altana be praised! ")
    end

    --When you are at 3 Maneuvers and you use the ability you will temporarily go to 4
    --This helps prevent you from trying to cast on losing a buff
    if status:contains("Maneuver") and gain_or_loss then
        Current_Maneuver = Current_Maneuver + 1
        refreshWindow()
    elseif Current_Maneuver > 0 then -- We don't want to see a negative count
        Current_Maneuver = Current_Maneuver - 1
        refreshWindow()
    end

    --Now we can turn on and off the functionailty of automatically maintaining manuevers
    --Also, make sure your not dead, so we don't attempt to recast Maneuvers
    if state.AutoMan.value and player.hp > 0 and pet.isvalid then
        if status:contains("Maneuver") and gain_or_loss == false and Current_Maneuver < 3 then
            send_command('input /ja "' .. status .. '" <me>')
        end
    end

    if status == const_stateOverdrive then
        if gain_or_loss then
            OverCount = 1
            equip(sets.midcast.Pet.WSFTP)
            eventArgs.handled = true
        else
            OverCount = 0
            equip(sets.midcast.Pet.WSNoFTP)
            eventArgs.handled = true
        end
    end
end

-- Toggles -- SE Macros: /console gs c "command"
function job_self_command(command, eventArgs)
    if command[1]:lower() == "automan" then
        state.AutoMan:toggle()
        refreshWindow()
    elseif command[1]:lower() == "debug" then
        debug_mode = not debug_mode
        debug("Debug Mode is now on!")
        refreshWindow()
    elseif command[1]:lower() == "predict" then
        determinePuppetType()
        refreshWindow()
    elseif command[1]:lower() == "hide" then
        if command[2]:lower() == "mode" then
            state.textHideMode:toggle()
            refreshWindow()
        elseif command[2]:lower() == "state" then
            state.textHideState:toggle()
            refreshWindow()
        elseif command[2]:lower() == "hub" then
            state.textHideHUB:toggle()
            refreshWindow()
        elseif command[2]:lower() == "keybinds" then
            state.Keybinds:toggle()
            refreshWindow()
        elseif command[2]:lower() == "options" then
            state.textHideOptions:toggle()
            refreshWindow()
        end
    elseif command[1]:lower() == "setftp" then
        state.SetFTP:toggle()
        refreshWindow()
    elseif command[1]:lower() == "customgearlock" then
        state.CustomGearLock:toggle()
        refreshWindow()
    end
end

--Defaults
DefaultPetWeaponSkillLockOutTimer = 8 -- This will be the time that is changeable by the player
justFinishedWeaponSkill = false
petWeaponSkillLock = false
startedPetWeaponSkillTimer = false
petWeaponSkillRecast = 0
petWeaponSkillTime = 0
currentTargetedMonster = 0
previousTargetedMonster = 0

windower.register_event(
    "prerender",
    function()
        --Items we want to check every second
        if os.time() > time_start then
            time_start = os.time()

            if pet.isvalid and player.hpp > 0 then
                --Double check current Pet Status and Player Status
                --In some cases Mote's doesn't recognize a pet's status change
                Pet_State = pet.status
                Master_State = player.status

                if Master_State == const_stateEngaged and state.AutoDeploy.value == true then
                    previousTargetedMonster = currentTargetedMonster

                    if windower.ffxi.get_mob_by_target('t').id then
                        currentTargetedMonster = windower.ffxi.get_mob_by_target('t').id
                    end

                    if previousTargetedMonster ~= currentTargetedMonster then
                        msg('Auto Deploying Pet')
                        send_command('wait 1;input /pet "Deploy" <t>')
                    end

                elseif Master_State == const_stateEngaged and state.CP.value == true then
                    if windower.ffxi.get_mob_by_target('t') then
                        monsterToCheck = windower.ffxi.get_mob_by_target('t')

                        if monsterToCheck then -- Sanity Check
                            if monsterToCheck.hpp < 15 then --Check mobs HP Percentage if below 15 then equip CP cape
                                equip({ back = CP_CAPE })
                                disable("back")
                            else
                                enable("back")
                            end
                        end

                    end
                end

                --We only want this to activate if we are actually running the timer for the pet weapon skill

                if pet.tp ~= nil then
                    if pet.tp >= 1000 and petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == true then
                        --We have passed the allowed time without the puppet using a weapon skill, locking till next round
                        petWeaponSkillRecast = 0
                        petWeaponSkillLock = true
                        handle_equipping_gear(player.status, pet.status)
                    elseif pet.tp < 1000 or Pet_State == "Idle" then
                        resetWeaponSkillPetTimer()
                    end
                end

            end

            --This reads if pet is active and
            --pet style is SPAM or DD
            --Otherwise this is handled for when the player is fighting with pet in job_aftercast
            if
                pet.isvalid and
                    (state.PetStyleCycle.value:lower() == "spam" or state.PetStyleCycle.value:lower() == "dd") and
                    Master_State:lower() == "idle"
             then
                --Now if pet has more than 1000 tp and pet is engaged and didn't just finish a weaponskill and we have not locked the pet out this set
                if
                    pet.tp >= 1000 and Pet_State == const_stateEngaged and justFinishedWeaponSkill == false and
                        petWeaponSkillLock == false
                 then
                    if state.SetFTP.value then
                        equip(set_combine(sets.midcast.Pet.WSFTP, {main = "Ohtas"}))
                    else
                        equip(set_combine(sets.midcast.Pet.WSNoFTP, {main = "Ohtas"}))
                    end

                    startWeaponSkillPetTimer()
                end
            elseif 
                pet.isvalid and pet.tp >= 900 
                and Pet_State == const_stateEngaged 
                and state.PetModeCycle.value:lower() == "dd"
                and state.PetStyleCycle.value:lower() == "spam"
                and pet.attachments.inhibitor == false and pet.attachments["inhibitor II"] == false then
                
                    if state.SetFTP.value then
                        equip(set_combine(sets.midcast.Pet.WSFTP, {main = "Ohtas"}))
                    else
                        equip(set_combine(sets.midcast.Pet.WSNoFTP, {main = "Ohtas"}))
                    end
            end

            if state.PetModeCycle.value == const_tank and Pet_State == const_stateEngaged then
                if buffactive["Fire Maneuver"] and (pet.attachments.strobe or pet.attachments["strobe II"]) then
                    if Strobe_Recast <= 2 then
                        equip(sets.pet.Enmity)
                    end
                end

                if buffactive["Light Maneuver"] and pet.attachments.flashbulb == true then
                    if Flashbulb_Recast <= 2 then
                        equip(sets.pet.Enmity)
                    end
                end
            end

            if Strobe_Recast > 0 then
                Strobe_Recast = Strobe_Timer - (os.time() - Strobe_Time)
            end

            if Flashbulb_Recast > 0 then
                Flashbulb_Recast = Flashbulb_Timer - (os.time() - Flashbulb_Time)
            end

            if petWeaponSkillRecast > 0 and startedPetWeaponSkillTimer == true then
                --Count down the timer if it has started
                petWeaponSkillRecast = DefaultPetWeaponSkillLockOutTimer - (os.time() - petWeaponSkillTime)
            end

            refreshWindow()
        end
    end
)

function startWeaponSkillPetTimer()
    if petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == false then
        petWeaponSkillRecast = DefaultPetWeaponSkillLockOutTimer
        petWeaponSkillTime = os.time()
        startedPetWeaponSkillTimer = true
    end
end

function resetWeaponSkillPetTimer()
    petWeaponSkillRecast = 0
    justFinishedWeaponSkill = false
    petWeaponSkillLock = false
    startedPetWeaponSkillTimer = false
end

windower.register_event(
    "incoming text",
    function(original, modified, mode)
        -- OVERDRIVE OPTIMIZER
        --I believe the original intent for this was if the player was not engaged and
        --the pet is fighting on its own in Overdrive.
        --With that thought this now activates when the master is not engaged
        --or if the master is engaged
        --and the PetStyleCycle is set to SPAM then it will also activate
        if
            buffactive["Overdrive"] and
                (Master_State:lower() ~= const_stateEngaged:lower() or state.PetStyleCycle.value:lower() == "spam")
         then
            if original:contains(pet.name) and original:contains("Daze") then
                equip(sets.midcast.Pet.WSFTP)
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Daze" .. " done ] *-*-*-*-*-*-*-*-*")
                OverCount = 2
            elseif original:contains(pet.name) and original:contains("Arcuballista") then
                equip(sets.midcast.Pet.WSNoFTP)
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Arcuballista" .. " done ] *-*-*-*-*-*-*-*-*")
                OverCount = 3
            elseif original:contains(pet.name) and original:contains("Armor Shatterer") then
                equip(sets.midcast.Pet.WSNoFTP)
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Armor Shatterer" .. " done ] *-*-*-*-*-*-*-*-*")
                OverCount = 4
            elseif original:contains(pet.name) and original:contains("Armor Piercer") then
                equip(sets.midcast.Pet.WSFTP)
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ " .. "Armor Piercer" .. " done ] *-*-*-*-*-*-*-*-*")
                OverCount = 1
            end
        end

        -- Checking timer for enmity sets
        if buffactive["Fire Maneuver"] then
            if original:contains(pet.name) and original:contains("Provoke") then
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Strobe done ] *-*-*-*-*-*-*-*-*")
                Strobe_Time = os.time()
                Strobe_Recast = Strobe_Timer
                handle_equipping_gear(player.status, pet.status)
                refreshWindow()
            end
        end

        if buffactive["Light Maneuver"] then
            if original:contains(pet.name) and original:contains("Flashbulb") then
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*")
                Flashbulb_Time = os.time()
                Flashbulb_Recast = Flashbulb_Timer
                handle_equipping_gear(player.status, pet.status)
                refreshWindow()
            end
        end

        return modified, mode
    end
)

--Passes state changes for cycle commands
--handle_update is always called when a job state is changed
--Best to adjust gear in job_handle_update which is an override for the job file
lastStateActivated = ""
function job_state_change(stateField, newValue, oldValue)
    lastStateActivated = stateField

    if stateField == const_PetModeCycle then
        if newValue == const_tank then
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif newValue == const_dd then
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif newValue == const_mage then
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            msg("No Style found for: " .. newValue)
        end

        handle_equipping_gear(player.status, Pet_State)
        refreshWindow()
    elseif stateField == const_PetStyleCycle then
        refreshWindow()
    elseif stateField == "Auto Maneuver" then
        refreshWindow()
    elseif stateField == "Lock Pet DT" then
        --This command overrides everything and blocks all gear changes
        --Will lock until turned off or Pet is disengaged
        if newValue == true then
            equip(sets.pet.EmergencyDT)
            disable(
                "main",
                "sub",
                "range",
                "ammo",
                "head",
                "neck",
                "lear",
                "rear",
                "body",
                "hands",
                "lring",
                "rring",
                "back",
                "waist",
                "legs",
                "feet"
            )
        else
            enable(
                "main",
                "sub",
                "range",
                "ammo",
                "head",
                "neck",
                "lear",
                "rear",
                "body",
                "hands",
                "lring",
                "rring",
                "back",
                "waist",
                "legs",
                "feet"
            )
        end
        refreshWindow()
    elseif stateField == "Lock Weapon" then
        if newValue == true then
            disable("main")
        else
            enable("main")
        end
        refreshWindow()
    elseif stateField == "Custom Gear Lock" then
        if newValue == true then
            disable(customGearLock)
        else
            enable(customGearLock)
            handle_equipping_gear(player.status, Pet_State)
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ""

    if state.PetModeCycle.value ~= "None" then
        msg = msg .. "Pet Mode: (" .. state.PetModeCycle.value .. ")"
    end

    if state.PetStyleCycle.value ~= "None" then
        msg = msg .. ", Pet Style: (" .. state.PetStyleCycle.value .. ")"
    end

    TotalSCalc()
    determinePuppetType()
    handle_equipping_gear(player.status, Pet_State)

    add_to_chat(122, msg)
end

function sub_job_change(new, old)
    determinePuppetType()
end

windower.raw_register_event("zone change", reset_timers)

--Special Debug Code that prints out to a file
function debug(message)
    if not debug_mode then
        return
    end

    --Default location is within current gearswap folder
    --Are welcome to add a custom path to the front for example C:\\users\\puppet_debug.log
    filename = 'pup_debug_' .. os.date('%m_%d_%y') .. '.log'
    debug_file = io.open(windower.addon_path .. "data/" .. filename, "a")

    io.output(debug_file)

    io.write("[" .. os.date() .. "] - Debug - " .. message .. "\n")

    io.close(debug_file)
end

--Dump the contents of a table
function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o .. "\n")
    end
end

res = require('resources')
windower.register_event('action', function(act)
    local player = windower.ffxi.get_player()
    local message = ''
    local petTP = 0
    local entityPerformingAction = ''
    local actionPerformed = 0
    local actionType = ''
    local action = ''

    if player == nil then
        return
    end

    if windower.ffxi.get_mob_by_id(act.actor_id) then
        --message = message .. "Performing Action: " .. windower.ffxi.get_mob_by_id(act.actor_id).name .. " "
        entityPerformingAction = windower.ffxi.get_mob_by_id(act.actor_id).name
    end

    if pet.isvalid and entityPerformingAction:contains(pet.name) then
        petTP = pet.tp

        if act.category == 1 then
            actionPerformed = 1
            actionType = "Melee Attack"

        elseif act.category == 2 then
            actionPerformed = 2
            actionType = "Ranged Attack"

        elseif act.category == 3 then
            actionPerformed = 3
            actionType = "Weapon Skill"
            action = res.monster_abilities[act.param].en
                    
        elseif act.category == 4 then
            actionPerformed = 4
            actionType = "Spell Casted"

        elseif act.category == 11 then
            actionPerformed = 11
            actionType = "Finish TP Move"
            action = res.monster_abilities[act.param].en

        elseif act.category == 13 then --Pet TP Move
            actionPerformed = 13
            actionType = "Start TP Move"
            action = res.monster_abilities[act.param].en

        end

        message = message .. entityPerformingAction .. " : Action -  " .. ternary(action ~= '', action, actionType)  .. " : "

        for _, target in pairs(act.targets) do
            local mob_found = windower.ffxi.get_mob_by_id(target.id)

            if mob_found then
                --message = message .. "Target: " .. windower.ffxi.get_mob_by_id(target.id).name .. " "

                for _, performed in pairs (target.actions) do
                    if entityPerformingAction:contains(pet.name) and (actionPerformed == 1 or actionPerformed == 2 or actionPerformed == 3 or actionPerformed == 11 or actionPerformed == 13) then
                        message = message .. ' Target - ' .. windower.ffxi.get_mob_by_id(target.id).name .. " : Current TP - ".. petTP .. " : Damage - " .. tostring(performed.param) .. " "
                        
                    end 
                end

                if entityPerformingAction:contains(pet.name) and (actionPerformed == 1 or actionPerformed == 2 or actionPerformed == 3 or actionPerformed == 11 or actionPerformed == 13) then
                    debug(message)
                end
            end
        end
    end 

end)
