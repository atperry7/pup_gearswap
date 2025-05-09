------------------------------------
------------Text Window-------------
------------------------------------
const_on = "\\cs(32, 255, 32)ON\\cr"
const_off = "\\cs(255, 32, 32)OFF\\cr"

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
]]
keybinds_on = {}
keybinds_on['key_bind_pet_mode'] = '(ALT+F7)'
keybinds_on['key_bind_pet_style'] = '(ALT+F8)'
keybinds_on['key_bind_idle'] = '(CTRL+F12)'
keybinds_on['key_bind_offense'] = '(F9)'
keybinds_on['key_bind_physical'] = '(CTRL+F10)'
keybinds_on['key_bind_hybrid'] = '(CTRL+F9)'
keybinds_on['key_bind_auto_maneuver'] = '(ALT+E)'
keybinds_on['key_bind_pet_dt'] = '(ALT+D)'
keybinds_on['key_bind_lock_weapon'] = '(CTRL+Tilda)'

--[[
    This gets passed in when the Keybinds are turned off.
    For not it simply sets the variable to an empty string
    (Researching better way to handle this)
]]
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

--[[
    These below are used to fill in the different sections on the HUB window
    It places varibles within the text object we can access instead of redrawing
    the entire text window everytime

    Variables are placed within a ${variableName|DefaultValue|Format}
    Format can be nil.

    _std stands for standard version
]]
hub_pet_info_std = [[ \cs(255, 115, 0)======= Pet Info ==========\cr
- \cs(0, 0, 125)HP :\cr ${pet_current_hp|0}/${pet_max_hp|0}
- \cs(0, 125, 0)MP :\cr ${pet_current_mp|0}/${pet_max_mp|0}
- \cs(255, 0, 0)TP :\cr ${pet_current_tp|0000|%04d} -- TP/S: ${pet_tp_per_second|0}
- \cs(255, 0, 0)WS Gear Lock Timer:\cr ${ws_gear_lock_timer|0}
]]

hub_pet_skills_std = [[ \cs(255, 115, 0)======= Pet Skills ========\cr
- \cs(125, 125, 0)Maneuvers Maintained: \cr ${current_queue|0}
- \cs(125, 125, 0)Maneuvers To Recast: \cr ${maneuver_queue|0}

${current_pet_skills|- No Skills To Track}
]]

hub_state_std = [[ \cs(255, 115, 0)======= State ============\cr
-\cs(125, 125, 0)${key_bind_pet_mode} Pet Mode :\cr ${pet_current_mode|TANK}
-\cs(125, 125, 0)${key_bind_pet_style} Pet Style :\cr ${pet_current_style|NORMAL}
]]

hub_mode_std = [[ \cs(255, 115, 0)======= Mode ============\cr
-\cs(125, 125, 0)${key_bind_idle} Idle Mode :\cr ${player_current_idle|Idle}
-\cs(125, 125, 0)${key_bind_offense} Offense Mode :\cr ${player_current_offense|MasterPet}
-\cs(125, 125, 0)${key_bind_physical} Physical Mode :\cr ${player_current_physical|PetDT}
-\cs(125, 125, 0)${key_bind_hybrid} Hybrid Mode :\cr ${player_current_hybrid|Normal}
]]

hub_options_std = [[ \cs(255, 115, 0)======= Options ==========\cr
-\cs(125, 125, 0)${key_bind_auto_maneuver} Auto Maneuver :\cr ${toggle_auto_maneuver|OFF}
-\cs(125, 125, 0)${key_bind_pet_dt} Lock Pet DT Set :\cr ${toggle_lock_pet_dt_set|OFF}
-\cs(125, 125, 0)${key_bind_lock_weapon} Lock Weapon :\cr ${toggle_lock_weapon|OFF}
-\cs(125, 125, 0) Weaponskill FTP :\cr ${toggle_weaponskill_ftp|OFF}
-\cs(125, 125, 0) Custom Gear Lock :\cr ${toggle_custom_gear_lock|OFF}
-\cs(125, 125, 0) Auto Deploy :\cr ${toggle_auto_deploy|OFF}
]]

