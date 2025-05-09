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
        if spell.english == "Deploy" and pet.tp >= 950 and state.PetModeCycle.value ~= const_mage then
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
        -- Check if the master's spell corresponds to a pet skillchain ability defined in SC table
        -- Also ensure pet has enough TP and is engaged
        if SC[pet.frame] and SC[pet.frame][spell.english] and pet.tp >= 850 and Pet_State == "Engaged" then
            -- Determine the pet's corresponding weaponskill (ws) from the SC table
            ws = SC[pet.frame][spell.english]
            -- Get the gear modifier (e.g., "VIT", "DEX") for this pet ws from the Modifier table
            modif = Modifier[ws]

            -- If a specific modifier set exists for this pet ws (e.g., sets.midcast.Pet.WS["VIT"])
            if modif and sets.midcast.Pet.WS[modif] then
                equip(sets.midcast.Pet.WS[modif])
            else -- Otherwise, equip the default pet weaponskill set (WSNoFTP)
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
        time_start = os.time() -- Update the timer for the next second
        local pet_status = pet.status
        local master_status = player.status

        -- Update global Pet_State if pet status is available
        if pet_status then
            Pet_State = pet_status
        end

        -- Update global Master_State if player status is available
        if master_status then
            Master_State = master_status
        end

        -- Calculate pet TP per second for HUB display
        calculatePetTpPerSec()
        -- Check if CP cape needs to be equipped/unequipped
        check_cp_cape_equip()

        -- Perform these checks only if the player is not currently in an action
        if not midaction() then
            -- Check and retry any failed maneuvers
            check_failed_maneuver()
            -- Check if pet needs to be redeployed due to target change (if AutoDeploy is on)
            check_auto_deploy_target()
            -- Check if pet enmity gear needs to be equipped (Tank mode, specific maneuvers active)
            check_pet_enmity_gear()
        end

        -- Check and manage pet weaponskill gear timer and equipping logic
        check_pet_ws_timer()
        -- Update Strobe recast timer
        check_strobe_recast()
        -- Update Flashbulb recast timer
        check_flashbulb_recast()
        -- Refresh all information displayed on the HUB
        updateTextInformation()
    end
end)

