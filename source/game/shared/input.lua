--Mapping
INPUT_UP = pd.kButtonUp
INPUT_RIGHT = pd.kButtonRight
INPUT_DOWN = pd.kButtonDown
INPUT_LEFT = pd.kButtonLeft
INPUT_ACTION = pd.kButtonA
INPUT_BACK = pd.kButtonB

--Configurations
INPUT_HELD_DELAY = 4

--Bindings
INPUT_COMBINED_SHOW_HAND = INPUT_DOWN
INPUT_COMBINED_SHOW_BOARD = INPUT_UP
INPUT_COMBINED_PLAY_CARD = INPUT_ACTION
INPUT_COMBINED_SELECT_NEXT_CARD = INPUT_RIGHT
INPUT_COMBINED_SELECT_PREVIOUS_CARD = INPUT_LEFT
INPUT_COMBINED_SELECT_NEXT_CARD_HELD_DELAY = INPUT_HELD_DELAY
INPUT_COMBINED_SELECT_PREVIOUS_CARD_HELD_DELAY = INPUT_HELD_DELAY

INPUT_BOARD_SHOW_COMBINED = INPUT_DOWN
INPUT_BOARD_SHOW_STACK_BOTTOM = INPUT_UP
INPUT_BOARD_SHOW_DECK = INPUT_LEFT
INPUT_BOARD_CANCEL_SHOW_COMBINED = INPUT_BACK

INPUT_HAND_SHOW_COMBINED = INPUT_UP
INPUT_HAND_CANCEL_SHOW_COMBINED = INPUT_BACK
INPUT_HAND_PLAY_CARD = INPUT_ACTION
INPUT_HAND_SELECT_NEXT_CARD = INPUT_RIGHT
INPUT_HAND_SELECT_PREVIOUS_CARD = INPUT_LEFT
INPUT_HAND_SELECT_NEXT_CARD_HELD_DELAY = INPUT_HELD_DELAY
INPUT_HAND_SELECT_PREVIOUS_CARD_HELD_DELAY = INPUT_HELD_DELAY

INPUT_DECK_SHOW_BOARD = INPUT_RIGHT
INPUT_DECK_CANCEL_SHOW_COMBINED = INPUT_BACK

INPUT_PLACE_SHOW_COMBINED = INPUT_DOWN
INPUT_PLACE_SHOW_PREVIOUS = INPUT_BACK
INPUT_PLACE_PLAY = INPUT_ACTION
INPUT_PLACE_SELECT_NEXT_COLUMN = INPUT_RIGHT
INPUT_PLACE_SELECT_PREVIOUS_COLUMN = INPUT_LEFT
INPUT_PLACE_SELECT_NEXT_COLUMN_HELD_DELAY = INPUT_HELD_DELAY
INPUT_PLACE_SELECT_PREVIOUS_COLUMN_HELD_DELAY = INPUT_HELD_DELAY

INPUT_STACK_BOTTOM_SHOW_BOARD = INPUT_DOWN
INPUT_STACK_BOTTOM_SHOW_STACK_TOP = INPUT_UP
INPUT_STACK_BOTTOM_CANCEL_SHOW_COMBINED = INPUT_BACK
INPUT_STACK_BOTTOM_SELECT_NEXT_COLUMN = INPUT_RIGHT
INPUT_STACK_BOTTOM_SELECT_PREVIOUS_COLUMN = INPUT_LEFT
INPUT_STACK_BOTTOM_SELECT_NEXT_COLUMN_HELD_DELAY = INPUT_HELD_DELAY
INPUT_STACK_BOTTOM_SELECT_PREVIOUS_COLUMN_HELD_DELAY = INPUT_HELD_DELAY

INPUT_STACK_TOP_SHOW_STACK_BOTTOM = INPUT_DOWN
INPUT_STACK_TOP_CANCEL_SHOW_COMBINED = INPUT_BACK
INPUT_STACK_TOP_SELECT_NEXT_COLUMN = INPUT_RIGHT
INPUT_STACK_TOP_SELECT_PREVIOUS_COLUMN = INPUT_LEFT
INPUT_STACK_TOP_SELECT_NEXT_COLUMN_HELD_DELAY = INPUT_HELD_DELAY
INPUT_STACK_TOP_SELECT_PREVIOUS_COLUMN_HELD_DELAY = INPUT_HELD_DELAY

--Logic
local aButtonHeld = false
local bButtonHeld = false

