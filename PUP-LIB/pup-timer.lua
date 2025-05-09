-- Various timers
Flashbulb_Timer = 45
Strobe_Timer = 30
Strobe_Recast = 0
Flashbulb_Recast = 0
Flashbulb_Time = 0
Strobe_Time = 0

PET_JUST_WEAPONSKILLED = false
PET_WEAPONSKILL_LOCK = false
startedPetWeaponSkillTimer = false
petWeaponSkillRecast = 0
petWeaponSkillTime = 0

function reset_timers()
    failedManeuvers:clear()
    currentManeuvers:clear()
    Strobe_Recast = 0
    Flashbulb_Recast = 0
    resetWeaponSkillPetTimer()

    if areas.Cities:contains(world.area) then
        texts.hide(main_text_hub)
    else
        texts.show(main_text_hub)
    end
end

function startWeaponSkillPetTimer()
    if petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == false then
        petWeaponSkillRecast = PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER
        petWeaponSkillTime = os.time()
        startedPetWeaponSkillTimer = true
    end
end

function resetWeaponSkillPetTimer()
    petWeaponSkillRecast = 0
    main_text_hub.ws_gear_lock_timer = petWeaponSkillRecast
    startedPetWeaponSkillTimer = false

    if Pet_State == const_stateEngaged then
        handle_equipping_gear(player.status, pet.status)
    end

end

function check_pet_ws_timer()
    local pet_valid = pet.isvalid
    local pet_tp = pet.tp

    -- If pet is not valid or is Idle, reset the WS timer and exit.
    if not pet_valid or Pet_State == "Idle" then
        resetWeaponSkillPetTimer()
        return
    end

    -- If pet TP data is not available, exit.
    if not pet_tp then
        return
    end

    -- If pet just used a WS, reset flags. PET_JUST_WEAPONSKILLED is set in job_pet_aftercast.
    if PET_JUST_WEAPONSKILLED == true then
        PET_JUST_WEAPONSKILLED = false -- Reset flag indicating pet just WSed.
        PET_WEAPONSKILL_LOCK = false -- Unlock pet WS gear equipping.
    end

    -- If the WS gear lockout timer is active:
    if petWeaponSkillRecast > 0 and startedPetWeaponSkillTimer == true then
        -- Count down the timer.
        petWeaponSkillRecast = PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER - (os.time() - petWeaponSkillTime)
        main_text_hub.ws_gear_lock_timer = petWeaponSkillRecast -- Update HUB display.
        -- Else if pet has enough TP, timer is not active, and WS gear is not locked:
    elseif pet_tp >= PET_MIN_TP_TO_WEAPONSKILL and petWeaponSkillRecast <= 0 and PET_WEAPONSKILL_LOCK == false then
        -- Start the WS gear lockout timer. This implies pet is ready to WS or is in WS gear.
        startWeaponSkillPetTimer()
    end

    -- If the lockout timer has expired and was started:
    if petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == true then
        PET_WEAPONSKILL_LOCK = true -- Lock pet from re-equipping WS gear immediately.
        resetWeaponSkillPetTimer() -- Reset the timer variables. Gear will be handled by the reset function.
        -- Else if the timer was started but hasn't expired, and WS gear is not locked:
    elseif startedPetWeaponSkillTimer == true and PET_WEAPONSKILL_LOCK == false then
        -- Check if pet WS gear should be equipped (e.g. if pet is at high TP before WS).
        check_pet_ws_equip()
    end

end

-- This function determines if pet-specific WS gear should be equipped.
-- It's typically called when the pet is at high TP, before executing a WS,
-- or if the WS gear lockout timer is active but not yet expired.
function check_pet_ws_equip()
    local pet_valid = pet.isvalid
    local pet_tp = pet.tp -- Note: pet_tp is fetched but not directly used in conditions here.
    -- The decision to call this function is usually already based on pet_tp.

    -- If pet is not valid, exit.
    if not pet_valid then -- Simplified condition, pet_tp check is implicitly handled by caller context.
        return
    end

    -- Conditions for equipping pet WS gear:
    -- 1. Pet Style or Mode must be DD-oriented (spam, dd, bone).
    -- OR
    -- 2. Master is Idle (implying pet is the primary actor) OR OffenseMode is Trusts (pet might be primary DD).
    -- If none of these broad conditions are met, pet WS gear is not prioritized.
    if not (state.PetStyleCycle.value:lower() == "spam" or state.PetStyleCycle.value:lower() == "dd" or
        state.PetModeCycle.value:lower() == "dd" or state.PetStyleCycle.value:lower() == "bone") and
        not (Master_State:lower() == "idle" or state.OffenseMode.value == "Trusts") then
        return
    end

    -- Equip WSFTP set if SetFTP toggle is ON, otherwise equip WSNoFTP set.
    if state.SetFTP.value then
        equip(set_combine(sets.midcast.Pet.WSFTP))
    else
        equip(set_combine(sets.midcast.Pet.WSNoFTP))
    end
end

-- Updates the Strobe recast timer. Called periodically from prerender.
function check_strobe_recast()
    if Strobe_Recast > 0 then
        Strobe_Recast = Strobe_Timer - (os.time() - Strobe_Time)
    end
end

function check_flashbulb_recast()
    if Flashbulb_Recast > 0 then
        Flashbulb_Recast = Flashbulb_Timer - (os.time() - Flashbulb_Time)
    end
end
