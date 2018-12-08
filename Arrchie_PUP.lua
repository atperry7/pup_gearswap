--Created By: Faloun
--Modified By: Arrchie

include('organizer-lib')
 
local player = windower.ffxi.get_player()

--
--Auto Maneuvers:
--//gs c automan
 
--Currently, the way this works is it will simply recast the maneuver that wears off. This way you can cast any maneuvers you want and it will simply attempt to maintain what you have active.
 
--Predict:
--//gs c predict
 
--This will attempt to determine the currently equipped puppet and adjust the Pet Mode and Pet Style.
 
--Pet Mode:
--//gs c mode tank pdt
 
--This will change the mode of the pet and the style of the pet.
--Current Modes: TANK, DD, Mage
--Current Styles:
--- Tank: Normal, PDT, MDT, RANGE
--- DD: Normal, Bone, Spam, OD, ODACC
--- Mage: Normal, Heal, Support, MB, DD
 
    --F9
    send_command('bind f9 gs c mode dd normal')
    --CTRL + F9
    send_command('bind ^f9 gs c mode dd bone')
    --ALT + F9
    send_command('bind !f9 gs c mode dd spam')
 
    --F10
    send_command('bind f10 gs c mode tank normal')
    --CTRL + F10
    send_command('bind ^f10 gs c mode tank pdt')
    --ALT + F10
    send_command('bind !f10 gs c mode tank range')
    --Windows + F10
    send_command('bind @f10 gs c mode tank mdt')
 
    --F11
    send_command('bind f11 gs c mode mage normal')
    --CTRL + F11   
    send_command('bind ^f11 gs c mode mage Heal')
    --ALT + F11
    send_command('bind !f11 gs c mode mage Support')
    --Windows + F11
    send_command('bind @f11 gs c mode mage mb')
   
    --F12
    send_command('bind f12 gs c mode dd od')
    --CTRL + F12
    send_command('bind ^f12 gs c mode dd odacc')
    --ALT + F12
    send_command('bind !f12 gs c mode mage dd')
 
 
  function user_unload()
    send_command('unbind ^f9')
    send_command('unbind !f9')
    send_command('unbind @f9')
    send_command('unbind ^f10')
    send_command('unbind !f10')
    send_command('unbind @f10')
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f11')
    send_command('unbind ^f12')
    send_command('unbind !f12')
    send_command('unbind @f12')
end

function get_sets()
    user_setup()

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
    Empy_Body = "Cirque Farsetto +1"
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
        ring2 = "Varar Ring",
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
        feet = "Tali'ah Crackows +2"
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

function user_setup()
    set_macros(1, 1) --First Value is Sheet and second is Book
    determinePuppetType()
    setupTextWindow()
end

function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
    else
        send_command('@input /macro set '..tostring(sheet))
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

Pos_X = 1400
Pos_Y = 600

d_mode = false

visible = true

time_start = os.time()

--Default To Set Up the Text Window
function setupTextWindow()
    tb_name = "pup_gs_helper"
    bg_visible = true
    textinbox = ' '

    windower.text.create(tb_name)
    -- table_name, x, y
    windower.text.set_location(tb_name, Pos_X, Pos_Y)
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
        sets.aftercast = sets.petTank
    elseif Hybrid_State == "Idle" then
        sets.aftercast = sets.idle
    elseif Hybrid_State == "Master Only" then
        sets.aftercast = sets.engagedMO
    elseif Hybrid_State == "Pet Only" then
        sets.aftercast = sets.engaged
    elseif Hybrid_State == "Pet+Master" then
        sets.aftercast = sets.engagedN
    elseif Hybrid_State == "Overdrive" then
        sets.aftercast = sets.engaged
    end

    equip(sets.aftercast)
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
    textinbox = textinbox..textColor..'Auto Maneuver : '..ternary(Auto_Maneuver, 'ON', 'OFF')..textColorNewLine

    --Debug Variables that are used for testing
    if d_mode then
        textinbox = textinbox..drawTitle("DEBUG")
        textinbox = textinbox..textColor..'Current Maneuvers : '..Current_Maneuver..textColorNewLine
        textinbox = textinbox..textColor..'Strobe Attached : '..tostring(pet.attachments.strobe)..textColorNewLine
        textinbox = textinbox..textColor..'Flashbulb Attached : '..tostring(pet.attachments.Flashbulb)..textColorNewLine
    end

    windower.text.set_text(tb_name, textinbox)
end

function drawPetInfo()
    textinbox = textinbox..drawTitle('Pet Info')
    textinbox = textinbox..'- \\cs(0, 0, 125)HP : '..pet.hp..'/'..pet.max_hp..textColorNewLine
    textinbox = textinbox..'- \\cs(0, 125, 0)MP : '..pet.mp..'/'..pet.max_mp..textColorNewLine
    textinbox = textinbox..'- \\cs(255, 0, 0)TP : '..tostring(pet.tp)..textColorNewLine
