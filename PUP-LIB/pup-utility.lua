-- Prints to the screen in a certain format
function msg(str)
    send_command("@input /echo *-*-*-* " .. str .. " *-*-*-*")
end

-- Traverses a table to see if it contains the given element
function table.contains(table, element)
    for _, value in pairs(table) do
        if string.lower(value) == string.lower(element) then
            return true
        end
    end
    return false
end

-- Takes a condition and returns a given value based on if it is true or false
function ternary(cond, T, F)
    if cond then
        return T
    else
        return F
    end
end

-- Dump the contents of a table
function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end

            if type(k) ~= "number" and (k:contains("_raw") or k:contains("_data")) then
                s = s .. "[" .. k .. "] = " .. 'binaray' .. ",\n"
            else
                s = s .. "[" .. k .. "] = " .. dump(v) .. ",\n"
            end
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

-- Attempts to determine the Puppet Mode and Style
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

    -- This is based mostly off of the frames from String Theory (most are present, may be missing some)
    -- https://www.bg-wiki.com/bg/String_Theory#Automaton_Frame_Setups

    -- Determine Pet Mode and Style based on Head, Frame, and Attachments.
    -- Uses handle_set to apply the determined mode and style to Gearswap states.

    -- Harlequin Head Predictions
    if head == HarHead then
        if frame == HarFrame and (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then
            -- Harlequin Head + Harlequin Frame + Strobe/Flashbulb = Magic Tank
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "MAGIC"})
        elseif frame == HarFrame then
            -- Harlequin Head + Harlequin Frame (no specific enmity attachments) = Default DD Normal
            handle_set({const_PetModeCycle, const_dd})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            -- Unknown combination for Harlequin Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
        -- Valoredge Head Predictions
    elseif head == ValHead then
        if frame == SharpFrame then
            if (pet.attachments.strobe == true or pet.attachments.flashbulb == true) then
                -- Valoredge Head + Sharpshot Frame + Strobe/Flashbulb = DD Tank
                handle_set({const_PetModeCycle, const_tank})
                handle_set({const_PetStyleCycle, const_dd})
            else
                -- Valoredge Head + Sharpshot Frame (no specific enmity attachments) = Default DD Normal
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            end
        elseif frame == ValFrame then
            if pet.attachments.inhibitor == true or pet.attachments.attuner == true and
                (not pet.attachments.strobe or not pet.attachments['strobe ii']) then
                -- Valoredge Head + Valoredge Frame + Inhibitor/Attuner (and no Strobe) = Bone Slayer DD
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "BONE"})
            else
                -- Valoredge Head + Valoredge Frame (default) = Standard Tank Normal
                handle_set({const_PetModeCycle, const_tank})
                handle_set({const_PetStyleCycle, "NORMAL"})
            end
        else
            -- Unknown combination for Valoredge Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
        -- Sharpshot Head Predictions
    elseif head == SharpHead then
        if frame == SharpFrame then
            if (pet.attachments.inhibitor == true or pet.attachments["inhibitor II"] == true) then
                -- Sharpshot Head + Sharpshot Frame + Inhibitor I/II = Normal DD (likely for accuracy/ranged focus)
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "NORMAL"})
            else
                -- Sharpshot Head + Sharpshot Frame (no inhibitor) = SPAM DD (likely for faster WS)
                handle_set({const_PetModeCycle, const_dd})
                handle_set({const_PetStyleCycle, "SPAM"})
            end
        else
            -- Unknown combination for Sharpshot Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
        -- Stormwaker Head Predictions
    elseif head == StormHead then
        if frame == StormFrame then
            -- Stormwaker Head + Stormwaker Frame = Support Mage (RDM-like)
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "SUPPORT"})
        else
            -- Unknown combination for Stormwaker Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
        -- Soulsoother Head Predictions
    elseif head == SoulHead then
        if frame == StormFrame then
            -- Soulsoother Head + Stormwaker Frame = Healing Mage (WHM-like)
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, "HEAL"})
        elseif frame == ValFrame then
            -- Soulsoother Head + Valoredge Frame = Turtle Tank (defensive tank)
            handle_set({const_PetModeCycle, const_tank})
            handle_set({const_PetStyleCycle, "NORMAL"})
        else
            -- Unknown combination for Soulsoother Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
        -- Spiritreaver Head Predictions
    elseif head == SpiritHead then
        if frame == StormFrame then
            -- Spiritreaver Head + Stormwaker Frame = DD Mage (BLM-like)
            handle_set({const_PetModeCycle, const_mage})
            handle_set({const_PetStyleCycle, const_dd})
        else
            -- Unknown combination for Spiritreaver Head
            msg("Unable to determine Mode/Style for Puppet Head: (" .. head .. ") Puppet Frame: (" .. frame .. ")")
        end
    end
end