local upButtonUp = true
local rightButtonUp = true
local downButtonUp = true
local leftButtonUp = true
local aButtonUp = true
local bButtonUp = true

local upButtonMillisecondsStarted = nil
local upButtonHeld = false

local rightButtonMillisecondsStarted = nil
local rightButtonHeld = false

local downButtonMillisecondsStarted = nil
local downButtonHeld = false

local leftButtonMillisecondsStarted = nil
local leftButtonHeld = false

function pressed(input)
    return pd.buttonJustPressed(input)
end

function released(input)
    return pd.buttonJustReleased(input)
end

function down(input)
    return pd.buttonIsPressed(input)
end

function up(input)

    if input == pd.kButtonA then
        return aButtonUp
    elseif input == pd.kButtonB then
        return bButtonUp
    elseif input == pd.kButtonUp then
        return upButtonUp
    elseif input == pd.kButtonRight then
        return rightButtonUp
    elseif input == pd.kButtonDown then
        return downButtonUp
    elseif input == pd.kButtonLeft then
        return leftButtonUp
    end
end

local tick = 0

function held(input, delay)
    local held = nil

    if input == pd.kButtonA then
        held = aButtonHeld
    elseif input == pd.kButtonB then
        held = bButtonHeld
    elseif input == pd.kButtonUp then
        held = upButtonHeld
    elseif input == pd.kButtonRight then
        held = rightButtonHeld
    elseif input == pd.kButtonDown then
        held = downButtonHeld
    elseif input == pd.kButtonLeft then
        held = leftButtonHeld
    end

    if held ~= nil and held == true and delay ~= nil then
        local isDelayed = true

        if delay ~= nil then

            if tick % delay == 0 then
                isDelayed = true
            else
                isDelayed = false
            end
        end

        return isDelayed
    end

    return held
end

function inputUpdate()
    local current, _, _ = pd.getButtonState()
    local currentTimeMilliseconds = pd.getCurrentTimeMilliseconds()

    tick = tick + 1

    if current == pd.kButtonUp then

        if upButtonMillisecondsStarted == nil then
            upButtonMillisecondsStarted = currentTimeMilliseconds
        elseif currentTimeMilliseconds - upButtonMillisecondsStarted >= 1000 then
            upButtonHeld = true
        end
    else
        upButtonMillisecondsStarted = nil
        upButtonHeld = false
    end

    if current == pd.kButtonRight then

        if rightButtonMillisecondsStarted == nil then
            rightButtonMillisecondsStarted = currentTimeMilliseconds
        elseif currentTimeMilliseconds - rightButtonMillisecondsStarted >= 1000 then
            rightButtonHeld = true
        end
    else
        rightButtonMillisecondsStarted = nil
        rightButtonHeld = false
    end

    if current == pd.kButtonDown then

        if downButtonMillisecondsStarted == nil then
            downButtonMillisecondsStarted = currentTimeMilliseconds
        elseif currentTimeMilliseconds - downButtonMillisecondsStarted >= 1000 then
            downButtonHeld = true
        end
    else
        downButtonMillisecondsStarted = nil
        downButtonHeld = false
    end

    if current == pd.kButtonLeft then

        if leftButtonMillisecondsStarted == nil then
            leftButtonMillisecondsStarted = currentTimeMilliseconds
        elseif currentTimeMilliseconds - leftButtonMillisecondsStarted >= 1000 then
            leftButtonHeld = true
        end
    else
        leftButtonMillisecondsStarted = nil
        leftButtonHeld = false
    end
end

function pd.AButtonHeld()
    aButtonHeld = true
end
function pd.AButtonUp()
    aButtonHeld = false
    aButtonUp = true
end
function pd.AButtonDown()
    aButtonUp = false
end

function pd.BButtonHeld()
    bButtonHeld = true
end
function pd.BButtonUp()
    bButtonHeld = false
    bButtonUp = true
end
function pd.BButtonDown()
    bButtonUp = false
end

function pd.upButtonUp()
    upButtonUp = true
end
function pd.upButtonDown()
    upButtonUp = false
end

function pd.rightButtonUp()
    rightButtonUp = true
end
function pd.rightButtonDown()
    rightButtonUp = false
end

function pd.downButtonUp()
    downButtonUp = true
end
function pd.downButtonDown()
    downButtonUp = false
end

function pd.leftButtonUp()
    leftButtonUp = true
end
function pd.leftButtonDown()
    leftButtonUp = false
end