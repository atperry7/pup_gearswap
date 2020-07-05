-- Toggles -- SE Macros: /console gs c "command"
function job_self_command(commandArgs, eventArgs)
    if pup_self_commands[commandArgs[1]] then
        local handleCmd = table.remove(commandArgs, 1)
        
        pup_self_commands[handleCmd](commandArgs)
        eventArgs.handled = true
    end
end

local function handle_automan(commandParams)
    state.AutoMan:toggle()
    updateTextInformation()
end

local function handle_predict(commandParams)
    determinePuppetType()
end

local function handle_gui(commandParams)
    if #commandParams == 0 then
        add_to_chat(123,'PUP-LIB: GUI Component not specified.')
        return
    end

    local gui_component = table.remove(commandParams, 1)

    if gui_component:lower() == "mode" then --Hides the Mode
        state.textHideMode:toggle()
        hideTextSections()

    elseif gui_component:lower() == "state" then --Hides/Shows the State
        state.textHideState:toggle()
        hideTextSections()

    elseif gui_component:lower() == "all" then -- Hides/Shows the HUB
        state.textHideHUB:toggle()

        if state.textHideHUB.value == true then
            texts.hide(main_text_hub)
        else
            texts.show(main_text_hub)
        end

    elseif gui_component:lower() == "keybinds" then --Hides/Show Keybinds
        state.Keybinds:toggle()

        if state.Keybinds.value then
            texts.update(main_text_hub, keybinds_on) --If ON then we pass in Table for keybinds to update the variables
        else 
            texts.update(main_text_hub, keybinds_off) --Otherwise we set them to blank
        end

        hideTextSections()
    elseif gui_component:lower() == "options" then --Hides/Show Options
        state.textHideOptions:toggle()
        hideTextSections()

    elseif gui_component:lower() == "lite" then --Hides/Show Options
        state.useLightMode:toggle()
        toggleHubStyle()

    end

    hideTextSections()
end

local function handle_set_ftp(commandParams)
    state.SetFTP:toggle()
    updateTextInformation()
end

local function handle_custom_gear_lock(commandParams)
    state.CustomGearLock:toggle()
    updateTextInformation()
end

local function handle_clear_manuever(commandParams)
    failedManeuvers:clear()
    msg('Maneuvers have been reset')
end

local function handle_ws_timer(commandParams)
    if #commandParams == 0 then
        add_to_chat(123,'PUP-LIB: WS Timer not specified.')
        return
    end

    local ws_timer = tonumber(table.remove(commandParams, 1))

    if type(ws_timer) ~= 'number' then
        add_to_chat(123,'PUP-LIB: WS Timer is not a number.')
        return
    end

    PET_GEAR_WEAPONSKILL_LOCKOUT_TIMER = ws_timer

end

local function handle_tp_min(commandArgs)
    if #commandParams == 0 then
        add_to_chat(123,'PUP-LIB: TP MIN not specified.')
        return
    end

    local tp_min = tonumber(table.remove(commandParams, 1))

    if type(tp_min) ~= 'number' then
        add_to_chat(123,'PUP-LIB: TP MIN is not a number.')
        return
    end

    PET_MIN_TP_TO_WEAPONSKILL = tp_min

end

pup_self_commands = {
    ['automan'] = handle_automan,
    ['predict'] = handle_predict,
    ['hub'] = handle_gui,
    ['hide'] = handle_gui,
    ['gui'] = handle_gui,
    ['setftp'] = handle_set_ftp,
    ['customgearlock'] = handle_custom_gear_lock,
    ['clear'] = handle_clear_manuever,
    ['wstimer'] = handle_ws_timer,
    ['tpmin'] = handle_tp_min,
}
