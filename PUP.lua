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
--Created By: Faloun
--Modified By: Arrchie
--Contributions From: Kuroganashi, Xilkk, Byrne, Blackhalo714
--ASCII Art Generator: http://www.network-science.de/ascii/

--Auto Maneuvers Toggle:
--Currently, the way this works is it will simply recast the maneuver that wears off. This way you can cast any maneuvers you want and it will simply attempt to maintain what you have active.
--ALT + E
  
--Predict:
--This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
--//gs c predict
--ALT+F6
 
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
    -- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
    state.OffenseMode:options('MasterTP', 'MasterAcc', 'PetTP', 'PetAcc')
    
    -- Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
    state.HybridMode:options('MPAcc', 'MPTP', 'MPDT')
    
    -- Alt-F12 - Turns off any emergency defense mode.
    -- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
    -- F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    state.PhysicalDefenseMode:options('MasterDT', 'PetDT')
    
    -- F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    
    -- Alt-F10 - Toggles Kiting Mode.
    
    -- F12 - Update currently equipped gear, and report current status.
    -- Ctrl-F12 - Cycle Idle Mode.
    state.IdleMode:options('Idle', 'MasterDT', 'PetDT')
    
    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M{"NORMAL", "DD", "PDT", "MDT", "RANGE"}
    state.PetStyleCycleMage = M{"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M{"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M{"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
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
    send_command('bind !f6 gs c predict')
    
    select_default_macro_book()
end

function file_unload()
    send_command('unbind !f7')
    send_command('unbind ^f7')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind !e')
    send_command('unbind !d')
    send_command('unbind !f6')
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
	head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Ogapepo Cape",waist="Witful Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"
    }

    -------------------------------------Midcast
    sets.midcast = {} -- Initilization Keep Empty

    sets.midcast.FastRecast = {
    head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Ogapepo Cape",waist="Witful Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"
	}

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads",body="Passion Jacket"})

    sets.precast.JA = {} -- Initilization Keep Empty
    -- Precast sets to enhance JAs
    sets.precast.JA["Tactical Switch"] = {feet = "Karagoz Scarpe +1"}
    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}
    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}
    sets.precast.JA["Overdrive"] = {body = "Pitre Tobe +1"}

    sets.precast.JA["Repair"] = {feet="Foire Babouches +1",ear1="Guignol Earring",ear2="Pratik Earring",legs="Desultor Tassets"}

	sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})
	
    sets.precast.JA.Maneuver = {main="Midnights",neck="Buffoon's Collar +1",body="Karagoz Farsetto",hands="Foire Dastanas +1",back="Visucius's Mantle",ear1="Burana Earring"}

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}
    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {ear1="Friomisi Earring",ear2="Cryptic Earring",neck="Unmoving Collar +1",body="Passion Jacket",hands="Kurys Gloves",ring1="Petrov Ring",ring2="Begrudging Ring",legs="Obatala Subligar",feet="Ahosi Leggings"}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Herculean Helm",neck="Unmoving Collar +1",ear2="Roundel Earring",ear1="Soil Pearl",
        body="Passion Jacket",hands="Slither Gloves +1",ring1="Niqmaddu Ring",ring2="Titan Ring",
        back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hizamaru Somen +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Ryuo Domaru",hands="Hizamaru Kote +1",ring1="Niqmaddu Ring",ring2="Epona's Ring",
        back="Visucius's Mantle",waist="Fotia Belt",legs="Rao Haidate",feet="Hiza. Sune-ate +1"} --"Hiza. Hizayoroi +2"

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
	head="Lilitu Headpiece",
	body="Abnoba Kaftan",
	hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
	legs="Ta'lab Trousers",
	feet="Hiza. Sune-ate +1",
    neck="Fotia Gorget",
	waist="Fotia Belt",
	back="Rancorous Mantle",
	})--Caro Necklace / Grunfeld Rope
    sets.precast.WS["Stringing Pummel"].Mod =  set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
	neck="Fotia Gorget",
	body="Ryuo Domaru",
	waist="Moonbow Belt",
	ring1="Niqmaddu Ring",
	ring2="Begrudging Ring",
	hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
    legs="Rao Haidate",
	feet={ name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}},
	back="Dispersal Mantle",
	head="Rao Kabuto"})--Rao Haidate/Hiza. Hizayoroi +1/Abnoba Kaftan

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",body="Naga Samue",hands="Rawhide Gloves",legs="Samnuha Tights",neck="Fotia Gorget",waist="Fotia Belt"}
	)

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
        neck = "Fotia Gorget",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = Artifact_Foire.Body_WSD_PTank,
        hands = Relic_Pitre.Hands_WSD,
        ring1 = "Shukuyu Ring",
        ring2 = "Rufescent Ring",
        waist = "Moonbow Belt",
        legs = "Hiza. Hizayoroi +2",
        feet = "Ryuo Sune-Ate"
    })
    
    -------------------------------------Idle
    sets.idle = {main="Ohtas",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Infused Earring",
        body="Hiza. Haramaki +2",hands="Rao Kote",ring1="Matrimony Ring",ring2="Defending Ring",
        back="Contriver's Cape",waist="Isa Belt",legs="Rao Haidate",feet="Hermes' Sandals"} -- Initilization Keep Empty

	sets.idle.Normal = {main="Ohtas",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Infused Earring",
        body="Hiza. Haramaki +2",hands="Rao Kote",ring1="Matrimony Ring",ring2="Defending Ring",
        back="Contriver's Cape",waist="Isa Belt",legs="Rao Haidate",feet="Hermes' Sandals"}
	
    sets.idle.MasterDT = {
        head="Herculean Helm",neck="Twilight Torque",
        body="Hiza. Haramaki +2",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Incarnation Sash",legs={ name="Herculean Trousers", augments={'"Triple Atk."+4','STR+2','Attack+3',}},feet={ name="Herculean Boots", augments={'Attack+19','"Triple Atk."+4','Accuracy+10',}},
    }
    
    -------------------------------------Engaged
    sets.engaged.MasterAcc = {ammo="Automat. Oil +3",
        head="Hizamaru Somen +2",neck="Ej Necklace",ear2="Digni. Earring",ear1="Telos Earring",
        body="Hiza. Haramaki +2",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Eschan Stone",legs="Hiza. Hizayoroi +2",feet="Hiza. Sune-ate +1"
    }
    
    sets.engaged.MasterTP = {ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Niqmaddu Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Moonbow Belt",legs={ name="Herculean Trousers", augments={'"Triple Atk."+4','STR+2','Attack+3',}},feet={ name="Herculean Boots", augments={'Attack+19','"Triple Atk."+4','Accuracy+10',}},
    }
    
    sets.engaged.DT = {ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Tali'ah Manteel +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Incarnation Sash",legs={ name="Herculean Trousers", augments={'"Triple Atk."+4','STR+2','Attack+3',}},feet={ name="Herculean Boots", augments={'Attack+19','"Triple Atk."+4','Accuracy+10',}},
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

    sets.hybrid = {}
    -------------------------------------Acc
    sets.hybrid.MPAcc = {
        head = "Midras's Helm"
    }
    
    -------------------------------------TP
    sets.hybrid.MPTP = {
        body = "Poroggo Coat"
    }
    
    -------------------------------------DT
    sets.hybrid.MPDT = {
        body = "Councilor's Garb"
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
    --This section for sets pretaining to Pets

    sets.pet = {} -- Initilization Keep Empty

    -------------------------------------TP

    sets.pet.TP = {main="Ohtas",range="Animator P +1",ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Domes. Earring",
        body="Pitre Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Naga Kyahan"}

    -------------------------------------DT
    sets.idle.PetDT = {main="Midnights",range="Animator P +1",ammo="Automat. Oil +3",
        head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"
    }
    
    -------------------------------------Magic Midcast
    sets.midcast.Pet = {}
    
    sets.midcast.Pet.Cure = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",legs="Foire Churidars +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Elemental Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}

    sets.midcast.Pet['Enfeebling Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Dark Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Divine Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}
 
    sets.midcast.Pet['Enhancing Magic'] = {range="Animator P II",ear2="Enmerkar Earring",ear1="Burana Earring",back="Visucius's Mantle",head="Tali'ah Turban +1",body="Tali'ah Manteel +1",hands="Naga Tekko",legs="Tali'ah Sera. +1",feet="Tali'ah Crackows +1",waist="Ukko Sash",neck="Adad Amulet"}

    -------------------------------------Idle
    sets.idle.Pet = sets.idle

    sets.idle.PetRegen = {}

    -------------------------------------Enmity
    sets.pet.Enmity = {
		neck="Twilight Torque"
	}
    
    -------------------------------------Engaged
    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {}
    
    sets.idle.Pet.Engaged = {main="Ohtas",range="Animator P +1",ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Domes. Earring",
        body="Pitre Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Naga Kyahan"
		}


    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {legs = Empy_Karagoz.Legs_Combat})

    sets.idle.Pet.Engaged.Nuke =
        set_combine(sets.idle.Pet.Engaged, {main="Ohtas",range="Animator P II",
    legs="Tali'ah Sera. +1",feet="Naga Kyahan",hands="Naga Tekko",
    ear1="Burana Earring",ear2="Enmerkar Earring",back="Visucius's Mantle",
    waist="Incarnation Sash"})
    
    sets.idle.Pet.Engaged.Magic =
        set_combine(sets.idle.Pet.Engaged, {main="Ohtas",range="Animator P II",
    legs="Tali'ah Sera. +1",feet="Naga Kyahan",hands="Naga Tekko",
    ear1="Burana Earring",ear2="Enmerkar Earring",back="Visucius's Mantle",
    waist="Incarnation Sash"})
    

    sets.engaged.PetAcc = {
        head = Empy_Karagoz.Head_PTPBonus
    }

    sets.engaged.PetTP = {
        ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Domes. Earring",
        body="Pitre Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Incarnation Sash",legs="Tali'ah Sera. +1",feet="Naga Kyahan"
    }
    -------------------------------------WS
    sets.midcast.Pet.WeaponSkillNoAcc = {
        neck="Empath Necklace",head="Karagoz Capello",body="Tali'ah Manteel +1",hands="Karagoz Guanti",legs="Kara. Pantaloni +1",feet="Naga Kyahan",back="Dispersal Mantle",ear1="Burana Earring",ear2="Enmerkar Earring",waist="Incarnation Sash",ring1="Overbearing Ring",ring2="Varar Ring"
    }

    sets.midcast.Pet.WSNoFTP = {neck="Empath Necklace",head="Karagoz Capello",body="Tali'ah Manteel +1",hands="Karagoz Guanti",legs="Kara. Pantaloni +1",feet="Naga Kyahan",back="Dispersal Mantle",ear1="Burana Earring",ear2="Enmerkar Earring",waist="Incarnation Sash",ring1="Overbearing Ring",ring2="Varar Ring"
    }

    sets.midcast.Pet.WSFTP = {neck="Empath Necklace",head="Karagoz Capello",body="Tali'ah Manteel +1",hands="Karagoz Guanti",legs="Kara. Pantaloni +1",feet="Naga Kyahan",back="Dispersal Mantle",ear1="Burana Earring",ear2="Enmerkar Earring",waist="Incarnation Sash",ring1="Overbearing Ring",ring2="Varar Ring"
    }

    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSNoFTP
    sets.midcast.Pet.WS = {}
    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WeaponSkill, {})
    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WeaponSkill,
        {head = Empy_Karagoz.Head_PTPBonus, waist = "Incarnation Sash"}
    )
    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WeaponSkill, {})
    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WeaponSkill, {legs = ""})
    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(sets.midcast.Pet.WS["DEX"], {head = Empy_Karagoz.Head_PTPBonus, back = "Dispersal Mantle"})

    ---------------------------------------------
    --  __  __ _             _____      _       
    -- |  \/  (_)           / ____|    | |      
    -- | \  / |_ ___  ___  | (___   ___| |_ ___ 
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {main="Ohtas",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear2="Enmerkar Earring",ear1="Infused Earring",
        body="Hiza. Haramaki +2",hands="Rao Kote",ring1="Matrimony Ring",ring2="Defending Ring",
        back="Contriver's Cape",waist="Isa Belt",legs="Rao Haidate",feet="Hermes' Sandals"}

    -- Resting sets
    sets.resting = {head="Pitre Taj +1",neck="Sanctity Necklace",
        ring1="Chirich Ring",ring2="Chirich Ring",back="Contriver's Cape",ear1="Infused Earring",waist="Isa Belt",feet="Rao Sune-Ate",legs="Rao Haidate",hands="Rao Kote"}

    -- Defense sets
    sets.defense = {}

    sets.defense.MasterDT = {
        head="Herculean Helm",neck="Twilight Torque",
        body="Hiza. Haramaki +2",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Incarnation Sash",legs={ name="Herculean Trousers", augments={'"Triple Atk."+4','STR+2','Attack+3',}},feet={ name="Herculean Boots", augments={'Attack+19','"Triple Atk."+4','Accuracy+10',}},}

    
    sets.defense.PetDT = {main="Midnights",range="Animator P +1",ammo="Automat. Oil +3",
        head="Rao Kabuto",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Rao Togi",hands="Rao Kote",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Rao Sune-Ate"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'DNC' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
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
        textinbox = textinbox..textColor..'Last State : '..tostring(lastStateActivated)..textColorNewLine
        
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

    if state.PetModeCycle.current == const_dd then
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
    elseif state.PetModeCycle.current == const_tank then
        if Pet_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_tank
        end
    elseif state.PetModeCycle.current == const_mage then
        if Master_State == const_stateIdle then
            Hybrid_State = const_stateIdle
        else
            Hybrid_State = const_masterOnly
        end
    end
end

--Determines Gear based on that Hybrid Set
function determineGearSet()

    if Hybrid_State == const_tank then
        equip(sets.idle.PetDT)
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
    state.AutoMan:reset()
    Current_Maneuver = 0
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
        equip(sets.pet.TP)
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
        Master_State= const_stateIdle
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
        determineGearSet()
    else
        Pet_State = const_stateIdle
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Pet Idle ] *-*-*-*-*-*-*-*-*')
        determineGearSet()
    end
    
    determineGearSet()
	
	send_command('gs c update')
end
 
function job_pet_aftercast(spell)
	determineGearSet()
	send_command('gs c update')
end

--Anytime you change equipment you need to set eventArgs.handled or else you may get overwritten
function job_buff_change(status,gain_or_loss, eventArgs)
    
    if status == "sleep" and gain_or_loss then        
        equip(set_combine(sets.defense.PDT, {neck="Opo-opo Necklace"}))
        eventArgs.handled = true
    elseif status == 'doom' and gain_or_loss then
        send_command("/p I have befallen to ~~~DOOM~~~ may my end not come to quickly.")
    elseif status == 'doom' and gain_or_loss == false then
        send_command("/p I have avoided the grips of ~~~DOOM~~~ may Altana be praised! ")
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
            send_command('input /ja "'..status..'" <me>')
        end
    end

    if status == const_stateOverdrive then
        if gain_or_loss then
            OverPower = true
            OverCount = 1
            equip(sets.midcast.Pet.WSFTP)
            eventArgs.handled = true
        else
            OverPower = false
            OverCount = 0
            equip(sets.midcast.Pet.WSNoFTP)
            eventArgs.handled = true
        end
    end
   
end
 
-- Toggles -- SE Macros: /console gs c "command" [case sensitive]
function job_self_command(command, eventArgs)
    
    if command[1]:lower() == 'automan' then
        state.AutoMan:toggle()
        refreshWindow()
    elseif command[1]:lower() == 'debug' then
        d_mode = not d_mode
        refreshWindow()
    elseif command[1]:lower() == 'predict' then
        determinePuppetType()
        refreshWindow()
    end

end

windower.register_event('prerender', function()

    --Items we want to check every second
    if os.time() > time_start then
        time_start = os.time()

        if pet.isvalid then
            --Only want to equip TP set in the event of the player not having enough.
            --Otherwise this is handled when player has more TP in aftercast
            if pet.tp >= 1000 and Pet_State == "Engaged" then
                equip(sets.midcast.Pet.WeaponSkill)
            end
        end
        
        if state.PetModeCycle.current == const_tank and Pet_State == const_stateEngaged then
            if buffactive['Fire Maneuver'] and pet.attachments.strobe == true then
                if Strobe_Recast <= 2 then
                    equip(sets.pet.Enmity)
                end
            end
            
            if buffactive['Light Maneuver'] and pet.attachments.flashbulb == true then
                if Flashbulb_Recast <= 2 then
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
--handle_update is always called when a job state is changed
--Best to adjust gear in job_handle_update which is an override for the job file
lastStateActivated = ''
function job_state_change(stateField, newValue, oldValue)
    local fullGearSlots = {'main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring', 'ear1', 'ear2','back','waist','legs','feet'}    

    lastStateActivated = stateField

    if stateField == const_PetModeCycle then
        if newValue == const_tank then
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif newValue == const_dd then
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif newValue == const_mage then
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            msg("No Style found for: "..newValue)
        end

        determineGearSet()
        refreshWindow()
    elseif stateField == const_PetStyleCycle then
        refreshWindow()
    elseif stateField == 'Auto Maneuver' then
        refreshWindow()
    elseif stateField == 'Lock Pet DT' then
    --This command overrides everything and blocks all gear changes
    --Will lock until turned off or Pet is disengaged
        if newValue == true then
            equip(sets.idle.PetDT)
            disable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
        else
            enable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
        end
        refreshWindow()
    end

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    if state.PetModeCycle.value ~= 'None' then
        msg = msg..'Pet Mode: ('..state.PetModeCycle.value..')'
    end

    if state.PetStyleCycle.value ~= 'None' then
        msg = msg..', Pet Style: ('..state.PetStyleCycle.value..")"
    end

    add_to_chat(122, msg)
end

function sub_job_change(new,old)
    determinePuppetType()
end

--Anytime equipment is changed this is called
function job_handle_equipping_gear(playerStatus, eventArgs)
    local backsToLock = S{'Mecisto. Mantle', 'Aptitude Mantle', 'Aptitude Mantle +1'}
    local ringsToLock = S{'Warp Ring', 'Dim. Ring (Dem)', 'Dim. Ring (Holla)', 'Dim. Ring (Mea)'}

    --Checks against a list of possible items we want to lock for certain spots
    if backsToLock:contains(player.equipment.back) then
        disable('back')
    else
        enable('back')
    end
    
    if ringsToLock:contains(player.equipment.right_ring) then
        disable('rring')
    else
        enable('rring')
    end
    
    if ringsToLock:contains(player.equipment.left_ring) then
        disable('lring')
    else
        enable('lring')
    end

end

windower.raw_register_event('zone change', reset_timers)
