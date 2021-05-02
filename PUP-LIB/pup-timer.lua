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

    if not pet_valid or Pet_State == "Idle" then
        resetWeaponSkillPetTimer()
        return
    end

    if not pet_tp then
        return
    end

    if PET_JUST_WEAPONSKILLED == true then
        PET_JUST_WEAPONSKILLED = false
        PET_WEAPONSKILL_LOCK = false
    end

    if petWeaponSkillRecast > 0 and startedPetWeaponSkillTimer == true then
        -- Count down the timer if it has started
        petWeaponSkillRecast = PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER - (os.time() - petWeaponSkillTime)
        main_text_hub.ws_gear_lock_timer = petWeaponSkillRecast
    elseif pet_tp >= PET_MIN_TP_TO_WEAPONSKILL and petWeaponSkillRecast <= 0 and PET_WEAPONSKILL_LOCK == false then
        startWeaponSkillPetTimer()
    end

    if petWeaponSkillRecast <= 0 and startedPetWeaponSkillTimer == true then
        PET_WEAPONSKILL_LOCK = true
        resetWeaponSkillPetTimer()
    elseif startedPetWeaponSkillTimer == true and PET_WEAPONSKILL_LOCK == false then
        check_pet_ws_equip()
    end

end

function check_pet_ws_equip()
    local pet_valid = pet.isvalid
    local pet_tp = pet.tp

    if (not pet_valid and not pet_tp) then
        return
    end

    if not (state.PetStyleCycle.value:lower() == "spam" or state.PetStyleCycle.value:lower() == "dd" or
        state.PetModeCycle.value:lower() == "dd" or state.PetStyleCycle.value:lower() == "bone") and
        not (Master_State:lower() == "idle" or state.OffenseMode.value == "Trusts") then
        return
    end

    if state.SetFTP.value then
        equip(set_combine(sets.midcast.Pet.WSFTP))
    else
        equip(set_combine(sets.midcast.Pet.WSNoFTP))
    end
end

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
