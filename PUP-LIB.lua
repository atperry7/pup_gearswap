------------------------------------------------------------------------------------------------------------------------
------------------------------------------ PUPPETMASTER LIBRARY FILES --------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
res = require('resources')
texts = require('texts')

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
keybinds_on = {}
keybinds_on['key_bind_pet_mode'] = '(ALT+F7)'
keybinds_on['key_bind_pet_style'] = '(ALT+F8)'
keybinds_on['key_bind_idle'] = '(CTRL+F12)'
keybinds_on['key_bind_offense'] = '(F9)'
keybinds_on['key_bind_physical'] = '(CTRL+F10)'
keybinds_on['key_bind_hybrid'] = '(CTRL+F9)'
keybinds_on['key_bind_auto_maneuver'] = '(ALT+E)'
keybinds_on['key_bind_pet_dt'] = '(ALT+D)'
keybinds_on['key_bind_lock_weapon'] = '(ALT+Tilda)'

keybinds_off = {}
keybinds_off['key_bind_pet_mode'] = ''
keybinds_off['key_bind_pet_style'] = ''
keybinds_off['key_bind_idle'] = ''
keybinds_off['key_bind_offense'] = ''
keybinds_off['key_bind_physical'] = ''
keybinds_off['key_bind_hybrid'] = ''
keybinds_off['key_bind_auto_maneuver'] = ''
keybinds_off['key_bind_pet_dt'] = ''
keybinds_off['key_bind_lock_weapon'] = ''

    hub_pet_info = [[\cs(255, 115, 0)======= Pet Info ==========\cr
- \cs(0, 0, 125)HP :\cr ${pet_current_hp|0}/${pet_max_hp|0}
- \cs(0, 125, 0)MP :\cr ${pet_current_mp|0}/${pet_max_mp|0}
- \cs(255, 0, 0)TP :\cr ${pet_current_tp|0000|%04d} -- TP/S: ${pet_tp_per_second|0}
- \cs(255, 0, 0)WS Gear Lock Timer:\cr ${ws_gear_lock_timer|0}
]]

    hub_pet_skills = [[\cs(255, 115, 0)======= Pet Skills ========\cr
${current_pet_skills|- No Skills To Track}
]]

    hub_state = [[\cs(255, 115, 0)======= State ============\cr
-\cs(125, 125, 0)${key_bind_pet_mode} Pet Mode :\cr ${pet_current_mode|TANK}
-\cs(125, 125, 0)${key_bind_pet_style} Pet Style :\cr ${pet_current_style|NORMAL}
-\cs(125, 125, 0) Combined State :\cr ${player_pet_state|Idle}
]]

    hub_mode = [[\cs(255, 115, 0)======= Mode ============\cr
-\cs(125, 125, 0)${key_bind_idle} Idle Mode :\cr ${player_current_idle|Idle}
-\cs(125, 125, 0)${key_bind_offense} Offense Mode :\cr ${player_current_offense|MasterPet}
-\cs(125, 125, 0)${key_bind_physical} Physical Mode :\cr ${player_current_physical|PetDT}
-\cs(125, 125, 0)${key_bind_hybrid} Hybrid Mode :\cr ${player_current_hybrid|Normal}
]]

    hub_options = [[\cs(255, 115, 0)======= Options ==========\cr
-\cs(125, 125, 0)${key_bind_auto_maneuver} Auto Maneuver :\cr ${toggle_auto_maneuver|OFF}
-\cs(125, 125, 0)${key_bind_pet_dt} Lock Pet DT Set :\cr ${toggle_lock_pet_dt_set|OFF}
-\cs(125, 125, 0)${key_bind_lock_weapon} Lock Weapon :\cr ${toggle_lock_weapon|OFF}
-\cs(125, 125, 0) Weaponskill FTP :\cr ${toggle_weaponskill_ftp|OFF}
-\cs(125, 125, 0) Custom Gear Lock :\cr ${toggle_custom_gear_lock|OFF}
-\cs(125, 125, 0) Auto Deploy :\cr ${toggle_auto_deploy|OFF}
]]