windower.register_event("incoming text", function(original, modified, mode)

    -- Checking timer for enmity sets by parsing chat log for pet ability usage
    -- If Fire Maneuver is active and pet uses Provoke (Strobe)
    if buffactive["Fire Maneuver"] then
        if original:contains(pet.name) and original:contains("Provoke") then
            add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Strobe done ] *-*-*-*-*-*-*-*-*")
            Strobe_Time = os.time() -- Reset Strobe timer start time
            Strobe_Recast = Strobe_Timer -- Reset Strobe recast duration
            handle_equipping_gear(player.status, pet.status)
        end
    end

    -- If Light Maneuver is active and pet uses Flashbulb
    if buffactive["Light Maneuver"] then
        if original:contains(pet.name) and original:contains("Flashbulb") then
            add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*")
            Flashbulb_Time = os.time() -- Reset Flashbulb timer start time
            Flashbulb_Recast = Flashbulb_Timer -- Reset Flashbulb recast duration
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
        If you provide a description then that is what will be passed in (e.g., "Auto Deploy" for state.AutoDeploy).

        For example:
        state.AutoDeploy = M(false, "Auto Deploy")

        The second portion ("Auto Deploy") is a description, so that is what the stateField would equal if this state is passed in.

        newValue: The new value the state is changing to.
        oldValue: The old value the state is changing from.
    ]]

    -- Handles changes to PetModeCycle (e.g., TANK, DD, MAGE)
    if stateField == const_PetModeCycle then
        -- Depending on the new Pet Mode, set the corresponding PetStyleCycle
        if newValue == const_tank then -- If new mode is TANK
            state.PetStyleCycle = state.PetStyleCycleTank -- Set style cycle to Tank options
        elseif newValue == const_dd then -- If new mode is DD
            state.PetStyleCycle = state.PetStyleCycleDD -- Set style cycle to DD options
        elseif newValue == const_mage then -- If new mode is MAGE
            state.PetStyleCycle = state.PetStyleCycleMage -- Set style cycle to Mage options
        else
            -- Fallback message if an unknown PetModeCycle value is encountered
            msg("No Style found for: " .. newValue)
        end

        -- Update the HUB to reflect the new Pet Mode and Style
        main_text_hub.pet_current_mode = state.PetModeCycle.current
        main_text_hub.pet_current_style = state.PetStyleCycle.current -- Display the first style in the new cycle

        -- Re-evaluate and equip gear based on the new state
        handle_equipping_gear(player.status, Pet_State)

        -- Handles changes to PetStyleCycle (e.g., NORMAL, SPAM, HEAL)
    elseif stateField == const_PetStyleCycle then
        -- Update the HUB to show the new Pet Style
        main_text_hub.pet_current_style = newValue

        -- Handles changes to "Auto Maneuver" toggle
    elseif stateField == "Auto Maneuver" then
        -- Update HUB display for Auto Maneuver (ON/OFF)
        if newValue == true then
            main_text_hub.toggle_auto_maneuver = const_on
        else
            main_text_hub.toggle_auto_maneuver = const_off
        end

        -- Handles changes to "Lock Pet DT" toggle
    elseif stateField == "Lock Pet DT" then
        -- This command overrides all other gear changes and locks pet into EmergencyDT set.
        if newValue == true then -- If Lock Pet DT is being turned ON
            equip(sets.pet.EmergencyDT) -- Equip emergency pet DT set
            -- Disable all gear slots to prevent changes
            disable("main", "sub", "range", "ammo", "head", "neck", "lear", "rear", "body", "hands", "lring", "rring",
                "back", "waist", "legs", "feet")
            main_text_hub.toggle_lock_pet_dt_set = const_on -- Update HUB
        else -- If Lock Pet DT is being turned OFF
            -- Enable all gear slots
            enable("main", "sub", "range", "ammo", "head", "neck", "lear", "rear", "body", "hands", "lring", "rring",
                "back", "waist", "legs", "feet")
            main_text_hub.toggle_lock_pet_dt_set = const_off -- Update HUB
            -- Re-evaluate and equip appropriate gear
            handle_equipping_gear(player.status, Pet_State)
        end

        -- Handles changes to "Lock Weapon" toggle
    elseif stateField == "Lock Weapon" then
        if newValue == true then -- If Lock Weapon is ON
            disable("main") -- Disable main weapon slot
            main_text_hub.toggle_lock_weapon = const_on -- Update HUB
        else -- If Lock Weapon is OFF
            enable("main") -- Enable main weapon slot
            main_text_hub.toggle_lock_weapon = const_off -- Update HUB
            handle_equipping_gear(player.status, Pet_State) -- Re-evaluate gear
        end

        -- Handles changes to "Custom Gear Lock" toggle
    elseif stateField == "Custom Gear Lock" then
        if newValue == true then -- If Custom Gear Lock is ON
            main_text_hub.toggle_custom_gear_lock = const_on -- Update HUB
            disable(customGearLock) -- Disable slots specified in customGearLock table
        else -- If Custom Gear Lock is OFF
            main_text_hub.toggle_custom_gear_lock = const_off -- Update HUB
            enable(customGearLock) -- Enable slots specified in customGearLock table
            handle_equipping_gear(player.status, Pet_State) -- Re-evaluate gear
        end

        -- Handles changes to 'Auto Deploy' toggle
    elseif stateField == 'Auto Deploy' then
        -- Update HUB display for Auto Deploy (ON/OFF)
        if newValue == true then
            main_text_hub.toggle_auto_deploy = const_on
        else
            main_text_hub.toggle_auto_deploy = const_off
        end

        -- Handles changes to 'Hide HUB' toggle (hides/shows the entire HUB window)
    elseif stateField == 'Hide HUB' then
        if newValue == true then
            texts.hide(main_text_hub)
        else
            texts.show(main_text_hub)
        end

        -- Handles changes to 'Hide Mode' toggle (hides/shows Mode section of HUB)
    elseif stateField == 'Hide Mode' then
        hideTextSections() -- Rebuilds HUB with/without Mode section

        -- Handles changes to 'Hide State' toggle (hides/shows State section of HUB)
    elseif stateField == 'Hide State' then
        hideTextSections() -- Rebuilds HUB with/without State section

        -- Handles changes to 'Hide Options' toggle (hides/shows Options section of HUB)
    elseif stateField == 'Hide Options' then
        hideTextSections() -- Rebuilds HUB with/without Options section

        -- Handles changes to 'Hide Keybinds' toggle (shows/hides keybind hints on HUB)
    elseif stateField == 'Hide Keybinds' then
        if newValue == true then
            texts.update(main_text_hub, keybinds_on) -- Show keybinds
        else
            texts.update(main_text_hub, keybinds_off) -- Hide keybinds (set to empty strings)
        end

        -- Handles changes to 'Offense Mode' (e.g., MasterPet, Master, Trusts)
    elseif stateField == 'Offense Mode' then
        main_text_hub.player_current_offense = newValue -- Update HUB

        -- Handles changes to 'Physical Defense Mode' (e.g., PetDT, MasterDT)
    elseif stateField == 'Physical Defense Mode' then
        main_text_hub.player_current_physical = newValue -- Update HUB

        -- Handles changes to 'Hybrid Mode' (e.g., Normal, Acc, TP, DT)
    elseif stateField == 'Hybrid Mode' then
        main_text_hub.player_current_hybrid = newValue -- Update HUB

        -- Handles changes to 'Idle Mode' (e.g., Idle, MasterDT)
    elseif stateField == 'Idle Mode' then
        main_text_hub.player_current_idle = newValue -- Update HUB
    end
end

-- Set eventArgs.handled to true if we don't want Gearswap's automatic display to run.
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
