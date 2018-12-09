--Created By: Faloun
--Modified By: Arrchie
--Contributions From: Kuroganashi, Xilkk
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
    select_default_macro_book()
    --Predict Puppet on initial Load
    --Then attempt to Set the Pet Mode Cycle
    --Then attempt to Set the Pet Style Cycle
    state.PetStyleCycleTank = M{"NORMAL", "DD", "PDT", "MDT", "RANGE"}
    state.PetStyleCycleMage = M{"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M{"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    state.PetModeCycle = M{"TANK", "DD", "MAGE"}
    state.PetStyleCycle = state.PetStyleCycleTank

    ActualMode = state.PetModeCycle.value
    ActualSubMode = state.PetStyleCycle.value
 
    state.AutoMan = M(false, "Auto Maneuver")
    state.LockPetDT = M(false, "Lock Pet DT")

    send_command('bind !f7 gs c cycle PetModeCycle')
    send_command('bind ^f7 gs c cycleback PetModeCycle')
    send_command('bind !f8 gs c cycle PetStyleCycle')
    send_command('bind ^f8 gs c cycleback PetStyleCycle')
    send_command('bind !e gs c toggle AutoMan')
    send_command('bind !d gs c toggle LockPetDT')

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
    -- Attempts to figure what puppet you may have equipped
    -- determinePuppetType()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window 
    setupTextWindow(1400, 600)
end

function init_gear_sets()

    AF_Head = "Foire Taj +1"
    AF_Body = "Foire Tobe"
    AF_Hands = "Foire Dastanas"
    AF_Legs = "Foire Churidars +1"
    AF_Feet = "Foire Babouches"

    Relic_Head = "Pitre Taj +1"
    Relic_Body = "Pitre Tobe"
    Relic_Hands = "Pitre Dastanas"
    Relic_Legs = ""
    Relic_Feet = ""

    Empy_Head = "Karagoz Capello"
    Empy_Body = "Karagoz Farsetto"
    Empy_Hands = "Cirque Guanti +1"
    Empy_Legs = "Cirq. Pantaloni +1"
    Empy_Feet = ""

    Visucius = {}
    Visucius.DT = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+4 Pet: Rng. Acc.+4",
            'Pet: "Regen"+10',
            "Pet: Damage taken -5%"
        }
    }

    HercHeadSTR = {
        name = "Herculean Helm",
        augments = {"Accuracy+28", "Weapon skill damage +4%", "STR+11", "Attack+13"}
    }
    HercHeadPDT = {name = "Herculean Helm", augments = {"CHR+7", "Accuracy+29", "Phys. dmg. taken -4%"}}
    HercHeadMAB = {
        name = "Herculean Helm",
        augments = {'Mag. Acc.+20 "Mag.Atk.Bns."+20', "Phys. dmg. taken -2%", '"Mag.Atk.Bns."+15'}
    }
    HercBootMAB = {
        name = "Herculean Boots",
        augments = {
            'Mag. Acc.+18 "Mag.Atk.Bns."+18',
            "Magic burst mdg.+4%",
            "MND+2",
            "Mag. Acc.+10",
            '"Mag.Atk.Bns."+14'
        }
    }
    HercBootAcc = {
        name = "Herculean Boots",
        augments = {"MND+9", "Pet: STR+8", '"Treasure Hunter"+2', "Accuracy+18 Attack+18"}
    }
    HercBootDEX = {name = "Herculean Boots", augments = {"Attack+18", '"Triple Atk."+3', "DEX+10"}}

    --- DT
    HercLegsPDT = {name = "Herculean Trousers", augments = {"Damage taken-3%", "Attack+3"}}
    HercGlovesPDT = {name = "Herculean Gloves", augments = {"Phys. dmg. taken -5%", "Accuracy+2"}}
    HercBootsPDT = {name = "Herculean Boots", augments = {"Damage taken-2%", "STR+9", "Attack+7"}}

    HercBootBone = {
        name = "Herculean Boots",
        augments = {"Pet: Accuracy+5 Pet: Rng. Acc.+5", 'Pet: "Dbl.Atk."+2 Pet: Crit.hit rate +2', "Pet: VIT+5"}
    }

    HercLegsPET = {
        name = "Herculean Trousers",
        augments = {"Pet: Attack+21 Pet: Rng.Atk.+21", 'Pet: "Store TP"+10', "Pet: VIT+7"}
    }
    HercLegsPetDEX = {
        name = "Herculean Trousers",
        augments = {"Pet: Attack+10 Pet: Rng.Atk.+10", "Pet: DEX+10", 'Pet: "Mag.Atk.Bns."+3'}
    }

    JSECAPEPetHaste = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Haste+10",
            "System: 1 ID: 1247 Val: 2"
        }
    }
    JSECAPESTR = {
        name = "Visucius's Mantle",
        augments = {"STR+20", "Accuracy+20 Attack+20", "STR+5", "Crit.hit rate+10"}
    }

    -- RAO WS
    RAOWShead = {name = "Rao Kabuto", augments = {"STR+10", "DEX+10", "Attack+15"}}
    RAOWShands = {name = "Rao Kote", augments = {"Accuracy+10", "Attack+10", "Evasion+15"}}
    RAOWSlegs = {name = "Rao Haidate", augments = {"Accuracy+20", '"Dbl.Atk."+3', "Pet: Accuracy+20"}}
    RAOWSfeet = {name = "Rao Sune-Ate", augments = {"Accuracy+10", "Attack+10", "Evasion+15"}}

    sets.precast = {}

    -- Precast Sets

    -- Fast cast sets for spells
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

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})

    sets.precast.JA = {}
    -- Precast sets to enhance JAs
    sets.precast.JA["Tactical Switch"] = {feet = Empy_Feet}
    sets.precast.JA["Ventriloquy"] = {legs = Relic_Legs}
    sets.precast.JA["Role Reversal"] = {feet = Relic_Feet}
    sets.precast.JA["Overdrive"] = {feet = Relic_Body}

    sets.precast.JA["Repair"] = {feet = "Foire Babouches", "Guignol Earring"}

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar +1",
        body = Empy_Body,
        hands = AF_Hands,
        back = Visucius.DT,
        ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}
    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
        feet = "Ahosi Leggings",
        neck = "Unmoving Collar",
        feet = "Rager Ledel. +1",
        hands = "Kurys Gloves",
        ring1 = "Provocare Ring"
    }

    -- Waltz set (chr and vit)
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

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz["Healing Waltz"] = {}

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

    -- Midcast Sets
    sets.midcast = {}
    sets.midcast.FastRecast = {
        head = "Haruspex Hat",
        ear2 = "Loquacious Earring",
        body = "Otronif Harness +1",
        hands = "Regimen Mittens",
        legs = "Manibozho Brais",
        feet = "Otronif Boots +1"
    }

    -- Midcast sets for pet actions
    sets.midcast.Pet = {}
    sets.midcast.Pet.Cure = {legs = AF_Legs}

    sets.midcast.Pet["Elemental Magic"] = {
        feet = "Naga Kyahan",
        ear1 = "Burana Earring",
        ear2 = "Cirque Earring",
        legs = Relic_Legs
    }

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

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        head = Relic_Head,
        neck = "Wiglen Gorget",
        ring1 = "Sheltered Ring",
        ring2 = "Paguroidea Ring"
    }

    -- Idle sets

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

    sets.idle.Town = sets.idle

    ------------------------------------------------------------------ PET SETS
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

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

    sets.petTank = {
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

    sets.petEnmity = {
        head = "Heyoka Cap",
        body = "Heyoka Harness",
        hands = "Heyoka Mittens",
        legs = "Heyoka Subligar",
        feet = "Heyoka Leggings",
        ear1 = "Domesticator's Earring"
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

    sets.Kiting = {feet = "Hermes' Sandals"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.aftercast = sets.idle

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
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end
 
------------------------------------------------------------------------------------------------------------------------
--------------------------------- DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING ---------------------------------
------------------------------------------------------------------------------------------------------------------------

-------------------------------
--------Global Variables-------
-------------------------------
Current_Maneuver = 0
Auto_Maneuver = false
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
pdt = 0

d_mode = false

visible = true

time_start = os.time()

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

--Used to calculate the Hybrid State of you and your pet
function TotalSCalc()
    if ActualMode == "DD" then
        if buffactive['Overdrive'] then
            Hybrid_State = "Overdrive"
        elseif Master_State == "Idle" and Pet_State == "Idle" then
            Hybrid_State = "Idle"
        elseif Master_State == "Idle" and Pet_State == "Engaged" then
            Hybrid_State = "Pet Only"
        elseif Master_State == "Engaged" and Pet_State == "Engaged" then
            Hybrid_State = "Pet+Master"
        elseif Master_State == "Engaged" and Pet_State == "Idle" then
            Hybrid_State = "Master Only"
        end
    elseif ActualMode == "TANK" then
        if Pet_State == "Idle" then
            Hybrid_State = "Idle"
        else
            Hybrid_State = "Tank"
        end
    else
        Pet_State = "MAGE"
        if Master_State == "Idle" then
            Hybrid_State = "Idle"
        else
            Hybrid_State = "Master Only"
        end
    end
end

--Determines Gear based on that Hybrid Set
function determineGearSet()
    if ActualMode == "TANK" then
        equip(sets.petTank)
    elseif Hybrid_State == "Idle" then
        equip(sets.idle)
    elseif Hybrid_State == "Master Only" then
        equip(sets.engagedMO)
    elseif Hybrid_State == "Pet Only" then
        equip(sets.idle.Pet.EngagedO)
    elseif Hybrid_State == "Pet+Master" then
        equip(sets.engagedN)
    elseif Hybrid_State == "Overdrive" then
        equip(sets.engaged)
    else
        handle_equipping_gear(player.status)
    end

end

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
    textinbox = textinbox..textColor..'Pet Mode : '..ActualMode..textColorNewLine
    textinbox = textinbox..textColor..'Pet Style : '..ActualSubMode..textColorNewLine
    
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
        textinbox = textinbox..textColor..'Strobe Attached : '..tostring(pet.attachments.strobe)..textColorNewLine
        textinbox = textinbox..textColor..'Flashbulb Attached : '..tostring(pet.attachments.Flashbulb)..textColorNewLine
    end

    windower.text.set_text(tb_name, textinbox)
end

--This handles drawing the Pet Infor for the Text Box
function drawPetInfo()
    textinbox = textinbox..drawTitle('Pet Info')
    textinbox = textinbox..'- \\cs(0, 0, 125)HP : '..pet.hp..'/'..pet.max_hp..textColorNewLine
    textinbox = textinbox..'- \\cs(0, 125, 0)MP : '..pet.mp..'/'..pet.max_mp..textColorNewLine
    textinbox = textinbox..'- \\cs(255, 0, 0)TP : '..tostring(pet.tp)..textColorNewLine
end

--This handles drawing the Pet Skills for the text box
function drawPetSkills()
    --- Recast for enmity gears
    if ActualMode == "TANK" then
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
 
--- Pet modes references
PetMode = S{"TANK", "DD", "MAGE"}
PetSubMode = {}
PetSubMode["TANK"] = S{"NORMAL", "DD", "PDT", "MDT", "RANGE"}
PetSubMode["DD"] = S{"NORMAL", "BONE", "SPAM", "OD", "ODACC"}
PetSubMode["MAGE"] = S{"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
NSubMode = {}
NSubMode["Tank"] = 3
NSubMode["DD"] = 5

--- Styles Maneuvers and autocontrol
Style={}
-- Tank Ones
Style["PDT"] = {"paladin", "Light", "Fire", "Earth"}
Style["MDT"] = {"runefencer", "Light", "Fire", "Water"}
Style["Range"] = {"Paladin", "Light", "Fire", "Earth"}
-- DD Ones
Style["Normal"] = {"dd", "Light", "Fire", "Wind"}
Style["Bone"] = {"boneslayer", "Light", "Fire", "Wind"}
Style["Spam"] = {"ddspam", "Light", "Fire", "Wind"}
Style["OD"] = {"overdrive", "Light", "Fire", "Thunder"}
Style["ODAcc"] = {"overdriveacc", "Light", "Fire", "Thunder"}


function table.contains(table, element)
    for _, value in pairs(table) do
      if string.lower(value) == element then
        return true
      end
    end
    return false  
end

function round(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end

local srep = string.rep

-- pad on both sides (centering with left justification)
function pad(s, l, c)
	c = c or ' '

    local res1 = srep(c, l) .. s -- pad to half-length + the length of s
    local res2 = res1 .. srep(c,  l) -- right-pad our left-padded string to the full length

    return res2
end

function ternary(cond , T , F)
    if cond then 
        return T 
    else 
        return F 
    end
end

--Attempts to determine the puppet type being used for Pet Mode
function determinePuppetType()
    local head = pet.head
    local frame = pet.frame

    ValHead = "Valoredge Head"
    ValFrame = "Valoredge Frame"

    HarHead = "Harlequin Head"
    HarFrame = "Harlequin Frame"

    SharpHead = "Sharpshoot Head"
    SharpFrame = "Sharpshoot Frame"

    StormHead = "Stormwaker Head"
    StormFrame = "Stormwaker Frame"

    SoulHead = "Soulsoother Head"
    SpiritHead = "Spiritreaver Head"

    --This is based mostly off of the frames from String Theory
    --https://www.bg-wiki.com/bg/String_Theory#Automaton_Frame_Setups

    if head == HarHead then
        if frame == HarFrame then
            ActualMode = "TANK"
            ActualSubMode = "MDT"
        else
            ActualMode = 'DD'
            ActualSubMode = 'NORMAL'
        end
    elseif head == SoulHead and frame == ValFrame then --Turle Tank (Default)
        ActualMode = "TANK"
        ActualSubMode = "PDT"
    elseif head == ValHead and frame == SharpFrame and pet.attachments.strobe == true then
        ActualMode = 'TANK'
        ActualSubMode = 'PDT'
    elseif head == ValHead and frame == SharpFrame then --DD (Default)
        ActualMode = "DD"
        ActualSubMode = "NORMAL"
    elseif head == ValHead and frame == ValFrame then -- Bone Slayer
        ActualMode = "DD"
        ActualSubMode = "BONE"
    elseif head == SharpHead and frame == SharpFrame then --Spam DD
        ActualMode = "DD"
        ActualSubMode = "SPAM"
    elseif head == SoulHead and frame == StormFrame then --WHM
        ActualMode = "MAGE"
        ActualSubMode = "HEAL"
    elseif head == StormHead and frame == StormFrame then --RDM
        ActualMode = "MAGE"
        ActualSubMode = "SUPPORT"
    elseif head == SpiritHead and frame == StormFrame then --BLM
        ActualMode = "MAGE"
        ActualSubMode = "DD"
    end

end

--Various Timers that get reset when you zone
function reset_timers()
    Current_Maneuver = 0
    state.AutoMan.value = false
    refreshWindow()
end

------------------------------------
----------Windower Hooks------------
------------------------------------

--Auto Boost on Certain WS
function job_precast(spell,action)

    if spell.english == "Deploy" and pet.tp >= 950 then
        if ActualMode == "TANK" then
            -- Nothing
        else
            equip(sets.midcast.Pet.WeaponSkill)
        end
    elseif string.find(spell.english,'Maneuver') then
        equip(sets.precast.JA.Maneuver)

    elseif sets.precast.JA[spell.english] then
        equip(sets.precast.JA[spell.english])

    elseif sets.precast.WS[spell.english] then
        equip(sets.precast.WS[spell.english])

        if Hybrid_State == "Pet+Master" then
            sets.aftercast = sets.midcast.Pet.WeaponSkill
        end
    else
        equip(sets.precast.FC)
    end
end
 
function job_midcast(spell,action)
end
 
function job_aftercast(spell,action)
    enable("ear1")
    
    if spell.name == null then
        return -- Cancel Aftercast for out of range/unable to see.
    end
   
    if (spell.english == "Shijin Spiral" or spell.english == "Victory Smite" or spell.english == "Stringing Pummel" or spell.english == "Howling Fist") and pet.tp >= 850 then
        ws = SC[pet.frame][spell.english]
        modif = Modifier[ws]
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ '..pet.name..' is about to '..ws..' ('..modif..') ] *-*-*-*-*-*-*-*-*')
        equip(sets.midcast.Pet.WS[modif])
    else
        if sets.precast.WS[spell.english] and Hybrid_State == "Pet+Master" then
            equip(sets.aftercast)
        else
            determineGearSet()
        end
    end
   
end
 
function job_status_change(new,old)
    if new == 'Engaged' then
        Master_State = "Engaged"
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Engaged ] *-*-*-*-*-*-*-*-*')
    else
        Master_State="Idle"
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ Idle ] *-*-*-*-*-*-*-*-*')
    end
    
    determineGearSet()
   
end
 
function job_pet_status_change(new,old)
    if new == 'Engaged' then
        Pet_State = "Engaged"
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ PetEngaged ] *-*-*-*-*-*-*-*-*')
    else
        Pet_State="Idle"
        TotalSCalc()
        add_to_chat(392,'*-*-*-*-*-*-*-*-* [ PetIdle ] *-*-*-*-*-*-*-*-*')
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

    if status == "Overdrive" then
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

windower.raw_register_event('zone change', reset_timers)
 
-- Toggles -- SE Macros: /console gs c "command" [case sensitive]
function job_self_command(command, eventArgs)

    if type(command) == 'table' then --We have a multiple inputs
        if command[1]:upper() == "MODE" then
            if PetMode[command[2]:upper()] then
                msg("Changing Mode To: "..command[2]:upper())
                ActualMode = command[2]:upper()

                if command[2]:upper() == 'TANK' then
                    if PetSubMode["TANK"][command[3]:upper()] then
                        ActualSubMode = command[3]:upper()
                    else
                        ActualSubMode = "NORMAL"
                    end

                    msg("Changing Pet Style To "..ActualSubMode)
                elseif command[2]:upper() == 'MAGE' then
                    if PetSubMode["MAGE"][command[3]:upper()] then
                        ActualSubMode = command[3]:upper()
                    else
                        ActualSubMode = "NORMAL"
                    end

                    msg("Changing Pet Style To "..ActualSubMode)
                elseif command[2]:upper() == 'DD' then
                    if PetSubMode["DD"][command[3]:upper()] then
                        ActualSubMode = command[3]:upper()
                    else
                        ActualSubMode = "NORMAL"
                    end

                    msg("Changing Pet Style To "..ActualSubMode)
                else
                    msg("Unable to determine Pet Style: "..command[3]:upper())
                end

            else
                msg("Unable to determine Pet Mode: ".. command[2]:upper())
            end
        end
        
        refreshWindow()
    end
    
    if command[1]:upper() == 'AUTOMAN' then
        state.AutoMan.value = not state.AutoMan.value
        refreshWindow()
    elseif command[1]:upper() == 'DEBUG' then
        d_mode = not d_mode
        refreshWindow()
    elseif command[1]:upper() == 'PREDICT' then
        determinePuppetType()
        refreshWindow()
    end

end

windower.register_event('prerender', function()

    --Items we want to check every second
    --TODO Further Testing
    if os.time() > time_start then
        time_start = os.time()

        if ActualMode == "TANK" and Pet_State == 'Engaged' then
            if buffactive['Fire Maneuver'] and pet.attachments.strobe then
                if Strobe_Recast == 0 then
                    equip(sets.petEnmity)
                end
            end

            if buffactive['Light Maneuver'] and pet.attachments.flashbulb then
                if Flashbulb_Recast == 0 then
                    equip(sets.petEnmity)
                end
            end
        end

        if Strobe_Recast > 0 then
            Strobe_Recast = Strobe_Timer -(os.time() - Strobe_Time)
        end
       
        if Flashbulb_Recast > 0 then
            Flashbulb_Recast = Flashbulb_Timer -(os.time() - Flashbulb_Time)
        end

        if state.PetModeCycle.value == "TANK" then
            -- Nothing
        elseif Hybrid_State == "Pet Only" or Hybrid_State == "Overdrive" then
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
 
RWSTrigger = S{"Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
MWSTrigger = S{"Slapstick", "Knockout", "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder"}
HPWSTrigger = S{"Magic Mortar"}
wscount=0
--- Delve Assistant
windower.register_event('incoming text', function(original, modified, mode)
    local match

        -- OVERDRIVE OPTIMIZER
            if buffactive["Overdrive"] then
                match = original:match(pet.name..' readies ([%s%w]+)%.')
                if match=="Daze" then
                    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSFTP
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 2
                elseif match=="Arcuballista" then
                    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSNoFTP
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 3
                elseif match=="Armor Shatterer" then
                    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSNoFTP
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 4
                elseif match=="Armor Piercer" then
                    sets.midcast.Pet.WeaponSkill = sets.midcast.Pet.WSFTP
                    add_to_chat(204, '*-*-*-*-*-*-*-*-* [ '..match..' done ] *-*-*-*-*-*-*-*-*')
                    refreshWindow()
                    OverCount = 1
                end
            end
            -- Checking timer for enmity sets
            if ActualMode == "TANK" then
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
            end
       
    return modified, mode
end)

--Passes state changes for cycle commands
function job_state_change(stateField, newValue, oldValue)

    if stateField == 'PetModeCycle' then
        ActualMode = newValue
        
        if ActualMode == 'TANK' then
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif ActualMode == 'DD' then
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif ActualMode == 'MAGE' then
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            msg("No Style found for: "..ActualMode..' Mode setting to default DD Mode')
            state.PetStyleCycle = state.PetStyleCycleDD
        end

        ActualSubMode = state.PetStyleCycle.value
        refreshWindow()
    elseif stateField == 'PetStyleCycle' then
        ActualSubMode = newValue
        refreshWindow()
    elseif stateField == 'Auto Maneuver' then
        refreshWindow()
    elseif stateField == 'Lock Pet DT' then
        --If true the lock gearswap
        if newValue == true then
            equip(sets.petTank)
            disable({'main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring', 'ear1', 'ear2','back','waist','legs','feet'})
        else
            enable({'main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring', 'ear1', 'ear2','back','waist','legs','feet'})
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