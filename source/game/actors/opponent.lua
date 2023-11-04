--SHOW COMBINED
local SHOW_COMBINED__CARD__PADDING = 15
local SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_COMBINED__CARD__WIDTH = GR__CARD__WIDTH
local SHOW_COMBINED__CARD__HEIGHT = GR__CARD__HEIGHT
local SHOW_COMBINED__CARD__Y = GR__CARD__Y_OPPONENT

--SHOW DRAW
local SHOW_DRAW__CARD__PADDING = SHOW_COMBINED__CARD__PADDING
local SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE = SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE
local SHOW_DRAW__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_DRAW__CARD__HEIGHT = SHOW_COMBINED__CARD__HEIGHT
local SHOW_DRAW__CARD__Y = SHOW_COMBINED__CARD__Y

--SHOW OPPONENT
local SHOW_OPPONENT__CARD__PADDING = SHOW_COMBINED__CARD__PADDING
local SHOW_OPPONENT__CARD__ANIMATE_DURATION__MOVE = SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE
local SHOW_OPPONENT__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_OPPONENT__CARD__HEIGHT = SHOW_COMBINED__CARD__HEIGHT
local SHOW_OPPONENT__CARD__Y = SHOW_COMBINED__CARD__Y

--SHOW DEFAULT
local SHOW_DEFAULT__CARD__ANIMATE_DURATION = DURATION_SHORT
local SHOW_DEFAULT__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_DEFAULT__CARD__HEIGHT = SHOW_COMBINED__CARD__HEIGHT
local SHOW_DEFAULT__CARD__Y = -(SHOW_DEFAULT__CARD__HEIGHT / 2)

CLASS_OPPONENT_NAME = "Opponent"
class(CLASS_OPPONENT_NAME).extends(Hand())

function Opponent:init(board)
    LogTrace(self.className, CLASS_OPPONENT_NAME, "init")

    Opponent.super.init(self, board)
end

function Opponent:dispose()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "dispose")

    Opponent.super.dispose(self)
end

function Opponent:addCard(cardToAdd)
    LogTrace(self.className, CLASS_OPPONENT_NAME, "addCard")

    Opponent.super.addCard(self, cardToAdd)
    cardToAdd.isFront = false
end

function Opponent:showDefaultScene()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "showDefaultScene")

    self:foreachCard(function (card)
        card:build(SHOW_DEFAULT__CARD__WIDTH, SHOW_DEFAULT__CARD__HEIGHT)
        card:animateToY(SHOW_DEFAULT__CARD__ANIMATE_DURATION, SHOW_DEFAULT__CARD__Y)
    end)
end

function Opponent:showCombinedScene()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "showCombinedScene")

    local cardsCount = #self.cards

    if cardsCount > 0 then
        local xDiffrence = 0
        local widthOfCards = SHOW_COMBINED__CARD__WIDTH * cardsCount
        local widthOverflow = (widthOfCards) - (GR__SCREEN__WIDTH - (SHOW_COMBINED__CARD__PADDING * 2))
        local xStart = SHOW_COMBINED__CARD__PADDING + (SHOW_COMBINED__CARD__WIDTH / 2)

        if widthOverflow > 0 then
            xDiffrence = math.max(widthOverflow / (cardsCount - 1), 0)
        else
            xStart = xStart + ((-widthOverflow) / 2)
        end

        self:foreachCard(function (card, index)
            local x = xStart + ((SHOW_COMBINED__CARD__WIDTH - xDiffrence) * (index - 1))

            card:setZIndex(GR__ZINDEX__HIGH + (cardsCount - (index - 1)))
            card:build(SHOW_COMBINED__CARD__WIDTH, SHOW_COMBINED__CARD__HEIGHT)
            card:animateTo(SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE, x, SHOW_COMBINED__CARD__Y)
        end)
    end
end

function Opponent:showDrawScene()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "showDrawScene")

    local cardsCount = #self.cards

    if cardsCount > 0 then
        local xDiffrence = 0
        local widthOfCards = SHOW_DRAW__CARD__WIDTH * cardsCount
        local widthOverflow = (widthOfCards) - (GR__SCREEN__WIDTH - (SHOW_DRAW__CARD__PADDING * 2))
        local xStart = SHOW_DRAW__CARD__PADDING + (SHOW_DRAW__CARD__WIDTH / 2)

        if widthOverflow > 0 then
            xDiffrence = math.max(widthOverflow / (cardsCount - 1), 0)
        else
            xStart = xStart + ((-widthOverflow) / 2)
        end

        self:foreachCard(function (card, index)
            local x = xStart + ((SHOW_DRAW__CARD__WIDTH - xDiffrence) * (index - 1))

            card:setZIndex(GR__ZINDEX__HIGH + (cardsCount - (index - 1)))
            card:build(SHOW_DRAW__CARD__WIDTH, SHOW_DRAW__CARD__HEIGHT)
            card:animateTo(SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE, x, SHOW_DRAW__CARD__Y)
        end)
    end
end

function Opponent:showOpponentScene()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "showOpponentScene")

    local cardsCount = #self.cards

    if cardsCount > 0 then
        local xDiffrence = 0
        local widthOfCards = SHOW_OPPONENT__CARD__WIDTH * cardsCount
        local widthOverflow = (widthOfCards) - (GR__SCREEN__WIDTH - (SHOW_OPPONENT__CARD__PADDING * 2))
        local xStart = SHOW_OPPONENT__CARD__PADDING + (SHOW_OPPONENT__CARD__WIDTH / 2)

        if widthOverflow > 0 then
            xDiffrence = math.max(widthOverflow / (cardsCount - 1), 0)
        else
            xStart = xStart + ((-widthOverflow) / 2)
        end

        self:foreachCard(function (card, index)
            local x = xStart + ((SHOW_OPPONENT__CARD__WIDTH - xDiffrence) * (index - 1))
            local y = SHOW_OPPONENT__CARD__Y

            if card:equals(self.selectedCard) then
                y = y + 25
            end

            card:setZIndex(GR__ZINDEX__HIGH + (cardsCount - (index - 1)))
            card:build(SHOW_OPPONENT__CARD__WIDTH, SHOW_OPPONENT__CARD__HEIGHT)
            card:animateTo(SHOW_OPPONENT__CARD__ANIMATE_DURATION__MOVE, x, y)
        end)
    end

    if self.selectedCard == nil then
        self:addSceneTrigger(100, function ()
            local randomCard = table.random(self.cards)

            self.selectedCard = randomCard
            self:refresh()
        end)
    else
        self:addSceneTrigger(100, function ()
            local canPlaySelectedCard = false
            while canPlaySelectedCard == false do   
                local randomColumn = table.random(self.board.columns)

                self.board:selectColumn(randomColumn)
                canPlaySelectedCard = self:canPlaySelectedCard()
                if canPlaySelectedCard then
                    self:playSelectedCard()
                end
            end
        end)
    end
end

function Opponent:playSelectedCard()
    LogTrace(self.className, CLASS_OPPONENT_NAME, "playSelectedCard")

    Opponent.super.playSelectedCard(self)

    self.selectedCard = nil

    self:addTrigger(function ()
        self.director:setScene(SCENE_TURNOVER)
    end)
end