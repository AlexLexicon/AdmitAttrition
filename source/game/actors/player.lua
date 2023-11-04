--INIT
local PLAYER__INIT__LABEL__PADDING = 15
local PLAYER__INIT__LABEL__WIDTH = GR__SCREEN__WIDTH - (PLAYER__INIT__LABEL__PADDING * 2)
local PLAYER__INIT__LABEL__HEIGHT = GR__SCREEN__HEIGHT - (PLAYER__INIT__LABEL__PADDING * 2)
local PLAYER__INIT__LABEL__X = GR__SCREEN__X_CENTER
local PLAYER__INIT__LABEL__Y = GR__SCREEN__HEIGHT + (PLAYER__INIT__LABEL__HEIGHT / 2)

--SHOW BEFORE
local PLAYER__SHOW_BEFORE__LABEL__ANIMATE_DURATION = DURATION_MEDIUM
local PLAYER__SHOW_BEFORE__LABEL__X = PLAYER__INIT__LABEL__X
local PLAYER__SHOW_BEFORE__LABEL__Y = PLAYER__INIT__LABEL__Y

--SHOW COMBINED
local PLAYER__SHOW_COMBINED__CARD__PADDING = 15
local PLAYER__SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local PLAYER__SHOW_COMBINED__CARD__ANIMATE_DURATION__SELECTED = DURATION_SHORT
local PLAYER__SHOW_COMBINED__CARD__WIDTH = GR__CARD__WIDTH
local PLAYER__SHOW_COMBINED__CARD__HEIGHT = GR__CARD__HEIGHT
local PLAYER__SHOW_COMBINED__CARD__HEIGHT_SELECTED = Card.getNumberHeight(PLAYER__SHOW_COMBINED__CARD__WIDTH)
local PLAYER__SHOW_COMBINED__CARD__Y = GR__CARD__Y_PLAYER
local PLAYER__SHOW_COMBINED__CARD__Y_SELECTED = PLAYER__SHOW_COMBINED__CARD__Y - PLAYER__SHOW_COMBINED__CARD__HEIGHT_SELECTED

--SHOW DEFAULT
local PLAYER__SHOW_DEFAULT__CARD__ANIMATE_DURATION = DURATION_SHORT
local PLAYER__SHOW_DEFAULT__CARD__WIDTH = PLAYER__SHOW_COMBINED__CARD__WIDTH
local PLAYER__SHOW_DEFAULT__CARD__HEIGHT = PLAYER__SHOW_COMBINED__CARD__HEIGHT
local PLAYER__SHOW_DEFAULT__CARD__Y = GR__SCREEN__HEIGHT + (PLAYER__SHOW_DEFAULT__CARD__HEIGHT / 2)

--SHOW HAND
local PLAYER__SHOW_HAND__LABEL__ANIMATE_DURATION = DURATION_MEDIUM
local PLAYER__SHOW_HAND__LABEL__X = GR__SCREEN__X_CENTER
local PLAYER__SHOW_HAND__LABEL__Y = GR__SCREEN__Y_CENTER

local PLAYER__SHOW_HAND__CARD__PADDING = 15
local PLAYER__SHOW_HAND__CARD__ANIMATE_DURATION = DURATION_SHORT
local PLAYER__SHOW_HAND__CARD__HEIGHT = GR__SCREEN__HEIGHT - (PLAYER__SHOW_HAND__CARD__PADDING * 2)
local PLAYER__SHOW_HAND__CARD__WIDTH = (2.5 * PLAYER__SHOW_HAND__CARD__HEIGHT) / 3.5
local PLAYER__SHOW_HAND__CARD__HEIGHT_SELECTED = GR__SCREEN__HEIGHT - PLAYER__SHOW_HAND__CARD__PADDING
local PLAYER__SHOW_HAND__CARD__WIDTH_SELECTED = (2.5 * PLAYER__SHOW_HAND__CARD__HEIGHT) / 3.5
local PLAYER__SHOW_HAND__CARD__SYMBOL_REGION__WIDTH = Card.getSymbolRegionWidth(PLAYER__SHOW_HAND__CARD__WIDTH)
local PLAYER__SHOW_HAND__CARD__Y = GR__SCREEN__Y_CENTER