--[[
    This is the Lite version of the hub setup
    _lte stands for Lite version
]]
hub_pet_info_lte = [[
\cs(255, 115, 0)= Pet Info: \cr- \cs(0, 0, 125)HP :\cr ${pet_current_hp|0}/${pet_max_hp|0}- \cs(0, 125, 0)MP :\cr ${pet_current_mp|0}/${pet_max_mp|0}- \cs(255, 0, 0)TP :\cr ${pet_current_tp|0000|%04d} -- TP/S: ${pet_tp_per_second|0}- \cs(255, 0, 0)WSG Lock:\cr ${ws_gear_lock_timer|0}
]]

hub_pet_skills_lte = ''

hub_state_lte = [[
\cs(255, 115, 0)= State: \cr-\cs(125, 125, 0)${key_bind_pet_mode} Pet Mode :\cr ${pet_current_mode|TANK}-\cs(125, 125, 0)${key_bind_pet_style} Pet Style :\cr ${pet_current_style|NORMAL}-\cs(125, 125, 0)
]]

hub_mode_lte = [[
\cs(255, 115, 0)= Mode: \cr-\cs(125, 125, 0)${key_bind_idle} Idle Mode :\cr ${player_current_idle|Idle}-\cs(125, 125, 0)${key_bind_offense} Offense Mode :\cr ${player_current_offense|MasterPet}-\cs(125, 125, 0)${key_bind_physical} Physical Mode :\cr ${player_current_physical|PetDT}-\cs(125, 125, 0)${key_bind_hybrid} Hybrid Mode :\cr ${player_current_hybrid|Normal}
]]

hub_options_lte = [[
\cs(255, 115, 0)= Options: \cr-\cs(125, 125, 0)${key_bind_auto_maneuver} AutoMan :\cr ${toggle_auto_maneuver|OFF}-\cs(125, 125, 0)${key_bind_pet_dt} \cs(125, 125, 0) AutoDep :\cr ${toggle_auto_deploy|OFF}
]]

-- init style
hub_pet_info = hub_pet_info_std
hub_pet_skills = hub_pet_skills_std
hub_state = hub_state_std
hub_mode = hub_mode_std
hub_options = hub_options_std

-- This handles drawing the Pet Skills for the text box
local function updatePetSkills()
    if not pet.isvalid then
        return
    end

    -- Researching a better way to do this section for now we are doing this old way with concating the different sections
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

    -- Set the Pet Skills section within the HUB
    main_text_hub.current_pet_skills = pet_skills
end

-- Handles updating the Pet Stats for HP/MP/TP
local function updatePetStats()

    -- As long as we have a pet and player is not dead lets update
    if pet.isvalid and player.hpp > 0 then

        main_text_hub.pet_current_hp = tostring(pet.hp)
        main_text_hub.pet_current_mp = tostring(pet.mp)
        main_text_hub.pet_max_hp = tostring(pet.max_hp)
        main_text_hub.pet_max_mp = tostring(pet.max_mp)

        current_pet_tp = pet.tp
        if current_pet_tp ~= nil then
            main_text_hub.pet_current_tp = current_pet_tp
        end
    end

end

