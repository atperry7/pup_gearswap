------------------------------------------------------------------------------------------------------------------------
------------------------------------------ PUPPETMASTER LIBRARY FILES --------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
---------------------------------
--------Internal Libraries-------
---------------------------------
require('PUP-LIB/pup-gui')
require('PUP-LIB/pup-utility')
require('PUP-LIB/pet-tp')
require('PUP-LIB/self-commands')
require('PUP-LIB/pup-global')
require('PUP-LIB/pup-timer')

---------------------------------
--------External Libraries-------
---------------------------------
require('queues')
res = require('resources')
texts = require('texts')

-------------------------------
--------Global Variables-------
-------------------------------
currentManeuvers = Q {}
failedManeuvers = Q {}

-- Seeds the time used to calculate various functions per second
time_start = os.time()

-- Watching for Zone Changes to reset certain sections
windower.raw_register_event("zone change", reset_timers)

----------------------------------------------------
----------Windower Hooks/Custom Gearswap------------
----------------------------------------------------

-- Used to determine what Hybrid Mode to use when Player Idle and Pet is Engaged
function user_customize_idle_set(idleSet)
    if Master_State:lower() == const_stateIdle:lower() and Pet_State:lower() == const_stateEngaged:lower() then
        if state.HybridMode.current == "Normal" then -- If Hybrid Mode is Normal then simply return the set
            return idleSet
        else
            idleSet = sets.idle.Pet.Engaged[state.HybridMode.current] -- When Pet is engaged we pass in the Hybrid Mode to match to an existing set
            return idleSet
        end
    else -- Otherwise return the idleSet with no changes from us
        return idleSet
    end
end

-- Used to determine what Hybrid Mode to use when Player is engaged for trusts only and Pet is Engaged
function user_customize_melee_set(meleeSet)
    if (Master_State:lower() == const_stateEngaged:lower() and state.OffenseMode.value == "Trusts") and
        Pet_State:lower() == const_stateEngaged:lower() then
        if state.HybridMode.current == "Normal" then -- If Hybrid Mode is Normal then simply return the set
            meleeSet = sets.idle.Pet.Engaged
            return meleeSet
        else
            meleeSet = sets.idle.Pet.Engaged[state.HybridMode.current] -- When Pet is engaged we pass in the Hybrid Mode to match to an existing set
            return meleeSet
        end
    else -- Otherwise return the idleSet with no changes from us
        return meleeSet
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Activate" or spell.english == "Deus Ex Automata" then
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

function job_aftercast(spell, action, spellMap, eventArgs)

    -- Maneuver was interrupted and we don't have up to 3 already in queue then add this to be retried
    if string.find(spell.english, "Maneuver") and spell.interrupted == true and failedManeuvers:length() <= 3 then
        failedManeuvers:push(spell)
    end

    if pet.isvalid then
        if SC[pet.frame][spell.english] and pet.tp >= 850 and Pet_State == "Engaged" then
            ws = SC[pet.frame][spell.english]
            modif = Modifier[ws]

            -- If its a valid modif
            if modif then
                equip(sets.midcast.Pet.WS[modif])
            else -- Otherwise equip the default Weapon Skill Set
                equip(sets.midcast.Pet.WSNoFTP)
            end

            -- Since this will be a new Weapon Skill we just performed best to reset any current timers
            resetWeaponSkillPetTimer()
            -- Begin the count down until we may lock out the pet weapon skill set
            startWeaponSkillPetTimer()
            eventArgs.handled = true
        else
            handle_equipping_gear(player.status, Pet_State)
        end
    else
        handle_equipping_gear(player.status, Pet_State)
    end
end

-- This watches for when the Player changes to idle/engaged/resting
function job_status_change(new, old)
    if new == "Engaged" then
        Master_State = const_stateEngaged

        -- If we have AutoDeploy turned on and our pet is out then we will auto deploy
        if state.AutoDeploy.value == true and pet.isvalid then
            msg('Auto Deploying Pet')

            -- Gets the current target we have focus on and make sure it isn't null
            -- We are also keeping track of the current monster just in case we auto switch
            local check_current_target = windower.ffxi.get_mob_by_target('t')
            if check_current_target then
                currentTargetedMonster = check_current_target.id
                send_command('wait 0.5; input /pet "Deploy" <t>')
            end
        end
    else
        Master_State = const_stateIdle

        if state.CP.value == true then -- Fail safe to make sure back is enabled after a fight is over
            enable("back")
        end
    end

    handle_equipping_gear(player.status, Pet_State)
end

