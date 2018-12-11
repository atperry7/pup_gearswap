--Created By: Faloun
--Modified By: Arrchie
--Contributions From: Kuroganashi, Xilkk
--ASCII Art Generator: http://www.network-science.de/ascii/
local player = windower.ffxi.get_player()

--Auto Maneuvers Toggle:
--Currently, the way this works is it will simply recast the maneuver that wears off. This way you can cast any maneuvers you want and it will simply attempt to maintain what you have active.
--ALT + E
  
--Predict:
--This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
--//gs c predict
 
--Pet Mode:
--ALT+F7 Cycles forward on Pet Modes
--CTRL+F7 Cycles back on Pet Modes

--Pet Styles
--This will change the mode of the pet and the style of the pet.
--Current Modes: TANK, DD, Mage
--Current Styles:
--- Tank: Normal, PDT, MDT, RANGE
--- DD: Normal, Bone, Spam, OD, ODACC
--- Mage: Normal, Heal, Support, MB, DD
 
--ALT+F8 Cycles Forward on Pet Styles
--CTRL+F8 Cycles backward on Pet Styles
 
--Lock Pet DT Set
--ALT+D Will disable all slots and lock your Pet DT set in place

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
    --F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
    -- Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
    -- Alt-F9 - Cycle Ranged Mode.
    -- Win-F9 - Cycle Weaponskill Mode.
    -- F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    -- F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    -- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
    -- Alt-F12 - Turns off any emergency defense mode.
    -- Alt-F10 - Toggles Kiting Mode.
    -- Ctrl-F11 - Cycle Casting Mode.
    -- F12 - Update currently equipped gear, and report current status.
    -- Ctrl-F12 - Cycle Idle Mode.
    state.OffenseMode:options('Normal')
    state.RangedMode:options('Normal')
    state.HybridMode:options('Normal')
	state.WeaponskillMode:options('Normal')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
    
    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M{"NORMAL", "DD", "PDT", "MDT", "RANGE"}
    state.PetStyleCycleMage = M{"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M{"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    state.PetModeCycle = M{"TANK", "DD", "MAGE"}
    --Default to tanking set for now
    state.PetStyleCycle = state.PetStyleCycleTank
    
    --Toggles
    state.AutoMan = M(false, "Auto Maneuver")
    state.LockPetDT = M(false, "Lock Pet DT")
    
    send_command('bind !f7 gs c cycle PetModeCycle')
    send_command('bind ^f7 gs c cycleback PetModeCycle')
    send_command('bind !f8 gs c cycle PetStyleCycle')
    send_command('bind ^f8 gs c cycleback PetStyleCycle')
    send_command('bind !e gs c toggle AutoMan')
    send_command('bind !d gs c toggle LockPetDT')
    
    select_default_macro_book()
end

function file_unload()
    send_command('unbind !f7')
    send_command('unbind ^f7')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind !e')
    send_command('unbind !d')
end

function job_setup()
    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window 
    setupTextWindow(1400, 600)
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
    --This section is best ultilized for defining gear that is used among multiple sets

    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +1" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches" --Role Reversal 

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe"

    Visucius = {}
    Visucius.PetDT = { name = "Visucius's Mantle", augments = {"Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20","Accuracy+20 Attack+20","Pet: Accuracy+4 Pet: Rng. Acc.+4", 'Pet: "Regen"+10',"Pet: Damage taken -5%"  } }
    Visucius.PetMagic = { name = "Visucius's Mantle", augments = {"Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20","Accuracy+20 Attack+20","Pet: Accuracy+4 Pet: Rng. Acc.+4", 'Pet: "Regen"+10',"Pet: Damage taken -5%"  } }


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

    -------------------------------------Fastcast
    sets.precast.FC = {
        head = "Haruspex Hat",
        body = "Zendik Robe",
        legs = "Orvail Pants +1",
        ear2 = "Loquacious Earring",
        hands = "Thaumas Gloves",
        ring1 = "Prolix Ring",
        ring2 = "Lebeche Ring",
        ear2 = "Loquac. Earring",
        neck = "Orunmila's Torque"
    }

    -------------------------------------Midcast
    sets.midcast = {}
    sets.midcast.FastRecast = {
        head = "Haruspex Hat",
        ear2 = "Loquacious Earring",
        body = "Otronif Harness +1",
        hands = "Regimen Mittens",
        legs = "Manibozho Brais",
        feet = "Otronif Boots +1"
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})

    sets.precast.JA = {}
    -- Precast sets to enhance JAs
    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_PMagic}
    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}
    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}
    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
        feet = Artifact_Foire.Feet_Repair_PMagic, "Guignol Earring"
    }

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar +1",
        body = Empy_Karagoz.Body_Overload,
        hands = Artifact_Foire.Hands_Mane_Overload,
        back = Visucius.PetDT,
        ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = Visucius.PetDT}
    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
        feet = "Ahosi Leggings",
        neck = "Unmoving Collar",
        feet = "Rager Ledel. +1",
        hands = "Kurys Gloves",
        ring1 = "Provocare Ring"
    }

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
        head = "Whirlpool Mask",
        ear1 = "Roundel Earring",
        body = "Otronif Harness +1",
        hands = "Otronif Gloves",
        ring1 = "Spiral Ring",
        back = "Iximulew Cape",
        legs = "Nahtirah Trousers",
        feet = "Thurandaut Boots +1"
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head = RAOWShead,
        neck = "Rancor Collar",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = "Abnoba Kaftan",
        hands = Relic_Hands,
        ring1 = "Shukuyu Ring",
        ring2 = "Rufescent Ring",
        back = JSECAPESTR,
        waist = "Moonbow Belt",
        legs = Relic_Legs,
        feet = "Ryuo Sune-Ate"
    } --"Hiza. Hizayoroi +2"

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = sets.precast.WS
    sets.precast.WS["Stringing Pummel"].Mod = sets.precast.WS

    sets.precast.WS["Victory Smite"] = sets.precast.WS

    sets.precast.WS["Shijin Spiral"] =
        set_combine(
        sets.precast.WS,
        {
            head = Relic_Head,
            body = Relic_Body,
            hands = Relic_Hands,
            legs = Relic_Legs,
            feet = "Heyoka leggings",
            ring1 = "Apate Ring",
            ring2 = "Petrov Ring"
        }
    )

    sets.precast.WS["Howling Fist"] = {
        head = RAOWShead,
        neck = "Fotia Gorget",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = AF_Body,
        hands = Relic_Hands,
        ring1 = "Shukuyu Ring",
        ring2 = "Rufescent Ring",
        back = JSECAPESTR,
        waist = "Moonbow Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = "Ryuo Sune-Ate"
    }
    
    -------------------------------------Idle
    sets.idle = {
        range = "Animator P +1",
        ammo = "Automat. Oil +3",
        head = Relic_Head,
        body = "Udug Jacket",
        hands = "Tali'ah Gages +1",
        legs = "Tali'ah Sera. +1",
        feet = "Tali'ah Crackows +1",
        neck = "Pup. Collar",
        waist = "Moonbow Belt",
        left_ear = "Burana Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Thurandaut Ring",
        right_ring = "Varar Ring +1"
    }
    
    -------------------------------------Engaged
    sets.engaged = {
        head="Heyoka Cap",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +1",
        legs="Tali'ah Sera. +1",
        feet="Heyoka Leggings",
        neck="Pup. Collar",
        waist="Moonbow Belt",
        left_ear="Mache Earring +1",
        right_ear="Mache Earring +1",
        left_ring="Varar Ring +1",
        right_ring="Chirich Ring",
    }
    
    sets.engagedN = {
        head="Heyoka Cap",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +1",
        legs="Tali'ah Sera. +1",
        feet="Heyoka Leggings",
        neck="Pup. Collar",
        waist="Moonbow Belt",
        left_ear="Mache Earring +1",
        right_ear="Mache Earring +1",
        left_ring="Varar Ring +1",
        right_ring="Chirich Ring",
    }
    
    sets.engagedMO = {
        head="Heyoka Cap",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +1",
        legs="Tali'ah Sera. +1",
        feet="Heyoka Leggings",
        neck="Pup. Collar",
        waist="Moonbow Belt",
        left_ear="Mache Earring +1",
        right_ear="Mache Earring +1",
        left_ring="Varar Ring +1",
        right_ring="Chirich Ring",
    }

    sets.engaged.Acc = {
        head="Heyoka Cap",
        body="Tali'ah Manteel +2",
        hands="Tali'ah Gages +1",
        legs="Tali'ah Sera. +1",
        feet="Heyoka Leggings",
        neck="Pup. Collar",
        waist="Moonbow Belt",
        left_ear="Mache Earring +1",
        right_ear="Mache Earring +1",
        left_ring="Varar Ring +1",
        right_ring="Chirich Ring",
    }
    
    sets.engaged.DT = {
        head = Relic_Head,
        body = "Udug Jacket",
        hands = "Herculean Gloves",
        legs = "Herculean Trousers",
        feet = "Herculean Boots",
        neck = "Warder's Charm +1",
        waist = "Moonbow Belt",
        left_ear = "Dominance Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Supershear Ring",
        right_ring = "Kunaji Ring",
        back = "Moonbeam Cape"
    }

    sets.engaged.Acc.DT = {
        head = Relic_Head,
        body = "Udug Jacket",
        hands = "Herculean Gloves",
        legs = "Herculean Trousers",
        feet = "Herculean Boots",
        neck = "Warder's Charm +1",
        waist = "Moonbow Belt",
        left_ear = "Dominance Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Supershear Ring",
        right_ring = "Kunaji Ring",
        back = "Moonbeam Cape"
    }

    ----------------------------------------------------------------------------------
    --  _    _       _          _     _    ____        _          _____      _       
    -- | |  | |     | |        (_)   | |  / __ \      | |        / ____|    | |      
    -- | |__| |_   _| |__  _ __ _  __| | | |  | |_ __ | |_   _  | (___   ___| |_ ___ 
    -- |  __  | | | | '_ \| '__| |/ _` | | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | |_| | |_) | |  | | (_| | | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__, |_.__/|_|  |_|\__,_|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --          __/ |                                     __/ |                      
    --         |___/                                     |___/                       
    -----------------------------------------------------------------------------------

    -------------------------------------Idle
    set.hybrid = {}

    -------------------------------------Engaged
    set.hybrid.engaged = {}
    
    -------------------------------------TP
    set.hybrid.engaged.TP = {}
    
    -------------------------------------Acc
    set.hybrid.engaged.Acc = {}
    
    -------------------------------------DT
    set.hybrid.DT = {}
    
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
    --This section for sets pretaining to Pets

    set.pet = {}

    -------------------------------------TP

    set.pet.TP = {}

    -------------------------------------DT
    sets.pet.Tank = {
        ammo = "Automat. Oil +3",
        head = {name = "Anwig Salade", augments = {"Attack+3", "Pet: Damage taken -10%", "Attack+3", 'Pet: "Regen"+1'}},
        body = {name = "Taeon Tabard", augments = {"Pet: Evasion+21", 'Pet: "Dbl. Atk."+4', "Pet: Damage taken -4%"}},
        hands = "Tali'ah Gages +1",
        legs = "Tali'ah Sera. +1",
        feet = "Tali'ah Crackows +1",
        neck = "Pup. Collar",
        waist = "Klouskap Sash",
        left_ear = "Handler's Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Thurandaut Ring",
        right_ring = "Varar Ring +1",
        back = Visucius.DT
    }
    
    -------------------------------------Magic Midcast
    sets.midcast.Pet = {}
    
    sets.midcast.Pet.Cure = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,legs="Foire Churidars +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Elemental Magic'] = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}

    sets.midcast.Pet['Enfeebling Magic'] = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Dark Magic'] = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Divine Magic'] = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Enhancing Magic'] = {ear2="Enmerkar Earring",ear1="Burana Earring",back=Visucius.PetMagic,head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}

    -------------------------------------Idle
    sets.idle.Pet = sets.idle

    -------------------------------------Enmity
    sets.pet.Enmity = {
        head = "Heyoka Cap",
        body = "Heyoka Harness",
        hands = "Heyoka Mittens",
        legs = "Heyoka Subligar",
        feet = "Heyoka Leggings",
        ear1 = "Domesticator's Earring"
    }
    
    -------------------------------------Engaged
    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.EngagedO = {
        head = "Tali'ah Turban +1",
        neck = "Empath Necklace",
        ear1 = "Burana Earring",
        ear2 = "Domes. Earring",
        body = Relic_Body,
        hands = "Tali'ah Gages +1",
        ring1 = "Varar Ring",
        ring2 = "Varar Ring",
        back = JSECAPEPetHaste,
        waist = "Incarnation Sash",
        legs = HercLegsPET,
        feet = "Herculean Boots"
    }

    sets.idle.Pet.Engaged = sets.idle.Pet.EngagedO
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {legs = "Kara. Pantaloni +1"})

    sets.idle.Pet.Engaged.Nuke =
        set_combine(sets.idle.Pet.Engaged, {legs = Relic_Legs, feet = Relic_Feet, ear1 = "Burana Earring"})
    
    sets.idle.Pet.Engaged.Magic =
        set_combine(sets.idle.Pet.Engaged, {legs = Relic_Legs, feet = Relic_Feet, ear1 = "Burana Earring"})
    

    -------------------------------------WS
    sets.midcast.Pet.WeaponSkillNoAcc = {
        neck = "Empath Necklace",
        head = Empy_Head,
        body = "Tali'ah Manteel +2",
        waist = "Incarnation Sash",
        hands = Empy_Hands,
        ring1 = "Varar Ring",
        ring2 = "Varar Ring",
        legs = HercLegsPET,
        feet = "Punchinellos",
        back = "Dispersal Mantle"
    }

    sets.midcast.Pet.WSNoFTP = {
        neck = "Empath Necklace",
        head = Relic_Head,
        body = "Tali'ah Manteel +2",
        waist = "Incarnation Sash",
        hands = Empy_Hands,
        ring1 = "Thurandaut Ring",
        ring2 = "Varar Ring +1",
        legs = "Kara. Pantaloni +1",
        feet = "Naga Kyahan",
        back = JSECAPEPetHaste
    }

    sets.midcast.Pet.WSFTP = {
        neck = "Empath Necklace",
        head = Empy_Head,
        body = "Tali'ah Manteel +2",
        waist = "Incarnation Sash",
        hands = Empy_Hands,
        ring1 = "Thurandaut Ring",
        ring2 = "Varar Ring",
        legs = "Kara. Pantaloni +1",
        feet = "Naga Kyahan",
        back = "Dispersal Mantle"
    }

    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSNoFTP
    sets.midcast.Pet.WS = {}
    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WeaponSkill, {})
    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WeaponSkill,
        {head = Empy_Head, legs = HercLegsPET, waist = "Incarnation Sash", feet = HercBootBone}
    )
    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WeaponSkill, {})
    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WeaponSkill, {legs = HercLegsPetDEX})
    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(sets.midcast.Pet.WS["DEX"], {head = Empy_Head, back = "Dispersal Mantle"})

    ---------------------------------------------
    --  __  __ _             _____      _       
    -- |  \/  (_)           / ____|    | |      
    -- | \  / |_ ___  ___  | (___   ___| |_ ___ 
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = sets.idle

    -- Resting sets
    sets.resting = {
        head = Relic_Head,
        neck = "Wiglen Gorget",
        ring1 = "Sheltered Ring",
        ring2 = "Paguroidea Ring"
    }

    -- Defense sets
    sets.defense = {}
    sets.defense.Evasion = {
        head = "Whirlpool Mask",
        neck = "Loricate Torque",
        body = "Otronif Harness +1",
        hands = "Otronif Gloves",
        ring1 = "Defending Ring",
        ring2 = "Beeline Ring",
        back = "Ik Cape",
        waist = "Incarnation Sash",
        legs = "Nahtirah Trousers",
        feet = "Otronif Boots +1"
    }

    sets.defense.PDT = {
        head = Relic_Head,
        body = "Udug Jacket",
        hands = "Herculean Gloves",
        legs = "Herculean Trousers",
        feet = "Herculean Boots",
        neck = "Warder's Charm +1",
        waist = "Moonbow Belt",
        left_ear = "Dominance Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Supershear Ring",
        right_ring = "Kunaji Ring",
        back = "Moonbeam Cape"
    }

    sets.defense.MDT = {
        head = Relic_Head,
        body = "Udug Jacket",
        hands = "Herculean Gloves",
        legs = "Herculean Trousers",
        feet = "Herculean Boots",
        neck = "Warder's Charm +1",
        waist = "Moonbow Belt",
        left_ear = "Dominance Earring",
        right_ear = "Handler's Earring +1",
        left_ring = "Supershear Ring",
        right_ring = "Kunaji Ring",
        back = "Moonbeam Cape"
    }

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 1)
	elseif player.sub_job == 'DNC' then
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
OverPower = false
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

d_mode = false

visible = true

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
SC['Valoredge Frame'] = {}
SC['Sharpshot Frame'] = {}
SC['Harlequin Frame'] = {}
 
SC['Valoredge Frame']['Stringing Pummel'] = "String Shredder"
SC['Valoredge Frame']['Victory Smite'] = "String Shredder"
SC['Valoredge Frame']['Shijin Spiral'] = "Bone Crusher"
SC['Valoredge Frame']['Howling Fist'] = "String Shredder"
 
SC['Sharpshot Frame']['Stringing Pummel'] = "Armor Shatterer"
SC['Sharpshot Frame']['Victory Smite'] = "Armor Shatterer"
SC['Sharpshot Frame']['Shijin Spiral'] = "Armor Piercer"
SC['Sharpshot Frame']['Howling Fist'] = "Arcuballista"
SC['Sharpshot Frame']['Dragon Kick'] = "Armor Shatterer"
SC['Sharpshot Frame']['One Inch Punch'] = "Daze"
SC['Sharpshot Frame']['Spinning Attack'] = "Armor Shatterer"
SC['Sharpshot Frame']['Base'] = "Arcuballista"
 
SC['Harlequin Frame']['Stringing Pummel'] = "Slapstick"
SC['Harlequin Frame']['Victory Smite'] = "Magic Mortar"
SC['Harlequin Frame']['Shijin Spiral'] = "Slapstick"
SC['Harlequin Frame']['Howling Fist'] = "Knockout"

--Puppet Weaponskill Modifiers
Modifier = {}
 
Modifier['String Shredder'] = "VIT"
Modifier['Bone Crusher'] = "VIT"
Modifier['Armor Shatterer']  = "DEX"
Modifier['Armor Piercer']  = "DEX"
Modifier['Arcuballista']  = "DEXFTP"
Modifier['Daze']  = "DEXFTP"
Modifier['Slapstick'] = "DEX"
Modifier['Knockout'] = "AGI"
 
-- Colors for Text
Colors = {}
Colors["Fire"] = "\\cs(102, 0, 0)"
Colors["Water"] = "\\cs(0, 51, 102)"
Colors["Wind"] = "\\cs(51, 102, 0)"
Colors["Dark"] = "\\cs(0, 0, 0)"
Colors["Light"] = "\\cs(255, 255, 255)"
Colors["Earth"] = "\\cs(139, 69, 19)"
Colors["Ice"] = "\\cs(0, 204, 204)"
Colors["Thunder"] = "\\cs(51, 0, 102)"

------------------------------------
------------Text Window-------------
------------------------------------

--Default To Set Up the Text Window
function setupTextWindow(pos_x, pos_y)
    tb_name = "pup_gs_helper"
    bg_visible = true
    textinbox = ' '

    windower.text.create(tb_name)
    -- table_name, x, y
    windower.text.set_location(tb_name, pos_x, pos_y)
    -- transparency, rgb
    windower.text.set_bg_color(tb_name, 200, 40, 40, 55)
    windower.text.set_color(tb_name, 255, 147, 161, 161)
    windower.text.set_font(tb_name, "Arial")
    windower.text.set_font_size(tb_name, 11)
    windower.text.set_bold(tb_name, true)
    windower.text.set_italic(tb_name, false)
    windower.text.set_text(tb_name, textinbox)
    windower.text.set_bg_visibility(tb_name, bg_visible)
    windower.text.set_visibility(tb_name, visible)
end

--Hanldles refreshing the current text window
function refreshWindow()
    textinbox = ' '
    textColorNewLine = '\\cr \n'
    textColorEnd = ' \\cr'
    textColor = '\\cs(125, 125, 0)'

    if pet.isvalid then
        drawPetInfo()
        drawPetSkills()
    end

    textinbox = textinbox..drawTitle('   Mode   ')
    textinbox = textinbox..textColor..'Pet Mode : '..state.PetModeCycle.value..textColorNewLine
    textinbox = textinbox..textColor..'Pet Style : '..state.PetStyleCycle.value..textColorNewLine
    
    textinbox = textinbox..drawTitle('    State    ')
    textinbox = textinbox..textColor..'Master : '..Master_State..textColorNewLine
    textinbox = textinbox..textColor..'Pet : '..Pet_State..textColorNewLine
    textinbox = textinbox..textColor..'Hybrid : '..Hybrid_State..textColorNewLine

    textinbox = textinbox..drawTitle('  Options  ')
    textinbox = textinbox..textColor..'Auto Maneuver : '..ternary(state.AutoMan.value, 'ON', 'OFF')..textColorNewLine
    textinbox = textinbox..textColor..'Lock Pet DT Set: '..ternary(state.LockPetDT.value, 'ON', 'OFF')..textColorNewLine


    --Debug Variables that are used for testing
    if d_mode then
        textinbox = textinbox..drawTitle("DEBUG")
        textinbox = textinbox..textColor..'Current Maneuvers : '..Current_Maneuver..textColorNewLine
        textinbox = textinbox..textColor..'Strobe II Attached : '..tostring(pet.attachments["strobe II"])..textColorNewLine
        textinbox = textinbox..textColor..'Flashbulb Attached : '..tostring(pet.attachments.flashbulb)..textColorNewLine
        textinbox = textinbox..textColor..'AutoMan : '..tostring(state.AutoMan.value)..textColorNewLine
    end

    windower.text.set_text(tb_name, textinbox)
end

--Handles drawing the Pet Info for the Text Box
function drawPetInfo()
    textinbox = textinbox..drawTitle('Pet Info')
    textinbox = textinbox..'- \\cs(0, 0, 125)HP : '..pet.hp..'/'..pet.max_hp..textColorNewLine
    textinbox = textinbox..'- \\cs(0, 125, 0)MP : '..pet.mp..'/'..pet.max_mp..textColorNewLine
    textinbox = textinbox..'- \\cs(255, 0, 0)TP : '..tostring(pet.tp)..textColorNewLine
end

--This handles drawing the Pet Skills for the text box
function drawPetSkills()
    --- Recast for enmity gears

        textinbox = textinbox..drawTitle("Pet Skills")
        -- Strobe recast
        if Strobe_Recast == 0 and pet.attachments.strobe then
            if buffactive['Fire Maneuver'] then
                textinbox = textinbox..'\\cs(125, 125, 125)-\\cr \\cs(125,0,0)Strobe\\cr \n'
            else
                textinbox = textinbox..'\\cs(125, 125, 125)- Strobe\\cr \n'
            end
        elseif pet.attachments.strobe ~= nil then
            textinbox = textinbox..'\\cs(125, 125, 125)- Strobe ('..Strobe_Recast..')\\cr \n'
        end
        
        -- Flashbulb recast    
        if Flashbulb_Recast == 0 and pet.attachments.flashbulb then
            if buffactive['Light Maneuver'] then
                textinbox = textinbox..'\\cs(125, 125, 125)-\\cr \\cs(255,255,255)Flashbulb\\cr \n'
            else
                textinbox = textinbox..'\\cs(125, 125, 125)- Flashbulb\\cr \n'
            end
        elseif pet.attachments.flashbulb ~= nil then
            textinbox = textinbox..'\\cs(125, 125, 125)- Flashbulb ('..Flashbulb_Recast..')\\cr \n'
        end

end

--Creates the Title for a section in the Text Screen
function drawTitle(title)
    return '\\cs(255, 115, 0)'..pad(tostring(title), 6, '=')..'\\cr \n'
end

function msg(str)
    send_command('@input /echo *-*-*-*-*-*-*-*-* ' .. str .. ' *-*-*-*-*-*-*-*-*')
end

------------------------------------
----------Utility Functions---------
------------------------------------

--Used to calculate the Hybrid State of you and your pet
function TotalSCalc()


    if state.PetModeCycle.value == const_dd then
        if buffactive['Overdrive'] then
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
    elseif state.PetModeCycle.value == const_tank then
        if Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_tank
        end
    else
        Pet_State = const_mage
        if Master_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_masterOnly
        end
    end
end

--Determines Gear based on that Hybrid Set
function determineGearSet()
    if state.PetModeCycle.value == const_tank then
        equip(sets.pet.Tank)
    elseif Hybrid_State == const_stateIdle then
        equip(sets.idle)
    elseif Hybrid_State == const_masterOnly then
        equip(sets.engagedMO)
    elseif Hybrid_State == const_petOnly then
        equip(sets.idle.Pet.EngagedO)
    elseif Hybrid_State == const_stateHybrid then
        equip(sets.engagedN)
    elseif Hybrid_State == const_stateOverdrive then
        equip(sets.engaged)
    else
        handle_equipping_gear(player.status)
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
    --Tested and failed Set Command state.PetModeCycle:set('') // using this method won't invoke call to sub method needed to update items
    if head == HarHead then --Harlequin Predictions
        if frame == HarFrame and (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then --Magic Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "MDT"})
        elseif frame == HarFrame then -- Default
            handle_set({const_PetModeCycle, const_dd})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
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
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
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
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
        end
    elseif head == StormHead then --Stormwaker Prediction
        if frame == StormFrame then -- RDM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "SUPPORT"})
        else
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
        end
    elseif head == SoulHead then -- Soulsoother Prediction
        if frame == StormFrame then -- WHM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "HEAL"})
        elseif frame == ValFrame then -- Turtle Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
        end
    elseif head == SpiritHead then -- Spiritweaver Prediction
        if frame == StormFrame then -- BLM
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, const_dd})
        else
            msg('Unable to determine Mode/Style for Puppet Head: ('..head..') Puppet Frame: ('..frame..')')
        end
    end
end

--Various Timers that get reset when you zone
function reset_timers()
    Current_Maneuver = 0
    state.AutoMan:reset()
    refreshWindow()
end

--Traverses a table to see if it contains the given element
function table.contains(table, element)
    for _, value in pairs(table) do
      if string.lower(value) == element then
        return true
      end
    end
    return false  
end

--Pads a given chara on both sides (centering with left justification)
function pad(s, l, c)
    local srep = string.rep
    local c = c or ' '

    local res1 = srep(c, l) .. s -- pad to half-length s
    local res2 = res1 .. srep(c,  l) -- right-pad our left-padded string to the full length

    return res2
end

--Takes a condition and returns a given value based on if it is true or false
function ternary(cond , T , F)
    if cond then 
        return T 
    else 
        return F 
    end
end

------------------------------------
----------Windower Hooks------------
------------------------------------

function job_precast(spell,action)

    if spell.english == "Deploy" and pet.tp >= 950 then
        equip(sets.midcast.Pet.WeaponSkill)

    elseif string.find(spell.english,'Maneuver') then
        equip(sets.precast.JA.Maneuver)

    elseif sets.precast.JA[spell.english] then
        equip(sets.precast.JA[spell.english])

    elseif sets.precast.WS[spell.english] then
        equip(sets.precast.WS[spell.english])

    else
        equip(sets.precast.FC)
    end
end
 
function job_midcast(spell,action)
end
 
function job_aftercast(spell,action)
    
    if spell.name == null then
        return -- Cancel Aftercast for out of range/unable to see.
    end

    if (spell.english == "Shijin Spiral" or spell.english == "Victory Smite" or spell.english == "Stringing Pummel" or spell.english == "Howling Fist") and pet.tp >= 850 then
        ws = SC[pet.frame][spell.english]
        modif = Modifier[ws]
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ '..pet.name..' is about to '..ws..' ('..modif..') ] *-*-*-*-*-*-*-*-*')
        equip(sets.midcast.Pet.WS[modif])
    else
        determineGearSet()
    end
end
 
function job_status_change(new,old)
    if new == 'Engaged' then
        Master_State = const_stateEngaged
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Engaged ] *-*-*-*-*-*-*-*-*')
    else
        Master_State=const_stateIdle
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Idle ] *-*-*-*-*-*-*-*-*')
    end
    
    determineGearSet()
   
end
 
function job_pet_status_change(new,old)
    if new == 'Engaged' then
        Pet_State = const_stateEngaged
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Pet Engaged ] *-*-*-*-*-*-*-*-*')
    else
        Pet_State=const_stateIdle
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Pet Idle ] *-*-*-*-*-*-*-*-*')
    end
    
    determineGearSet()
end
 
function job_pet_aftercast(spell)
    determineGearSet()
end

function job_buff_change(status,gain_or_loss, buff_table)
    
    if status == "sleep" then
        if gain_or_loss then
            equip(set_combine(sets.defense.PDT, {neck="Opo-opo Necklace"}))
        end
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
    if state.AutoMan.value then
        if status:contains("Maneuver") and gain_or_loss == false and Current_Maneuver < 3 then
            send_command('input /ja "'..status..'" <me>')
        end
    end

    if status == const_stateOverdrive then
        if gain_or_loss then
            OverPower = true
            OverCount = 1
            sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSFTP
        else
            OverPower = false
            OverCount = 0
            sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSNoFTP
        end
    end
   
end
 
-- Toggles -- SE Macros: /console gs c "command" [case sensitive]
function job_self_command(command, eventArgs)
    
    if command[1]:tolower() == 'automan' then
        state.AutoMan:toggle()
        refreshWindow()
    elseif command[1]:tolower() == 'debug' then
        d_mode = not d_mode
        refreshWindow()
    elseif command[1]:tolower() == 'predict' then
        determinePuppetType()
        refreshWindow()
    end

end

windower.register_event('prerender', function()

    --Items we want to check every second
    if os.time() > time_start then
        time_start = os.time()

        if ActualMode == const_tank and Pet_State == const_stateEngaged then
            if buffactive['Fire Maneuver'] and pet.attachments.strobe then
                if Strobe_Recast == 0 then
                    equip(sets.pet.Enmity)
                end
            end

            if buffactive['Light Maneuver'] and pet.attachments.flashbulb then
                if Flashbulb_Recast == 0 then
                    equip(sets.pet.Enmity)
                end
            end
        end

        if Strobe_Recast > 0 then
            Strobe_Recast = Strobe_Timer -(os.time() - Strobe_Time)
        end
       
        if Flashbulb_Recast > 0 then
            Flashbulb_Recast = Flashbulb_Timer -(os.time() - Flashbulb_Time)
        end

        if state.PetModeCycle.value == const_tank then
            -- Nothing
        elseif Hybrid_State == const_petOnly or Hybrid_State == const_stateOverdrive then
            if pet.tp >= 950 then
                equip(sets.midcast.Pet.WeaponSkill)
            end
        else
            determineGearSet()
        end

        TotalSCalc()
        refreshWindow()
    end
   
end)
 
windower.register_event('incoming text', function(original, modified, mode)
    local match

        -- OVERDRIVE OPTIMIZER
            if buffactive["Overdrive"] then
                match = original:match(pet.name..' readies ([%s%w]+)%.')
                if original:contains(pet.name) and original:contains("Daze") then
                    equip(sets.midcast.Pet.WSFTP)
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 2
                elseif original:contains(pet.name) and original:contains("Arcuballista") then
                    equip(sets.midcast.Pet.WSNoFTP)
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 3
                elseif original:contains(pet.name) and original:contains("Armor Shatterer") then
                    equip(sets.midcast.Pet.WSNoFTP)
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 4
                elseif original:contains(pet.name) and original:contains("Armor Piercer") then
                    equip(sets.midcast.Pet.WSFTP)
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 1
                end
            end

            -- Checking timer for enmity sets
            if buffactive['Fire Maneuver'] then
                if original:contains(pet.name) and original:contains("Provoke") then
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ Strobe done ] *-*-*-*-*-*-*-*-*')
                    Strobe_Time = os.time()
                    Strobe_Recast = Strobe_Timer
                    refreshWindow()
                    determineGearSet()
                end
            end
            
            if buffactive['Light Maneuver'] then
                if original:contains(pet.name) and original:contains("Flashbulb") then
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*')
                    Flashbulb_Time = os.time()
                    Flashbulb_Recast = Flashbulb_Timer
                    refreshWindow()
                    determineGearSet()
                end
            end
        
       
    return modified, mode
end)

--Passes state changes for cycle commands
function job_state_change(stateField, newValue, oldValue)
    local fullGearSlots = {'main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring', 'ear1', 'ear2','back','waist','legs','feet'}

    if stateField == const_PetModeCycle then
        
        if newValue == const_tank then
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif newValue == const_dd then
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif newValue == const_mage then
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            msg("No Style found for: "..newValue..' Mode setting to default DD Mode')
            state.PetStyleCycle = state.PetStyleCycleDD
        end

        ActualSubMode = state.PetStyleCycle.value
        refreshWindow()
    elseif stateField == const_PetStyleCycle then
        ActualSubMode = newValue
        refreshWindow()
    elseif stateField == 'Auto Maneuver' then
        refreshWindow()
    elseif stateField == 'Lock Pet DT' then
        --If true then lock all gear
        if newValue == true then
            equip(sets.pet.Tank)
            disable(fullGearSlots)
        else
            enable(fullGearSlots)
            determineGearSet()
        end
        refreshWindow()
    end

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting, '
    end

    if state.PetModeCycle.value ~= 'None' then
        msg = msg..', Pet Mode: ('..state.PetModeCycle.value..')'
    end

    if state.PetStyleCycle.value ~= 'None' then
        msg = msg..', Pet Style: ('..state.PetStyleCycle.value..")"
    end

    add_to_chat(4, msg)
    eventArgs.handled = true
end

function sub_job_change(new,old)
    determinePuppetType()
end

windower.raw_register_event('zone change', reset_timers)