--SHOW PLACE
local PLAYER__SHOW_PLACE__CARD__ANIMATE_DURATION = DURATION_SHORT
local PLAYER__SHOW_PLACE__CARD__WIDTH = PLAYER__SHOW_COMBINED__CARD__WIDTH
local PLAYER__SHOW_PLACE__CARD__HEIGHT = PLAYER__SHOW_COMBINED__CARD__HEIGHT
local PLAYER__SHOW_PLACE__CARD__X_LEFT = PLAYER__SHOW_HAND__CARD__PADDING + (PLAYER__SHOW_HAND__CARD__WIDTH / 2)
local PLAYER__SHOW_PLACE__CARD__X_RIGHT = GR__SCREEN__WIDTH - PLAYER__SHOW_HAND__CARD__PADDING - (PLAYER__SHOW_HAND__CARD__WIDTH / 2)
local PLAYER__SHOW_PLACE__CARD__Y = GR__SCREEN__HEIGHT + (PLAYER__SHOW_HAND__CARD__HEIGHT / 2)
local PLAYER__SHOW_PLACE__CARD__Y_SELECTED = PLAYER__SHOW_COMBINED__CARD__Y_SELECTED

--SHOW DRAW
local PLAYER__SHOW_DRAW__CARD__PADDING = PLAYER__SHOW_COMBINED__CARD__PADDING
local PLAYER__SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE = PLAYER__SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE
local PLAYER__SHOW_DRAW__CARD__WIDTH = PLAYER__SHOW_COMBINED__CARD__WIDTH
local PLAYER__SHOW_DRAW__CARD__HEIGHT = PLAYER__SHOW_COMBINED__CARD__HEIGHT
local PLAYER__SHOW_DRAW__CARD__Y = PLAYER__SHOW_COMBINED__CARD__Y

CLASS_PLAYER_NAME = "Player"
class(CLASS_PLAYER_NAME).extends(Hand())

function Player:init(board)
    LogTrace(self.className, CLASS_PLAYER_NAME, "init")

    Player.super.init(self, board)

    self.board:onColumnSelected(function (_, columnsOnRight, columnsOnLeft)
        self.placeCardRight = columnsOnRight > columnsOnLeft
        self:refresh()
    end)

    self.label = Label(0)
    self.nextSelectedCard = nil
    self.previousSelectedCard = nil
    self.placeCardRight = true

    self.label:build(PLAYER__INIT__LABEL__WIDTH, PLAYER__INIT__LABEL__HEIGHT, VERBAGE__PLAYER__LABEL)
    self.label:moveTo(PLAYER__INIT__LABEL__X, PLAYER__INIT__LABEL__Y)
end

function Player:dispose()
    LogTrace(self.className, CLASS_PLAYER_NAME, "dispose")

    Player.super.dispose(self)

    self.label:dispose()
end

--do something about this one
function Player:getPlaceCardRightX()
    LogTrace(self.className, CLASS_PLAYER_NAME, "getPlaceCardRightX")

    if self.placeCardRight then
        return PLAYER__SHOW_PLACE__CARD__X_RIGHT
    else
        return PLAYER__SHOW_PLACE__CARD__X_LEFT
    end
end

function Player:addCard(cardToAdd)
    LogTrace(self.className, CLASS_PLAYER_NAME, "addCard")

    Player.super.addCard(self, cardToAdd)

    self:selectCard(cardToAdd)
end

function Player:selectNextCard()
    LogTrace(self.className, CLASS_PLAYER_NAME, "selectNextCard")

    self:selectCard(self.nextSelectedCard)
end

function Player:selectPreviousCard()
    LogTrace(self.className, CLASS_PLAYER_NAME, "selectPreviousCard")

    self:selectCard(self.previousSelectedCard)
end