function job_pet_status_change(new, old)
    if new == "Engaged" then
        Pet_State = const_stateEngaged
    else
        Pet_State = const_stateIdle
    end

    handle_equipping_gear(player.status, Pet_State)
end

function job_pet_aftercast(spell)
    -- If pet just finished a weapon skill we want to temporarily block it from going back into weapon skill gear
    if table.contains(AutomatonWeaponSkills, spell.name) then
        PET_JUST_WEAPONSKILLED = true
    end

    handle_equipping_gear(player.status, pet.status)
end

player_tracked_debuffs = {
    ['sleep'] = false
}

-- Anytime you change equipment you need to set eventArgs.handled or else you may get overwritten
function job_buff_change(status, gain, eventArgs)

    if status:contains("Maneuver") and gain == false then
        currentManeuvers:pop()
    end

    if status:contains("Maneuver") and gain then
        currentManeuvers:push(status)
    end

    if status:contains("Maneuver") and gain == false and state.AutoMan.value and player.hp > 0 and pet.isvalid and
        not areas.Cities:contains(world.area) and currentManeuvers:length() < 3 then
        send_command('input /ja "' .. status .. '" <me>')
    end

end

function check_failed_maneuver()
    if failedManeuvers:length() > 0 then
        local ability = failedManeuvers:pop()

        -- check recast timer to make sure we can actually use ability
        if windower.ffxi.get_ability_recasts()[res.job_abilities[ability.id].recast_id] <= 0 then
            send_command('wait 0.5;input /ja "' .. ability.name .. '" <me>')
        else
            -- if we cant recast then push it back on to try again
            failedManeuvers:push(ability)
        end
    end
end

function check_auto_deploy_target()
    if Master_State == const_stateEngaged and state.AutoDeploy.value == true then
        -- Save the currentTarget as a previous
        previousTargetedMonster = currentTargetedMonster
        potentialTarget = windower.ffxi.get_mob_by_target('t')

        -- Get the new current target
        if potentialTarget then
            currentTargetedMonster = potentialTarget.id
        end

        -- If the monster ID's are not equal then we changed monsters
        if previousTargetedMonster ~= currentTargetedMonster then
            msg('Auto Deploying Pet')
            send_command('wait 0.5;input /pet "Deploy" <t>')
        end

    end
end

function check_cp_cape_equip()
    if Master_State == const_stateEngaged and state.CP.value == true then
        monsterToCheck = windower.ffxi.get_mob_by_target('t')
        if monsterToCheck then -- Sanity Check
            if monsterToCheck.hpp < 25 then -- Check mobs HP Percentage is below 25 then equip CP cape
                equip({
                    back = CP_CAPE
                })
                disable("back") -- Lock back until we disengage
            else
                enable("back") -- Else make sure the back is enabled
            end
        end
    end
end

function check_pet_enmity_gear()
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
end

windower.register_event("prerender", function()

    -- Items we want to check every second
    if os.time() > time_start then
        time_start = os.time()
        local pet_status = pet.status
        local master_status = player.status

        if pet_status then
            Pet_State = pet_status
        end

        if master_status then
            Master_State = master_status
        end

        calculatePetTpPerSec()
        -- Now we check if we need to lock our back for CP
        check_cp_cape_equip()

        -- As long as we are not doing an action
        if not midaction() then
            check_failed_maneuver()

            -- If we are in auto deploy and engaged we are going check if we have changed targets
            check_auto_deploy_target()

            check_pet_enmity_gear()
        end

        check_pet_ws_timer()

        check_strobe_recast()

        updateTextInformation()
    end
end)

windower.register_event("incoming text", function(original, modified, mode)

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
end)