function validateTextInformation()
    if pet.isvalid then
        updatePetStats()
        updatePetSkills()
    end

    --State Information
    main_text_hub.pet_current_mode = state.PetModeCycle.current
    main_text_hub.pet_current_style = state.PetStyleCycle.current
    main_text_hub.player_pet_state = Hybrid_State

    --Mode Information
    main_text_hub.player_current_idle = state.IdleMode.current
    main_text_hub.player_current_offense = state.OffenseMode.current
    main_text_hub.player_current_physical = state.PhysicalDefenseMode.current
    main_text_hub.player_current_hybrid = state.HybridMode.current

    --Options Information
    if state.AutoMan.value then
        main_text_hub.toggle_auto_maneuver = "ON"
    else
        main_text_hub.toggle_auto_maneuver = "OFF"
    end

    if state.LockPetDT.value then
        main_text_hub.toggle_lock_pet_dt_set = "ON"
    else
        main_text_hub.toggle_lock_pet_dt_set = "OFF"
    end

    if state.LockWeapon.value then
        main_text_hub.toggle_lock_weapon = "ON"
    else
        main_text_hub.toggle_lock_weapon = "OFF"
    end

    if state.SetFTP.value then
        main_text_hub.toggle_weaponskill_ftp = "ON"
    else
        main_text_hub.toggle_weaponskill_ftp = "OFF"
    end

    if state.CustomGearLock.value then
        main_text_hub.toggle_custom_gear_lock =  "ON"
    else
        main_text_hub.toggle_custom_gear_lock =  "OFF"
    end

    if state.AutoDeploy.value then
        main_text_hub.toggle_auto_deploy = "ON"
    else
        main_text_hub.toggle_auto_deploy = "OFF"
    end
        
    if state.Keybinds.value then
        texts.update(main_text_hub, keybinds_on)
    else 
        texts.update(main_text_hub, keybinds_off)
    end

end

--Default To Set Up the Text Window
function setupTextWindow(pos_x, pos_y)

    local default_settings = {}
    default_settings.pos = {}
    default_settings.pos.x = pos_x
    default_settings.pos.y = pos_y
    default_settings.bg = {}

    default_settings.bg.alpha = 200
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = true
    default_settings.flags.italic = false
    default_settings.padding = 10
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

    main_text_hub = texts.new('', default_settings, default_settings)

    
    texts.append(main_text_hub, hub_pet_info)
    texts.append(main_text_hub, hub_pet_skills)
    texts.append(main_text_hub, hub_state)
    texts.append(main_text_hub, hub_mode)
    texts.append(main_text_hub, hub_options)

    validateTextInformation()

    main_text_hub:show()
    
end

function hideTextSections()

    texts.clear(main_text_hub)

    texts.append(main_text_hub, hub_pet_info)
    texts.append(main_text_hub, hub_pet_skills)
    
    if not state.textHideState.value then
        texts.append(main_text_hub, hub_state)

    end
    
    if not state.textHideMode.value then
        texts.append(main_text_hub, hub_mode)

    end
    
    if not state.textHideOptions.value then
        texts.append(main_text_hub, hub_options)
    end

    validateTextInformation()

end