end

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

--Used from Spicyryans BLU Gearswap
-----------------------------
--      Spell control      --
-----------------------------
unusable_buff = {
	spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
 --return true if spell/ability is unable to be used at this time
function spell_control(spell)
	if spell.type == "Item" then
		return false
	--Stops spell if you do not have a target
	elseif spell.target.name == nil and not spell.target.raw:contains("st") then
		return true
	--Stops spell if a blocking buff is active
	elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
		return true
	elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
		return true
	elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
		msg("Weapon Skill Canceled, Can't")
		return true
	elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell)
      or not check_recast('spell',spell.recast_id)) then
		return true
    --Stops spell if you do not have enuf mp/tp to use
	elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) then
        msg("Spell Canceled, Not Enough MP")
		return true
	end
    --Calculate how many finishing moves your char has up to 6
	local fm_count = 0
	for i, v in pairs(buffactive) do
		if tostring(i):startswith('finishing move') or tostring(i):startswith('?????????') then
			fm_count = tonumber(string.match(i, '%d+')) or 1
		end
	end
    --Stops flourishes if you do not have enough finishing moves
	local min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
                                   ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
	if min_fm_for_flourishes[spell.en] then
		if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
			return true
		end
	end
	--Reomves Sneak when casting Spectral Jig
	if spell.en == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
		return true
	end
	if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
		msg("Weapon Skill Canceled  Target Out of Range")
		return true
	end
end

function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then return true end
    end
end

function msg(str)
    send_command('@input /echo *-*-*-*-*-*-*-*-* ' .. str .. ' *-*-*-*-*-*-*-*-*')
end

------------------------------------
----------Utility Functions---------
------------------------------------

Attach = {}

NA=0
NAttach = {}
NAttach["Light"] = 14
NAttach["Fire"] = 15
NAttach["Wind"] = 14

MAN = {"Light", "Fire", "Wind"}

--Light Attachments
Attach["Light"] = {"Arcanic Cell", "Arcanic Cell II", "Auto-Repair Kit", "Auto-Repair Kit II", "Auto-Repair Kit III", "Auto-Repair Kit IV", "Damage Gauge", "Damage Gauge II", "Eraser", "Flashbulb", "Optic Fiber", "Optic Fiber II", "Vivi-Valve", "Vivi-Valve II"}
Attach["Light"]["Arcanic Cell"] = {"Occult Acumen", 10, 20, 35, 50, "Int"}
Attach["Light"]["Arcanic Cell II"] = {"Occult Acumen", 20, 40, 70, 100, "Int"}
Attach["Light"]["Auto-Repair Kit"] = {"Regen", 0, 0.00125, 0.00225, 0.00375, "%"}
Attach["Light"]["Auto-Repair Kit"].Special = {"Regen", 0, 1, 2, 3, "Int"}
Attach["Light"]["Auto-Repair Kit II"] = {"Regen", 0, 0.006, 0.012, 0.018, "%"}
Attach["Light"]["Auto-Repair Kit II"].Special = {"Regen", 0, 3, 6, 9, "Int"}
Attach["Light"]["Auto-Repair Kit III"] = {"Regen", 0, 0.018, 0.024, 0.03, "%"}
Attach["Light"]["Auto-Repair Kit III"].Special = {"Regen", 0, 9, 12, 15, "Int"}
Attach["Light"]["Auto-Repair Kit II"] = {"Regen", 0, 0.03, 0.036, 0.042, "%"}
Attach["Light"]["Auto-Repair Kit II"].Special = {"Regen", 0, 15, 18, 21, "Int"}
Attach["Light"]["Damage Gauge"] = {"Inknown", 0, 0, 0, 0, "%"}
Attach["Light"]["Damage Gauge II"] = {"Inknown", 0, 0, 0, 0, "%"}
Attach["Light"]["Eraser"] = {"Erase", 0, 1, 2, 3, "Int"}
Attach["Light"]["Flashbulb"] = {"Flash", "No effect", "Activable", "Activable", "Activable", "String"}
Attach["Light"]["Optic Fiber"] = {"Awesomeness", 0.1, 0.2, 0.25, 0.30, "%"}
Attach["Light"]["Optic Fiber II"] = {"Awesomeness", 0.15, 0.3, 0.375, 0.45, "%"}
Attach["Light"]["Vivivalve"] = {"Cure Pot", 0.05, 0.15, 0.3, 0.45, "%"}
Attach["Light"]["Vivivalve II"] = {"Cure Pot", 0.10, 0.20, 0.35, 0.50, "%"}