--[[
    Used to validate that information in the HUB is up to date
]]
function updateTextInformation()

    -- Updates Pet Info and Pet Skills
    if pet.isvalid then
        updatePetStats()
        updatePetSkills()
    end

    -- State Information
    main_text_hub.pet_current_mode = state.PetModeCycle.current
    main_text_hub.pet_current_style = state.PetStyleCycle.current

    -- Mode Information
    main_text_hub.player_current_idle = state.IdleMode.current
    main_text_hub.player_current_offense = state.OffenseMode.current
    main_text_hub.player_current_physical = state.PhysicalDefenseMode.current
    main_text_hub.player_current_hybrid = state.HybridMode.current

    -- Options Information
    if state.AutoMan.value then
        main_text_hub.toggle_auto_maneuver = const_on
    else
        main_text_hub.toggle_auto_maneuver = const_off
    end

    if state.LockPetDT.value then
        main_text_hub.toggle_lock_pet_dt_set = const_on
    else
        main_text_hub.toggle_lock_pet_dt_set = const_off
    end

    if state.LockWeapon.value then
        main_text_hub.toggle_lock_weapon = const_on
    else
        main_text_hub.toggle_lock_weapon = const_off
    end

    if state.SetFTP.value then
        main_text_hub.toggle_weaponskill_ftp = const_on
    else
        main_text_hub.toggle_weaponskill_ftp = const_off
    end

    if state.CustomGearLock.value then
        main_text_hub.toggle_custom_gear_lock = const_on
    else
        main_text_hub.toggle_custom_gear_lock = const_off
    end

    if state.AutoDeploy.value then
        main_text_hub.toggle_auto_deploy = const_on
    else
        main_text_hub.toggle_auto_deploy = const_off
    end

    if state.Keybinds.value then
        texts.update(main_text_hub, keybinds_on)
    else
        texts.update(main_text_hub, keybinds_off)
    end

    main_text_hub.maneuver_queue = failedManeuvers:length()
    main_text_hub.current_queue = currentManeuvers:length()

end

-- Default To Set Up the Text Window
function setupTextWindow(pos_x, pos_y)
    if main_text_hub ~= nil then
        return
    end

    local default_settings = T {}
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

    -- Creates the initial Text Object will use to create the different sections in
    main_text_hub = texts.new('', default_settings)

    -- Appends the different sections to the main_text_hub
    texts.append(main_text_hub, hub_pet_info)
    texts.append(main_text_hub, hub_pet_skills)
    texts.append(main_text_hub, hub_state)
    texts.append(main_text_hub, hub_mode)
    texts.append(main_text_hub, hub_options)

    -- We then do a quick validation
    updateTextInformation()

    -- Do a quick check if the Light Mode is active.
    if state.useLightMode.value then
        toggleHubStyle()
    end

    -- Finally we show this to the user
    main_text_hub:show()
    hideTextSections()
end

--[[
    This toggle the Hub style
]]
function toggleHubStyle()
    texts.clear(main_text_hub)
    if state.useLightMode.value then
        hud_x_pos = 0
        hud_y_pos = -3
        hud_font_size = 8
        hud_padding = 4
        hud_alpha = 0
        hud_strokewidth = 2
        hub_pet_info = hub_pet_info_lte
        hub_pet_skills = hub_pet_skills_lte
        hub_state = hub_state_lte
        hub_mode = hub_mode_lte
        hub_options = hub_options_lte
    else
        hud_x_pos = pos_x
        hud_y_pos = pos_y
        hud_font_size = 12
        hud_padding = 10
        hud_alpha = 200
        hud_strokewidth = 0
        hub_pet_info = hub_pet_info_std
        hub_pet_skills = hub_pet_skills_std
        hub_state = hub_state_std
        hub_mode = hub_mode_std
        hub_options = hub_options_std
    end
    texts.pos(main_text_hub, hud_x_pos, hud_y_pos)
    texts.size(main_text_hub, hud_font_size)
    texts.pad(main_text_hub, hud_padding)
    texts.bg_alpha(main_text_hub, hud_alpha)
    texts.stroke_width(main_text_hub, hud_strokewidth)

    hideTextSections()
end

--[[
    This handles hiding the different sections
]]
function hideTextSections()

    -- For now when hiding a section its easier to recreate the entire window
    texts.clear(main_text_hub)

    -- Append the different sections need back into the HUB
    texts.append(main_text_hub, hub_pet_info)
    texts.append(main_text_hub, hub_pet_skills)

    -- Below we check to make sure this is true by default these are false
    if not state.textHideState.value then
        texts.append(main_text_hub, hub_state)

    end

    if not state.textHideMode.value then
        texts.append(main_text_hub, hub_mode)

    end

    if not state.textHideOptions.value then
        texts.append(main_text_hub, hub_options)
    end

    if state.textHideHUB.value == true then
        texts.hide(main_text_hub)
    else
        texts.show(main_text_hub)
    end

    updateTextInformation()

end