--This handles drawing the Pet Skills for the text box
function updatePetSkills()
    if not pet.isvalid then
        return 
    end

    local pet_skills = ''

    -- Strobe recast
    if Strobe_Recast == 0 and (pet.attachments.strobe or pet.attachments["strobe II"]) then
        if buffactive["Fire Maneuver"] then
            pet_skills = pet_skills .. "\\cs(125, 125, 125)-\\cr \\cs(125,0,0)Strobe\\cr \n"
        else
            pet_skills = pet_skills .. "\\cs(125, 125, 125)- Strobe\\cr \n"
        end
    elseif pet.attachments.strobe or pet.attachments["strobe II"] then
        pet_skills = pet_skills .. "\\cs(125, 125, 125)- Strobe (" .. Strobe_Recast .. ")\\cr \n"
    end

    -- Flashbulb recast
    if Flashbulb_Recast == 0 and pet.attachments.flashbulb then
        if buffactive["Light Maneuver"] then
            pet_skills = pet_skills .. "\\cs(125, 125, 125)-\\cr \\cs(255,255,255)Flashbulb\\cr \n"
        else
            pet_skills = pet_skills .. "\\cs(125, 125, 125)- Flashbulb\\cr \n"
        end
    elseif pet.attachments.flashbulb ~= nil then
        pet_skills = pet_skills .. "\\cs(125, 125, 125)- Flashbulb (" .. Flashbulb_Recast .. ")\\cr \n"
    end

    if not pet.attachments.strobe and not pet.attachments["strobe II"] and not pet.attachments.flashbulb then
        pet_skills = pet_skills .. "\\cs(125, 125, 125)-No Skills To Track\\cr \n"
    end

    main_text_hub.current_pet_skills = pet_skills
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

    main_text_hub.player_pet_state = Hybrid_State
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
just_zoned = false
just_zoned_time = os.time()

function reset_timers()
    state.AutoMan:reset()
    Current_Maneuver = 0
    determinePuppetType()
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
    else
        Pet_State = const_stateIdle
        TotalSCalc()
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
    elseif Current_Maneuver > 0 then -- We don't want to see a negative count
        Current_Maneuver = Current_Maneuver - 1
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
    elseif command[1]:lower() == "debug" then
        debug_mode = not debug_mode
        debug("Debug Mode is now on!")
    elseif command[1]:lower() == "predict" then
        determinePuppetType()
    elseif command[1]:lower() == "hide" then
        if command[2]:lower() == "mode" then
            state.textHideMode:toggle()
            hideTextSections()
        elseif command[2]:lower() == "state" then
            state.textHideState:toggle()
            hideTextSections()
        elseif command[2]:lower() == "hub" then
            state.textHideHUB:toggle()
            if state.textHideHUB.value == true then
                texts.hide(main_text_hub)
            else 
                texts.show(main_text_hub)
            end

            hideTextSections()
        elseif command[2]:lower() == "keybinds" then
            state.Keybinds:toggle()

            if state.Keybinds.value then
                texts.update(main_text_hub, keybinds_on)
            else 
                texts.update(main_text_hub, keybinds_off)
            end

            hideTextSections()
        elseif command[2]:lower() == "options" then
            state.textHideOptions:toggle()
            hideTextSections()
        end
    elseif command[1]:lower() == "setftp" then
        state.SetFTP:toggle()
    elseif command[1]:lower() == "customgearlock" then
        state.CustomGearLock:toggle()
    elseif command[1]:lower() == "clear" then
        texts.clear(main_text_hub)
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

track_pet_tp = L{}
max_pet_tp_to_track = 10
previous_pet_tp = 0

function calculatePetTpPerSec()
    if not pet.isvalid and pet.tp == nil then
        return
    end

    local average_pet_tp = 0
    local current_pet_tp = 0

    current_pet_tp = pet.tp

    main_text_hub.pet_current_tp = current_pet_tp
    
    if current_pet_tp >= 0 then

        if current_pet_tp > previous_pet_tp then
            --Appends to the end of the list
            list.append(track_pet_tp, current_pet_tp - previous_pet_tp)
        else
            list.append(track_pet_tp, 0)
        end
        
        previous_pet_tp = current_pet_tp
    end


    if track_pet_tp.n > max_pet_tp_to_track then
        --Once we have reached max we want to track remove first
        list.remove(track_pet_tp, 1)
    end

    for i = 1, track_pet_tp.n do
        --Add up all the current TP stored
        average_pet_tp = average_pet_tp + track_pet_tp[i]
    end

    --Figure out our TP per second based on max we are tracking
    main_text_hub.pet_tp_per_second = math.floor((average_pet_tp) / max_pet_tp_to_track)

end