-- Passes state changes for cycle commands
-- handle_update is always called when a job state is changed
-- Best to adjust gear in job_handle_update which is an override for the job file
function job_state_change(stateField, newValue, oldValue)

    --[[
        stateField is the Mode that could be passed in that is changing
        This could include PhysicalDefenseMode, OffenseMode, PetModeCycle -- etc
        If you provide a description then that is what will be passed in

        For example:
        state.AutoDeploy = M(false, "Auto Deploy")

        The second portion is a description so that is what the stateField would equal if this passed in

        Then we are given the newValue what it is changing to
        Then we are given the oldValue what it is changing from
    ]]

    if stateField == const_PetModeCycle then -- Handles PetModeCycle Changes
        -- Depending on the Pet Mode we are changing too these each have their own style to use
        if newValue == const_tank then -- Sets PetStyleCycle to Tank if we are going to Tank Mode
            state.PetStyleCycle = state.PetStyleCycleTank
        elseif newValue == const_dd then -- Sets PetStyleCycle to DD if we are going to DD Mode
            state.PetStyleCycle = state.PetStyleCycleDD
        elseif newValue == const_mage then -- Sets PetStyleCycle to Mage if we are going to MAGE Mode
            state.PetStyleCycle = state.PetStyleCycleMage
        else
            -- In the off chance we can't find this the new style added this is displayed
            msg("No Style found for: " .. newValue)
        end

        -- Update the Mode/Style to show properly on HUB
        main_text_hub.pet_current_mode = state.PetModeCycle.current
        main_text_hub.pet_current_style = state.PetModeCycle.current

        -- Update gear
        handle_equipping_gear(player.status, Pet_State)
    elseif stateField == const_PetStyleCycle then
        main_text_hub.pet_current_style = newValue
    elseif stateField == "Auto Maneuver" then -- Updates HUB for Auto Maneuver
        if newValue == true then
            main_text_hub.toggle_auto_maneuver = const_on
        else
            main_text_hub.toggle_auto_maneuver = const_off
        end

    elseif stateField == "Lock Pet DT" then
        -- This command overrides everything and blocks all gear changes
        -- Will lock until turned off or Pet is disengaged
        if newValue == true then
            equip(sets.pet.EmergencyDT)
            disable("main", "sub", "range", "ammo", "head", "neck", "lear", "rear", "body", "hands", "lring", "rring",
                "back", "waist", "legs", "feet")

            main_text_hub.toggle_lock_pet_dt_set = const_on
        else
            enable("main", "sub", "range", "ammo", "head", "neck", "lear", "rear", "body", "hands", "lring", "rring",
                "back", "waist", "legs", "feet")

            main_text_hub.toggle_lock_pet_dt_set = const_off
        end

    elseif stateField == "Lock Weapon" then -- Updates HUB and disables/enables window for Lock Weapon
        if newValue == true then
            disable("main")
            main_text_hub.toggle_lock_weapon = const_on
        else
            enable("main")
            main_text_hub.toggle_lock_weapon = const_off
        end
    elseif stateField == "Custom Gear Lock" then -- Updates HUB and disables/enables gear from custom lock
        if newValue == true then
            main_text_hub.toggle_custom_gear_lock = const_on
            disable(customGearLock)
        else
            main_text_hub.toggle_custom_gear_lock = const_off
            enable(customGearLock)
            handle_equipping_gear(player.status, Pet_State)
        end
    elseif stateField == 'Auto Deploy' then -- Updates HUB for Auto Deploy
        if newValue == true then
            main_text_hub.toggle_auto_deploy = const_on
        else
            main_text_hub.toggle_auto_deploy = const_off
        end
    elseif stateField == 'Hide HUB' then -- Hides or Shows the entire HUB Window
        if newValue == true then
            texts.hide(main_text_hub)
        else
            texts.show(main_text_hub)
        end
    elseif stateField == 'Hide Mode' then -- Handles hide/show Mode Section
        hideTextSections()
    elseif stateField == 'Hide State' then -- Handles hide/show State Section
        hideTextSections()
    elseif stateField == 'Hide Options' then -- Handles hide/show Options Section
        hideTextSections()
    elseif stateField == 'Hide Keybinds' then -- Handles hide/show Keybinds
        if newValue == true then
            texts.update(main_text_hub, keybinds_on)
        else
            texts.update(main_text_hub, keybinds_off)
        end
    elseif stateField == 'Offense Mode' then -- Updates HUB for Offense Mode
        main_text_hub.player_current_offense = newValue
    elseif stateField == 'Physical Defense Mode' then -- Updates HUB for Physical Defense Mode
        main_text_hub.player_current_physical = newValue
    elseif stateField == 'Hybrid Mode' then -- Updates HUB for Hybrid Mode
        main_text_hub.player_current_hybrid = newValue
    elseif stateField == 'Idle Mode' then -- Updates HUB for Idle Mode
        main_text_hub.player_current_idle = newValue
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- This will display gear and run when F12 is pressed
function display_current_job_state(eventArgs)
    local msg = ""

    if state.PetModeCycle.value ~= "None" then
        msg = msg .. "Pet Mode: (" .. state.PetModeCycle.value .. ")"
    end

    if state.PetStyleCycle.value ~= "None" then
        msg = msg .. ", Pet Style: (" .. state.PetStyleCycle.value .. ")"
    end

    handle_equipping_gear(player.status, Pet_State)
    add_to_chat(122, msg)
end