-- Fire Attachments
Attach["Fire"] = {"Attuner", "Flame Holder", "Heat Capacitor", "Heat Capacitor II", "Inhibitor", "Inhibitor II", "Reactive Shield", "Speedloader", "Speedloader II", "Strobe", "Strobe II", "Tension Spring", "Tension Spring II", "Tension Spring III", "Tension Spring IV"}
Attach["Fire"]["Attuner"] = {"Def Ignored", 0.05, 0.15, 0.3, 0.45, "%"}
Attach["Fire"]["Flame Holder"] = {"TP Bonus", 0.25, 1, 1.75, 2.5, "%"}
Attach["Fire"]["Heat Capacitor"] = {"Restore TP", 0, 400, 800, 1200, "Int"}
Attach["Fire"]["Heat Capacitor II"] = {"Restore TP", 0, 600, 1200, 1800, "Int"}
Attach["Fire"]["Inhibitor"] = {"Store TP", 5, 15, 25, 40, "Int"}
Attach["Fire"]["Inhibitor II"] = {"Store TP", 10, 25, 40, 65, "Int"}
Attach["Fire"]["Reactive Shield"] = {"Blaze Spike", "No effect", "Activable", "Activable", "Activable", "String"}
Attach["Fire"]["Speedloader"] = {"Skillchain Dmg", 0.1, 0.3, 0.4, 0.6, "%"}
Attach["Fire"]["Speedloader II"] = {"Skillchain Dmg", 0.15, 0.45, 0.6, 0.8, "%"}
Attach["Fire"]["Strobe"] = {"Enmity", 10, 25, 40, 60, "Int"}
Attach["Fire"]["Strobe II"] = {"Enmity", 20, 40, 65, 100, "Int"}
Attach["Fire"]["Tension Spring"] = {"Attack", 0.03, 0.06, 0.09, 0.12, "%"}
Attach["Fire"]["Tension Spring II"] = {"Attack", 0.06, 0.09, 0.12, 0.15, "%"}
Attach["Fire"]["Tension Spring III"] = {"Attack", 0.12, 0.15, 0.18, 0.21, "%"}
Attach["Fire"]["Tension Spring IV"] = {"Attack", 0.15, 0.18, 0.21, 0.24, "%"}


-- Wind Attachments
Attach["Wind"] = {"Accelerator", "Accelerator II", "Accelerator III", "Accelerator IV", "Barrage Turbine", "Drum Magazine", "Pattern Reader", "Repeater", "Replicator", "Scope", "Scope II", "Scope III", "Turbo Charger", "Turbo Charger II"}
Attach["Wind"]["Accelerator"] = {"Evasion", 5, 10, 15, 20, "Int"}
Attach["Wind"]["Accelerator II"] = {"Evasion", 10, 15, 20, 25, "Int"}
Attach["Wind"]["Accelerator III"] = {"Evasion", 20, 35, 40, 50, "Int"}
Attach["Wind"]["Accelerator IV"] = {"Evasion", 30, 45, 60, 80, "Int"}
Attach["Wind"]["Barrage Turbine"] = {"Barrage", 0, 2, 3, 4, "Int"}
Attach["Wind"]["Drum Magazine"] = {"Snapshot", 3, 6, 9, 15, "Int"}
Attach["Wind"]["Pattern Reader"] = {"Inknown", 0, 0, 0, 0, "Int"}
Attach["Wind"]["Repeater"] = {"Double Shot", 0.1, 0.15, 0.35, 0.65, "%"}
Attach["Wind"]["Replicator"] = {"Blink", 0, 3, 7, 10, "Int"}
Attach["Wind"]["Scope"] = {"RAcc", 10, 20, 30, 40, "Int"}
Attach["Wind"]["Scope II"] = {"RAcc", 20, 30, 40, 50, "Int"}
Attach["Wind"]["Scope III"] = {"RAcc", 30, 40, 55, 70, "Int"}
Attach["Wind"]["Turbo Charger"] = {"Haste", 0.05, 0.15, 0.20, 0.25, "%"}
Attach["Wind"]["Turbo Charger II"] = {"Haste", 0.07, 0.17, 0.28, 0.4375, "%"}


Effect = {"Haste", "Snashot", "Store TP", "Def Ignored", "Skillchain Dmg", "RAcc", "Evasion", "Double Shot", "Enmity", "TP Bonus"}
NEffect = 10

Mane = {"Wind","Fire", "Light"}
ManeRound = 1
 