function Player:selectCard(cardToSelect)
    LogTrace(self.className, CLASS_PLAYER_NAME, "selectCard")

    local firstCard = nil
    local lastCard = nil
    local isLastSelected = false

    self.selectedCard = nil
    self.nextSelectedCard = nil
    self.previousSelectedCard = nil

    self:foreachCard(function (card)
        local isSelected = card:equals(cardToSelect)

        if firstCard == nil then
            firstCard = card
        end

        if isLastSelected then
            isLastSelected = false

            self.nextSelectedCard = card
        end

        if isSelected then
            isLastSelected = true

            self.selectedCard = card
            self.previousSelectedCard = lastCard
        end

        card:setIsSelected(isSelected)
        lastCard = card
    end)

    if cardToSelect ~= nil and self.selectedCard == nil then
        throw("The provided 'cardToSelect' was not found in the cards table.")
    end

    if self.nextSelectedCard == nil then
        self.nextSelectedCard = firstCard
    end

    if self.previousSelectedCard == nil then
        self.previousSelectedCard = lastCard
    end
end

function Player:beforeShowScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showScene")

    self.label:animateTo(PLAYER__SHOW_BEFORE__LABEL__ANIMATE_DURATION, PLAYER__SHOW_BEFORE__LABEL__X, PLAYER__SHOW_BEFORE__LABEL__Y)
end

function Player:showDefaultScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showDefaultScene")

    self:foreachCard(function (card)
        card:build(PLAYER__SHOW_DEFAULT__CARD__WIDTH, PLAYER__SHOW_DEFAULT__CARD__HEIGHT)
        card:animateToY(PLAYER__SHOW_DEFAULT__CARD__ANIMATE_DURATION, PLAYER__SHOW_DEFAULT__CARD__Y)
    end)
end

function Player:showCombinedScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showCombinedScene")

    local cardsCount = #self.cards

    if cardsCount > 0 then
        local xDiffrence = 0
        local widthOfCards = PLAYER__SHOW_COMBINED__CARD__WIDTH * cardsCount
        local widthOverflow = (widthOfCards) - (GR__SCREEN__WIDTH - (PLAYER__SHOW_COMBINED__CARD__PADDING * 2))
        local xStart = PLAYER__SHOW_COMBINED__CARD__PADDING + (PLAYER__SHOW_COMBINED__CARD__WIDTH / 2)

        if widthOverflow > 0 then
            xDiffrence = math.max(widthOverflow / (cardsCount - 1), 0)
        else
            xStart = xStart + ((-widthOverflow) / 2)
        end

        if self.selectedCard == nil then
            self:selectCard(self.cards[1])
        end

        self:foreachCard(function (card, index)
            local x = xStart + ((PLAYER__SHOW_COMBINED__CARD__WIDTH - xDiffrence) * (index - 1))
            local y = PLAYER__SHOW_COMBINED__CARD__Y

            if card.isSelected then
                y = PLAYER__SHOW_COMBINED__CARD__Y_SELECTED
            end

            card:setZIndex(GR__ZINDEX__HIGH + index)
            card:build(PLAYER__SHOW_COMBINED__CARD__WIDTH, PLAYER__SHOW_COMBINED__CARD__HEIGHT)

            card:animateTo(PLAYER__SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE, x, y)
            card:setSelectionSceneEvent(self, function (isSelected)
                local ySelection = PLAYER__SHOW_COMBINED__CARD__Y

                if isSelected then
                    ySelection = PLAYER__SHOW_COMBINED__CARD__Y_SELECTED
                end

                card:animateToY(PLAYER__SHOW_COMBINED__CARD__ANIMATE_DURATION__SELECTED, ySelection)
            end)
        end)
    end
end