function updatePetStats()

    if pet.isvalid and player.hpp > 0 then
        if pet.hp ~= nil then
            main_text_hub.pet_current_hp = tostring(pet.hp)
        end

        if pet.mp ~= nil then
            main_text_hub.pet_current_mp = tostring(pet.mp)
        end

        if pet.max_hp ~= nil then
            main_text_hub.pet_max_hp = tostring(pet.max_hp)
        end

        if pet.max_mp then
            main_text_hub.pet_max_mp = tostring(pet.max_mp)
        end

        if pet.tp ~= nil then
            current_pet_tp = pet.tp
            main_text_hub.pet_current_tp = current_pet_tp
        end

    end
end

windower.register_event(
    "prerender",
    function()

        updatePetStats()

        --Items we want to check every second
        if os.time() > time_start then
            time_start = os.time()

            calculatePetTpPerSec()

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
                            if monsterToCheck.hpp < 25 then --Check mobs HP Percentage if below 15 then equip CP cape 
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
                main_text_hub.ws_gear_lock_timer = petWeaponSkillRecast
            end

            updatePetSkills()
            validateTextInformation()
            
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
    main_text_hub.ws_gear_lock_timer = petWeaponSkillRecast
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
            end
        end

        if buffactive["Light Maneuver"] then
            if original:contains(pet.name) and original:contains("Flashbulb") then
                add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*")
                Flashbulb_Time = os.time()
                Flashbulb_Recast = Flashbulb_Timer
                handle_equipping_gear(player.status, pet.status)
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

        main_text_hub.pet_current_mode = state.PetModeCycle.current

        handle_equipping_gear(player.status, Pet_State)
    elseif stateField == const_PetStyleCycle then
        main_text_hub.pet_current_style = newValue
    elseif stateField == "Auto Maneuver" then
        if newValue == true then
            main_text_hub.toggle_auto_maneuver = "ON"
        else
            main_text_hub.toggle_auto_maneuver = "OFF"
        end
        
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

            main_text_hub.toggle_lock_pet_dt_set = "ON"
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

            main_text_hub.toggle_lock_pet_dt_set = "OFF"
        end

    elseif stateField == "Lock Weapon" then
        if newValue == true then
            disable("main")
            main_text_hub.toggle_lock_weapon = "ON"
        else
            enable("main")
            main_text_hub.toggle_lock_weapon = "OFF"
        end
    elseif stateField == "Custom Gear Lock" then
        if newValue == true then
            main_text_hub.toggle_custom_gear_lock = "ON"
            disable(customGearLock)
        else
            main_text_hub.toggle_custom_gear_lock = "OFF"
            enable(customGearLock)
            handle_equipping_gear(player.status, Pet_State)
        end
    elseif stateField == 'Auto Deploy' then
        if newValue == true then
            main_text_hub.toggle_auto_deploy = "ON"
        else
            main_text_hub.toggle_auto_deploy = "OFF"
        end
    elseif stateField == 'Hide HUB' then
        if newValue == true then
            texts.hide(main_text_hub)
        else 
            texts.show(main_text_hub)
        end
    elseif stateField == 'Hide Mode' then
        hideTextSections()
    elseif stateField == 'Hide State' then
        hideTextSections()
    elseif stateField == 'Hide Options' then
        hideTextSections()
    elseif stateField == 'Hide Keybinds' then
        if newValue == true then
            texts.update(main_text_hub, keybinds_on)
        else 
            texts.update(main_text_hub, keybinds_off)
        end
    elseif stateField == 'Offense Mode' then
        main_text_hub.player_current_offense = newValue
    elseif stateField == 'Physical Defense Mode' then
        main_text_hub.player_current_physical = newValue
    elseif stateField == 'Hybrid Mode' then
        main_text_hub.player_current_hybrid = newValue
    elseif stateField == 'Idle Mode' then
        main_text_hub.player_current_idle = newValue
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
    if not windower.dir_exists(windower.addon_path..'data/pup_log') then
        windower.create_dir(windower.addon_path..'data/pup_log')
    end

    filename = 'pup_debug_' .. os.date('%m_%d_%y') .. '.log'
    debug_file = io.open(windower.addon_path .. "data/pup_log/" .. filename, "a")

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