TypeM = S{"Fire", "Water", "Earth", "Wind", "Dark", "Light", "Ice", "Thunder" }
 
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
ActualMode = "DD"
ActualSubMode = "NORMAL"
 
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

    StormHead = "Stormwalker Head"
    StormFrame = "StormwalkFrame"

    SoulHead = "Soulsoother Head"
    SpiritHead = "Spiritreaver Head"

    --This is based mostly off of the frames from String Theory
    --https://www.bg-wiki.com/bg/String_Theory#Automaton_Frame_Setups
    if head == HarHead and frame == HarFrame then -- Magic Tank
        ActualMode = "TANK"
        ActualSubMode = "MDT"
    elseif head == SoulHead and frame == ValFrame then --Turle Tank (Default)
        ActualMode = "TANK"
        ActualSubMode = "PDT"
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
    Auto_Maneuver = false
    refreshWindow()
end

------------------------------------
----------Windower Hooks------------
------------------------------------

--Auto Boost on Certain WS
function precast(spell,action)

    --Not quite functioning correctly. Will add when ready.
    -- if spell_control(spell) then
    --     cancel_spell()
    --     return
    -- end

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
 
function midcast(spell,action)
end
 
function aftercast(spell,action)
    enable("ear1")
    
    if spell.name == null then
        return -- Cancel Aftercast for outofrange/unable to see.
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
 
function status_change(new,old)
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
 
function pet_status_change(new,old)
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
 
function pet_aftercast(spell)
    determineGearSet()
end


function buff_change(status,gain_or_loss, buff_table)
    
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
    if Auto_Maneuver then
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
function self_command(command)
    local current_command = string.upper(command)
    local current_command_table = {}

    if #current_command:split(' ') >= 2 then
        current_command_table = T(current_command:split(' '))
    end

    if type(current_command_table) == 'table' then --We have a multiple inputs
        if current_command_table[1] == "MODE" then
            if PetMode[current_command_table[2]] then
                add_to_chat("Changing Mode To: "..current_command_table[2])
                ActualMode = current_command_table[2]

                if current_command_table[2] == 'TANK' then
                    if PetSubMode["TANK"][current_command_table[3]] then
                        ActualSubMode = current_command_table[3]
                    else
                        ActualSubMode = "NORMAL"
                    end

                    add_to_chat("Changing Pet Style To "..ActualSubMode)
                elseif current_command_table[2] == 'MAGE' then
                    if PetSubMode["MAGE"][current_command_table[3]] then
                        ActualSubMode = current_command_table[3]
                    else
                        ActualSubMode = "NORMAL"
                    end

                    add_to_chat("Changing Pet Style To "..ActualSubMode)
                elseif current_command_table[2] == 'DD' then
                    if PetSubMode["DD"][current_command_table[3]] then
                        ActualSubMode = current_command_table[3]
                    else
                        ActualSubMode = "NORMAL"
                    end

                    add_to_chat("Changing Pet Style To "..ActualSubMode)
                else
                    add_to_chat("Unable to determine Pet Style: "..current_command_table[3])
                end

            else
                add_to_chat("Unable to determine Pet Mode: ".. current_command_table[2])
            end
        elseif current_command_table[1] == "PUPHELPER" then
            if type(current_command_table[2]) == 'number' and type(current_command_table[3]) == 'number' then
                Pos_X = tonumber(current_command_table[2])
                Pos_Y = tonumber(current_command_table[3])
            elseif current_command_table[2] == 'VISIBLE' then
                windower.text.set_visibility(tb_name, not visible)
            end
        end
        
        refreshWindow()
    end
    
    if current_command == 'PDT' then

    elseif current_command == 'AUTOMAN' then
        Auto_Maneuver = not Auto_Maneuver
        refreshWindow()
    elseif current_command == 'DEBUG' then
        d_mode = not d_mode
        refreshWindow()
    elseif current_command == 'PREDICT' then
        determinePuppetType()
        refreshWindow()
    end

end

windower.register_event('prerender', function()

    --Items we want to check every second
    --TODO Further Testing
    if os.time() > time_start then
        time_start = os.time()

        if ActualMode == "TANK" then
            if buffactive['Fire Maneuver'] and pet.attachments.strobe then
                if Strobe_Recast <= 1 then
                    equip(sets.petEnmity)
                end
            end

            if buffactive['Light Maneuver'] and pet.attachments.flashbulb then
                if Flashbulb_Recast <= 1 then
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

        TotalSCalc()
       
        if sets.aftercast == sets.idle then
       
        else
            if Hybrid_State == "Idle" then
            sets.aftercast = sets.idle
            equip(sets.aftercast)
            end
        end
       
        if ActualMode == "TANK" then
            -- Nothing
        elseif Hybrid_State == "Pet Only" or Hybrid_State == "Overdrive" then
            if pet.tp >= 850 then
                equip(sets.midcast.Pet.WeaponSkill)
            else
                equip(sets.aftercast)
            end
        end

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

function sub_job_change(new,old)
    determinePuppetType()
end