function Player:showHandScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showHandScene")

    local cardsCount = #self.cards

    if cardsCount <= 0 then
        --if there are no cards in the hand then show a message to the player to make that clear
        self.label:animateTo(PLAYER__SHOW_HAND__LABEL__ANIMATE_DURATION, PLAYER__SHOW_HAND__LABEL__X, PLAYER__SHOW_HAND__LABEL__Y)
    else
        local selectedIndex = 0

        local maxIndex = cardsCount + 1
        local reverseIndex = nil

        self:foreachCard(function (card, index)
            local width = PLAYER__SHOW_HAND__CARD__WIDTH
            local height = PLAYER__SHOW_HAND__CARD__HEIGHT
            local zIndex = index

            if reverseIndex ~= nil then
                zIndex = reverseIndex
                reverseIndex = reverseIndex - 1
            end

            if card.isSelected then
                width = PLAYER__SHOW_HAND__CARD__WIDTH_SELECTED
                height = PLAYER__SHOW_HAND__CARD__HEIGHT_SELECTED
                zIndex = maxIndex
                reverseIndex = maxIndex - 1
                selectedIndex = index
            end

            card:build(width, height)
            card:setZIndex(GR__ZINDEX__HIGH + zIndex)
            card:setSelectionSceneEvent(self, function (isSelected)
                local widthSelected = PLAYER__SHOW_HAND__CARD__WIDTH
                local heightSelected = PLAYER__SHOW_HAND__CARD__HEIGHT

                if isSelected then
                    widthSelected = PLAYER__SHOW_HAND__CARD__WIDTH_SELECTED
                    heightSelected = PLAYER__SHOW_HAND__CARD__HEIGHT_SELECTED
                end

                card:build(widthSelected, heightSelected)
                self:refresh()
            end)
        end)

        local offset = (selectedIndex * PLAYER__SHOW_HAND__CARD__SYMBOL_REGION__WIDTH) - GR__SCREEN__X_CENTER

        self:foreachCard(function (card, index)
            local x = (index * PLAYER__SHOW_HAND__CARD__SYMBOL_REGION__WIDTH) - offset

            card:animateTo(PLAYER__SHOW_HAND__CARD__ANIMATE_DURATION, x, PLAYER__SHOW_HAND__CARD__Y)
        end)
    end
end

function Player:showPlaceScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showPlaceScene")

    self:foreachCard(function (card)
        local x = card.x
        local y = PLAYER__SHOW_PLACE__CARD__Y

        if card.isSelected then
            x = self:getPlaceCardRightX()
            y = PLAYER__SHOW_PLACE__CARD__Y_SELECTED
        end

        card:build(PLAYER__SHOW_PLACE__CARD__WIDTH, PLAYER__SHOW_PLACE__CARD__HEIGHT)
        card:animateTo(PLAYER__SHOW_PLACE__CARD__ANIMATE_DURATION, x, y)
    end)
end

function Player:showDrawScene()
    LogTrace(self.className, CLASS_PLAYER_NAME, "showDrawScene")

    local cardsCount = #self.cards

    if cardsCount > 0 then
        local xDiffrence = 0
        local widthOfCards = PLAYER__SHOW_DRAW__CARD__WIDTH * cardsCount
        local widthOverflow = (widthOfCards) - (GR__SCREEN__WIDTH - (PLAYER__SHOW_DRAW__CARD__PADDING * 2))
        local xStart = PLAYER__SHOW_DRAW__CARD__PADDING + (PLAYER__SHOW_DRAW__CARD__WIDTH / 2)

        if widthOverflow > 0 then
            xDiffrence = math.max(widthOverflow / (cardsCount - 1), 0)
        else
            xStart = xStart + ((-widthOverflow) / 2)
        end

        self:foreachCard(function (card, index)
            local x = xStart + ((PLAYER__SHOW_DRAW__CARD__WIDTH - xDiffrence) * (index - 1))

            card:setZIndex(GR__ZINDEX__HIGH + index)
            card:build(PLAYER__SHOW_DRAW__CARD__WIDTH, PLAYER__SHOW_DRAW__CARD__HEIGHT)
            card:animateTo(PLAYER__SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE, x, PLAYER__SHOW_DRAW__CARD__Y)
        end)
    end
end

function Player:addCard(cardToAdd)
    LogTrace(self.className, CLASS_PLAYER_NAME, "addCard")

    Player.super.addCard(self, cardToAdd)

    self:selectCard(cardToAdd)
end

function Player:canPlaceSelectedCard()
    LogTrace(self.className, CLASS_HAND_NAME, "canPlaceSelectedCard")

    local cardsCount = #self.cards
    local hasAtLeastOneCard = cardsCount > 0
    local selectedCardIsNotNil = self.selectedCard ~= nil

    if hasAtLeastOneCard == false then
        logWarning("The hand does not have at least one card.")
    end

    if selectedCardIsNotNil == false then
        logWarning("The selected card is not nil.")
        return false
    end

    return true
end

function Player:playSelectedCard()
    LogTrace(self.className, CLASS_PLAYER_NAME, "playSelectedCard")

    Player.super.playSelectedCard(self)

    self:selectCard(nil)

    self:addTrigger(function ()
        self.director:setScene(SCENE_OPPONENT)
    end)
end