-- List used to track the pet TP
track_pet_tp = L {}
-- How many we want to save when figuring out TP/S
max_pet_tp_to_track = 10
-- Keeping track of previous TP passed in
previous_pet_tp = 0

--[[
    This calulates the Pet TP gained Per Second by keeping track
    of a list of Pet TP up to a certain amount
]]
function calculatePetTpPerSec()
    if not pet.isvalid and pet.tp == nil then
        return
    end

    local average_pet_tp = 0
    local current_pet_tp = 0

    -- Capture the current Pet TP at this exact moment
    current_pet_tp = pet.tp

    -- Update the HUB with the current TP we just captured
    main_text_hub.pet_current_tp = current_pet_tp

    -- As long as the TP is above or equal to zero we will use it
    if current_pet_tp >= 0 then

        -- If the Current TP is higher than the Previous TP then we are still gaining TP
        if current_pet_tp > previous_pet_tp then
            -- Appends to the end of the list
            list.append(track_pet_tp, current_pet_tp - previous_pet_tp)
        else -- In the event the Current TP is not greater than the Previous Pet TP means the pet probably just weapon skilled
            list.append(track_pet_tp, 0)
        end

        -- Save the Current TP into previous since we are done with the last saved TP
        previous_pet_tp = current_pet_tp
    end

    if track_pet_tp.n > max_pet_tp_to_track then
        -- Once we have reached max we want to track remove first
        -- Since the append adds to the end of the list
        list.remove(track_pet_tp, 1)
    end

    -- Now lets go through the current list we have
    for i = 1, track_pet_tp.n do
        -- Add up all the current TP stored
        average_pet_tp = average_pet_tp + track_pet_tp[i]
    end

    -- Figure out our TP per second based on max we are tracking
    main_text_hub.pet_tp_per_second = math.floor((average_pet_tp) / max_pet_tp_to_track)

end
