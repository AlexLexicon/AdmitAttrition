--INIT
local INIT__LABEL__BORDER = GR__COLUMN__BORDER_THICKNESS
local INIT__LABEL__BORDER_TOP = { [TOP] = INIT__LABEL__BORDER, [RIGHT] = INIT__LABEL__BORDER, [BOTTOM] = 0, [LEFT] = INIT__LABEL__BORDER }
local INIT__LABEL__BORDER_BOTTOM = { [TOP] = 0, [RIGHT] = INIT__LABEL__BORDER, [BOTTOM] = INIT__LABEL__BORDER, [LEFT] = INIT__LABEL__BORDER }
local INIT__LABEL__WIDTH = GR__COLUMN__WIDTH
local INIT__LABEL__HEIGHT = (GR__COLUMN__HEIGHT_BOTH - GR__COLUMN__BLOCK__HEIGHT) / 2

--SHOW COMBINED
local SHOW_COMBINED__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_COMBINED__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_COMBINED__LABEL__HEIGHT = INIT__LABEL__HEIGHT

local SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_COMBINED__CARD__PADDING = 2
local SHOW_COMBINED__CARD__WIDTH = GR__COLUMN__WIDTH - (INIT__LABEL__BORDER * 2) - (SHOW_COMBINED__CARD__PADDING * 2)
local SHOW_COMBINED__CARD__HEIGHT = (SHOW_COMBINED__LABEL__HEIGHT - (SHOW_COMBINED__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1)) - INIT__LABEL__BORDER) / STACK_MAXIMUM_CARD_COUNT
local SHOW_COMBINED__CARD__HEIGHT_AND_PADDING = SHOW_COMBINED__CARD__HEIGHT + SHOW_COMBINED__CARD__PADDING
local SHOW_COMBINED__CARD__Y_START = (SHOW_COMBINED__CARD__HEIGHT / 2) + SHOW_COMBINED__CARD__PADDING - (SHOW_COMBINED__LABEL__HEIGHT / 2)

--SHOW BOARD
local SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_BOARD__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_BOARD__LABEL__HEIGHT = (GR__SCREEN__HEIGHT - (GR__COLUMN__PADDING * 2) - GR__COLUMN__BLOCK__HEIGHT) / 2

local SHOW_BOARD__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_BOARD__CARD__PADDING = 2
local SHOW_BOARD__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_BOARD__CARD__HEIGHT = (SHOW_BOARD__LABEL__HEIGHT - (SHOW_BOARD__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1)) - INIT__LABEL__BORDER) / STACK_MAXIMUM_CARD_COUNT
local SHOW_BOARD__CARD__HEIGHT_AND_PADDING = SHOW_BOARD__CARD__HEIGHT + SHOW_BOARD__CARD__PADDING
local SHOW_BOARD__CARD__Y_START = (SHOW_BOARD__CARD__HEIGHT / 2) + SHOW_BOARD__CARD__PADDING - (SHOW_BOARD__LABEL__HEIGHT / 2)

--SHOW PLACE
local SHOW_PLACE__LABEL__ANIMATE_DURATION__MOVE = SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE
local SHOW_PLACE__LABEL__WIDTH = SHOW_BOARD__LABEL__WIDTH
local SHOW_PLACE__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT

local SHOW_PLACE__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_PLACE__CARD__PADDING = 2
local SHOW_PLACE__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_PLACE__CARD__HEIGHT = (SHOW_PLACE__LABEL__HEIGHT - (SHOW_PLACE__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1)) - INIT__LABEL__BORDER) / STACK_MAXIMUM_CARD_COUNT
local SHOW_PLACE__CARD__HEIGHT_AND_PADDING = SHOW_PLACE__CARD__HEIGHT + SHOW_PLACE__CARD__PADDING
local SHOW_PLACE__CARD__Y_START = (SHOW_PLACE__CARD__HEIGHT / 2) + SHOW_PLACE__CARD__PADDING - (SHOW_PLACE__LABEL__HEIGHT / 2)

--SHOW DECK
local SHOW_DECK__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DECK__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DECK__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT
local SHOW_DECK__LABEL__X = GR__SCREEN__WIDTH + (GR__COLUMN__WIDTH / 2)

local SHOW_DECK__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DECK__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_DECK__CARD__HEIGHT = SHOW_COMBINED__CARD__HEIGHT
local SHOW_DECK__CARD__X = GR__SCREEN__WIDTH + (SHOW_DECK__CARD__WIDTH / 2)

--SHOW STACK BOTTOM
local SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_BOTTOM__LABEL__PADDING = 15
local SHOW_STACK_BOTTOM__LABEL__WIDTH = GR__SCREEN__WIDTH - (SHOW_STACK_BOTTOM__LABEL__PADDING * 2)
local SHOW_STACK_BOTTOM__LABEL__HEIGHT = GR__SCREEN__HEIGHT - GR__COLUMN__BLOCK__HEIGHT - (SHOW_STACK_BOTTOM__LABEL__PADDING * 2)
local SHOW_STACK_BOTTOM__LABEL__Y = SHOW_STACK_BOTTOM__LABEL__PADDING + GR__COLUMN__BLOCK__HEIGHT + (SHOW_STACK_BOTTOM__LABEL__HEIGHT / 2)
local SHOW_STACK_BOTTOM__LABEL__Y_TOP = -(math.ceil(SHOW_STACK_BOTTOM__LABEL__HEIGHT / 2))

local SHOW_STACK_BOTTOM__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_BOTTOM__CARD__PADDING = 5
local SHOW_STACK_BOTTOM__CARD__WIDTH = (SHOW_STACK_BOTTOM__LABEL__WIDTH - (SHOW_STACK_BOTTOM__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1))) / STACK_MAXIMUM_CARD_COUNT
local SHOW_STACK_BOTTOM__CARD__HEIGHT = SHOW_STACK_BOTTOM__LABEL__HEIGHT - (SHOW_STACK_BOTTOM__CARD__PADDING * 2)
local SHOW_STACK_BOTTOM__CARD__X_START = (SHOW_STACK_BOTTOM__CARD__WIDTH / 2) + SHOW_STACK_BOTTOM__CARD__PADDING

--SHOW STACK TOP
local SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_TOP__LABEL__PADDING = 15
local SHOW_STACK_TOP__LABEL__WIDTH = GR__SCREEN__WIDTH - (SHOW_STACK_TOP__LABEL__PADDING * 2)
local SHOW_STACK_TOP__LABEL__HEIGHT = GR__SCREEN__HEIGHT - GR__COLUMN__BLOCK__HEIGHT - (SHOW_STACK_TOP__LABEL__PADDING * 2)
local SHOW_STACK_TOP__LABEL__Y = SHOW_STACK_TOP__LABEL__PADDING + (SHOW_STACK_TOP__LABEL__HEIGHT / 2)
local SHOW_STACK_TOP__LABEL__Y_BOTTOM = GR__SCREEN__HEIGHT + (math.ceil(SHOW_STACK_TOP__LABEL__HEIGHT / 2))

local SHOW_STACK_TOP__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_TOP__CARD__PADDING = 5
local SHOW_STACK_TOP__CARD__WIDTH = (SHOW_STACK_TOP__LABEL__WIDTH - (SHOW_STACK_TOP__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1))) / STACK_MAXIMUM_CARD_COUNT
local SHOW_STACK_TOP__CARD__HEIGHT = SHOW_STACK_TOP__LABEL__HEIGHT - (SHOW_STACK_TOP__CARD__PADDING * 2)
local SHOW_STACK_TOP__CARD__X_START = (SHOW_STACK_TOP__CARD__WIDTH / 2) + SHOW_STACK_TOP__CARD__PADDING

--SHOW DRAW
local SHOW_DRAW__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DRAW__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DRAW__LABEL__HEIGHT = INIT__LABEL__HEIGHT

local SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DRAW__CARD__PADDING = 2
local SHOW_DRAW__CARD__WIDTH = GR__COLUMN__WIDTH - (INIT__LABEL__BORDER * 2) - (SHOW_DRAW__CARD__PADDING * 2)
local SHOW_DRAW__CARD__HEIGHT = (SHOW_DRAW__LABEL__HEIGHT - (SHOW_DRAW__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1)) - INIT__LABEL__BORDER) / STACK_MAXIMUM_CARD_COUNT
local SHOW_DRAW__CARD__HEIGHT_AND_PADDING = SHOW_DRAW__CARD__HEIGHT + SHOW_DRAW__CARD__PADDING
local SHOW_DRAW__CARD__Y_START = (SHOW_DRAW__CARD__HEIGHT / 2) + SHOW_DRAW__CARD__PADDING - (SHOW_DRAW__LABEL__HEIGHT / 2)

--SHOW OPPONENT
local SHOW_OPPONENT__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_OPPONENT__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_OPPONENT__LABEL__HEIGHT = (GR__COLUMN__HEIGHT_OPPONENT - GR__COLUMN__BLOCK__HEIGHT) / 2

local SHOW_OPPONENT__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_OPPONENT__CARD__PADDING = 2
local SHOW_OPPONENT__CARD__WIDTH = GR__COLUMN__WIDTH - (INIT__LABEL__BORDER * 2) - (SHOW_OPPONENT__CARD__PADDING * 2)
local SHOW_OPPONENT__CARD__HEIGHT = (SHOW_OPPONENT__LABEL__HEIGHT - (SHOW_OPPONENT__CARD__PADDING * (STACK_MAXIMUM_CARD_COUNT + 1)) - INIT__LABEL__BORDER) / STACK_MAXIMUM_CARD_COUNT
local SHOW_OPPONENT__CARD__HEIGHT_AND_PADDING = SHOW_OPPONENT__CARD__HEIGHT + SHOW_OPPONENT__CARD__PADDING
local SHOW_OPPONENT__CARD__Y_START = (SHOW_OPPONENT__CARD__HEIGHT / 2) + SHOW_OPPONENT__CARD__PADDING - (SHOW_OPPONENT__LABEL__HEIGHT / 2)

--SHOW GAME OVER
local SHOW_GAME_OVER__LABEL__ANIMATE_DURATION__MOVE = SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE
local SHOW_GAME_OVER__LABEL__WIDTH = SHOW_BOARD__LABEL__WIDTH
local SHOW_GAME_OVER__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT

local SHOW_GAME_OVER__CARD__ANIMATE_DURATION__MOVE = SHOW_BOARD__CARD__ANIMATE_DURATION__MOVE
local SHOW_GAME_OVER__CARD__WIDTH = SHOW_BOARD__CARD__WIDTH
local SHOW_GAME_OVER__CARD__HEIGHT = SHOW_BOARD__CARD__HEIGHT
local SHOW_GAME_OVER__CARD__HEIGHT_AND_PADDING = SHOW_BOARD__CARD__HEIGHT_AND_PADDING
local SHOW_GAME_OVER__CARD__Y_START = SHOW_BOARD__CARD__Y_START

--SHOW DEFAULT
local SHOW_DEFAULT__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DEFAULT__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DEFAULT__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT
local SHOW_DEFAULT__LABEL__Y = -(GR__COLUMN__HEIGHT_BOTH / 2)

local SHOW_DEFAULT__CARD__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DEFAULT__CARD__WIDTH = SHOW_COMBINED__CARD__WIDTH
local SHOW_DEFAULT__CARD__HEIGHT = SHOW_COMBINED__CARD__HEIGHT
local SHOW_DEFAULT__CARD__Y = -(SHOW_DECK__CARD__WIDTH / 2)

CLASS_STACK_NAME = "Stack"
class(CLASS_STACK_NAME).extends(Actor())

function Stack:init(region, canWin)
    LogTrace(self.className, CLASS_STACK_NAME, "init")

    Stack.super.init(self)

    local border

    if canWin == false then
        border = 0
    elseif region == TOP then
        border = INIT__LABEL__BORDER_TOP
    elseif region == BOTTOM then
        border = INIT__LABEL__BORDER_BOTTOM
    else
        notImplemented("The provided region was not TOP or BOTTOM.")
    end

    self.canWin = canWin
    self.column = nil
    self.region = region
    self.cards = {}
    self.score = nil
    self.isWon = false
    self.isFull = false
    self.label = Label(border)
    self.label:build(INIT__LABEL__WIDTH, INIT__LABEL__HEIGHT)

    self.positionIndex = 0
end

function Stack:dispose()
    LogTrace(self.className, CLASS_STACK_NAME, "dispose")

    Stack.super.dispose(self)

    self.label:dispose()
    self:foreachCard(function (card)
        card:dispose()
    end)
end

function Stack:setPositionIndex(positionIndex)
    LogTrace(self.className, CLASS_STACK_NAME, "setPositionIndex")

    self.positionIndex = positionIndex

    if self.director.scene == SCENE_STACK_BOTTOM then
        self:showStackBottomScene_Select()
    elseif self.director.scene == SCENE_STACK_TOP then
        self:showStackTopScene_Select()
    end
end

function Stack:canAddCard(cardToAdd)
    LogTrace(self.className, CLASS_STACK_NAME, "canAddCard")

    local cardsCount = #self.cards

    return cardsCount < STACK_MAXIMUM_CARD_COUNT
end

function Stack:addCard(cardToAdd)
    LogTrace(self.className, CLASS_STACK_NAME, "addCard")

    if self:canAddCard(cardToAdd) == false then
        throw("Cannot add the provided card. Call 'canAddCard()' before calling 'addCard()' to handle this error.")
    end

    local index = #self.cards + 1

    self.cards[index] = cardToAdd
    self.isFull = #self.cards >= STACK_MAXIMUM_CARD_COUNT
    self:refresh()
end

function Stack:setWin(otherScore)
    LogTrace(self.className, CLASS_STACK_NAME, "setWin")

    self.isWon = false

    if self.canWin and self.score > otherScore then
        self.isWon = true
    end

    self.label:setFill(self.isWon)
end

function Stack:calculateCurrentScore()
    LogTrace(self.className, CLASS_STACK_NAME, "getCurrentScore")

    if self.isFull == false  then
        self.score = 0
        return
    end

    local totalCards = 0
    local totalNumbersScore = 0
    local lowestCardNumber = -1
    local firstCardNumber = nil
    local firstCardSuit = nil
    local matchingNumbers = true
    local matchingSuits = true
    local cardsWithIndexAsScore = {}

    self:foreachCard(function (card)
        local number = card.number

        if firstCardNumber == nil then
            firstCardNumber = number
        elseif number ~= firstCardNumber then
            matchingNumbers = false
        end

        if firstCardSuit == nil then
            firstCardSuit = card.suit
        elseif card.suit ~= firstCardSuit then
            matchingSuits = false
        end

        totalNumbersScore = totalNumbersScore + number

        totalCards = totalCards + 1

        if number < lowestCardNumber or lowestCardNumber < 0 then
            lowestCardNumber = number
        end

        cardsWithIndexAsScore[number] = card
    end)

    --we can do matches now so we dont waste performance on the next loop
    if matchingNumbers then
        self.score =  totalNumbersScore * STACK_SCORE_MULTIPLER_MATCH
        return
    end

    local sequentialNumbers = true

    for index = lowestCardNumber, lowestCardNumber + totalCards - 1 do

        if cardsWithIndexAsScore[index] == nil then
            sequentialNumbers = false
            break
        end

    end

    if matchingSuits then

        if sequentialNumbers then
            self.score =  totalNumbersScore * STACK_SCORE_MULTIPLER_STRAIGHTFLUSH
            return
        end

        self.score =  totalNumbersScore * STACK_SCORE_MULTIPLER_FLUSH
        return
    end

    if sequentialNumbers then
        self.score =  totalNumbersScore * STACK_SCORE_MULTIPLER_STRAIGHT
        return
    end

    self.score = totalNumbersScore * STACK_SCORE_MULTIPLER_NONE
end

function Stack:showCombinedScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showCombinedScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = (GR__CARD__Y_OPPONENT + (GR__CARD__HEIGHT / 2)) + (SHOW_COMBINED__LABEL__HEIGHT / 2) + GR__COLUMN__PADDING
    elseif self.region == BOTTOM then
        y = (GR__CARD__Y_PLAYER - (GR__CARD__HEIGHT / 2)) - (SHOW_COMBINED__LABEL__HEIGHT / 2) - GR__COLUMN__PADDING
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:animateTo(SHOW_COMBINED__LABEL__ANIMATE_DURATION__MOVE, x, y)

    self:addSceneTrigger(SHOW_COMBINED__LABEL__ANIMATE_DURATION__MOVE, function ()
        self.label:build(SHOW_COMBINED__LABEL__WIDTH, SHOW_COMBINED__LABEL__HEIGHT)
    end)

    local yStart = y + SHOW_COMBINED__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_COMBINED__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_COMBINED__CARD__WIDTH, SHOW_COMBINED__CARD__HEIGHT)
        card:animateTo(SHOW_COMBINED__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showBoardScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showBoardScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = GR__COLUMN__PADDING + (SHOW_BOARD__LABEL__HEIGHT / 2)
    elseif self.region == BOTTOM then
        y = GR__SCREEN__HEIGHT - GR__COLUMN__PADDING - (SHOW_BOARD__LABEL__HEIGHT / 2)
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:build(SHOW_BOARD__LABEL__WIDTH, SHOW_BOARD__LABEL__HEIGHT)
    self.label:animateTo(SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE, x, y)

    local yStart = y + SHOW_BOARD__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_BOARD__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_BOARD__CARD__WIDTH, SHOW_BOARD__CARD__HEIGHT)
        card:animateTo(SHOW_BOARD__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showPlaceScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showPlaceScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = GR__COLUMN__PADDING + (SHOW_PLACE__LABEL__HEIGHT / 2)
    elseif self.region == BOTTOM then
        y = GR__SCREEN__HEIGHT - GR__COLUMN__PADDING - (SHOW_PLACE__LABEL__HEIGHT / 2)
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:build(SHOW_PLACE__LABEL__WIDTH, SHOW_PLACE__LABEL__HEIGHT)
    self.label:animateTo(SHOW_PLACE__LABEL__ANIMATE_DURATION__MOVE, x, y)

    local yStart = y + SHOW_PLACE__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_PLACE__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_PLACE__CARD__WIDTH, SHOW_PLACE__CARD__HEIGHT)
        card:animateTo(SHOW_PLACE__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showDeckScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showDeckScene")

    self.label:build(SHOW_DECK__LABEL__WIDTH, SHOW_DECK__LABEL__HEIGHT)
    self.label:animateToX(SHOW_DECK__LABEL__ANIMATE_DURATION__MOVE, SHOW_DECK__LABEL__X)

    self:foreachCard(function (card)
        card.isSlim = true
        card:build(SHOW_DECK__CARD__WIDTH, SHOW_DECK__CARD__HEIGHT)
        card:animateToX(SHOW_DECK__CARD__ANIMATE_DURATION__MOVE, SHOW_DECK__CARD__X)
    end)
end

function Stack:showStackBottomScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showStackBottomScene")

    local x = self:getPositionIndexX(SHOW_STACK_BOTTOM__LABEL__WIDTH)
    local y

    if self.region == TOP then
        y = SHOW_STACK_BOTTOM__LABEL__Y_TOP
    elseif self.region == BOTTOM then
        y = SHOW_STACK_BOTTOM__LABEL__Y
    end

    self.label:build(SHOW_STACK_BOTTOM__LABEL__WIDTH, SHOW_STACK_BOTTOM__LABEL__HEIGHT)
    self.label:moveTo(x, SHOW_STACK_BOTTOM__LABEL__Y_TOP)
    self.label:animateTo(SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE, x, y)

    self:foreachCard(function (card, cardIndex)
        local cardX = SHOW_STACK_BOTTOM__CARD__X_START + (x - (SHOW_STACK_BOTTOM__LABEL__WIDTH / 2)) + ((cardIndex - 1) * (SHOW_STACK_BOTTOM__CARD__WIDTH + SHOW_STACK_BOTTOM__CARD__PADDING))

        card.isSlim = false
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_STACK_BOTTOM__CARD__WIDTH, SHOW_STACK_BOTTOM__CARD__HEIGHT)
        card:animateTo(SHOW_STACK_BOTTOM__CARD__ANIMATE_DURATION__MOVE, cardX, y)
    end)
end

function Stack:showStackBottomScene_Select()
    LogTrace(self.className, CLASS_STACK_NAME, "showStackBottomScene_Select")

    if self.region == BOTTOM then
        local x = self:getPositionIndexX(SHOW_STACK_BOTTOM__LABEL__WIDTH)
        self.label:animateToX(SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE, x)

        self:foreachCard(function (card, cardIndex)
            local cardX = SHOW_STACK_BOTTOM__CARD__X_START + (x - (SHOW_STACK_BOTTOM__LABEL__WIDTH / 2)) + ((cardIndex - 1) * (SHOW_STACK_BOTTOM__CARD__WIDTH + SHOW_STACK_BOTTOM__CARD__PADDING))
            card.isSlim = true
            card:animateTo(SHOW_STACK_BOTTOM__CARD__ANIMATE_DURATION__MOVE, cardX, y)
        end)
    end
end

function Stack:showStackTopScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showStackTopScene")

    local x = self:getPositionIndexX(SHOW_STACK_TOP__LABEL__WIDTH)
    local y

    if self.region == TOP then
        y = SHOW_STACK_TOP__LABEL__Y
    elseif self.region == BOTTOM then
        y = SHOW_STACK_TOP__LABEL__Y_BOTTOM
    end

    self.label:build(SHOW_STACK_TOP__LABEL__WIDTH, SHOW_STACK_TOP__LABEL__HEIGHT)
    self.label:moveTo(x, SHOW_STACK_TOP__LABEL__Y_BOTTOM)
    self.label:animateTo(SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE, x, y)

    self:foreachCard(function (card, cardIndex)
        local cardX = SHOW_STACK_TOP__CARD__X_START + (x - (SHOW_STACK_TOP__LABEL__WIDTH / 2)) + ((cardIndex - 1) * (SHOW_STACK_TOP__CARD__WIDTH + SHOW_STACK_TOP__CARD__PADDING))

        card.isSlim = false
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_STACK_TOP__CARD__WIDTH, SHOW_STACK_TOP__CARD__HEIGHT)
        card:animateTo(SHOW_STACK_TOP__CARD__ANIMATE_DURATION__MOVE, cardX, y)
    end)
end

function Stack:showStackTopScene_Select()
    LogTrace(self.className, CLASS_STACK_NAME, "showStackTopScene_Select")

    if self.region == TOP then
        local x = self:getPositionIndexX(SHOW_STACK_TOP__LABEL__WIDTH)
        self.label:animateToX(SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE, x)

        self:foreachCard(function (card, cardIndex)
            local cardX = SHOW_STACK_TOP__CARD__X_START + (x - (SHOW_STACK_TOP__LABEL__WIDTH / 2)) + ((cardIndex - 1) * (SHOW_STACK_TOP__CARD__WIDTH + SHOW_STACK_TOP__CARD__PADDING))
            card.isSlim = true
            card:animateTo(SHOW_STACK_TOP__CARD__ANIMATE_DURATION__MOVE, cardX, y)
        end)
    end
end

function Stack:showDrawScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showDrawScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = (GR__CARD__Y_OPPONENT + (GR__CARD__HEIGHT / 2)) + (SHOW_DRAW__LABEL__HEIGHT / 2) + GR__COLUMN__PADDING
    elseif self.region == BOTTOM then
        y = (GR__CARD__Y_PLAYER - (GR__CARD__HEIGHT / 2)) - (SHOW_DRAW__LABEL__HEIGHT / 2) - GR__COLUMN__PADDING
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:build(SHOW_DRAW__LABEL__WIDTH, SHOW_DRAW__LABEL__HEIGHT)
    self.label:animateTo(SHOW_DRAW__LABEL__ANIMATE_DURATION__MOVE, x, y)

    local yStart = y + SHOW_DRAW__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_DRAW__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_DRAW__CARD__WIDTH, SHOW_DRAW__CARD__HEIGHT)
        card:animateTo(SHOW_DRAW__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showOpponentScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showOpponentScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = (GR__CARD__Y_OPPONENT + (GR__CARD__HEIGHT / 2)) + (SHOW_OPPONENT__LABEL__HEIGHT / 2) + GR__COLUMN__PADDING
    elseif self.region == BOTTOM then
        y = GR__SCREEN__HEIGHT - (SHOW_OPPONENT__LABEL__HEIGHT / 2) - GR__COLUMN__PADDING
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:animateTo(SHOW_OPPONENT__LABEL__ANIMATE_DURATION__MOVE, x, y)

    self:addSceneTrigger(SHOW_OPPONENT__LABEL__ANIMATE_DURATION__MOVE, function ()
        self.label:build(SHOW_OPPONENT__LABEL__WIDTH, SHOW_OPPONENT__LABEL__HEIGHT)
    end)

    local yStart = y + SHOW_OPPONENT__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_OPPONENT__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_OPPONENT__CARD__WIDTH, SHOW_OPPONENT__CARD__HEIGHT)
        card:animateTo(SHOW_OPPONENT__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showGameOverScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showGameOverScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)
    local y

    if self.region == TOP then
        y = GR__COLUMN__PADDING + (SHOW_GAME_OVER__LABEL__HEIGHT / 2)
    elseif self.region == BOTTOM then
        y = GR__SCREEN__HEIGHT - GR__COLUMN__PADDING - (SHOW_GAME_OVER__LABEL__HEIGHT / 2)
    else
        notImplemented("The provided region is not top or bottom.")
    end

    self.label:build(SHOW_GAME_OVER__LABEL__WIDTH, SHOW_GAME_OVER__LABEL__HEIGHT)
    self.label:animateTo(SHOW_GAME_OVER__LABEL__ANIMATE_DURATION__MOVE, x, y)

    local yStart = y + SHOW_GAME_OVER__CARD__Y_START

    self:foreachCard(function (card, cardIndex)
        local cardX = x
        local offset = (cardIndex - 1) * SHOW_GAME_OVER__CARD__HEIGHT_AND_PADDING
        local cardY = yStart + offset

        card.isSlim = true
        card:setZIndex(GR__ZINDEX__MEDIUM + cardIndex)
        card:build(SHOW_GAME_OVER__CARD__WIDTH, SHOW_GAME_OVER__CARD__HEIGHT)
        card:animateTo(SHOW_GAME_OVER__CARD__ANIMATE_DURATION__MOVE, cardX, cardY)
    end)
end

function Stack:showDefaultScene()
    LogTrace(self.className, CLASS_STACK_NAME, "showDefaultScene")

    local index = self.column.index
    local x = Stack.getXForIndex(index)

    self.label:build(SHOW_DEFAULT__LABEL__WIDTH, SHOW_DEFAULT__LABEL__HEIGHT)
    self.label:animateTo(SHOW_DEFAULT__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_DEFAULT__LABEL__Y)

    self:foreachCard(function (card)
        card.isSlim = true
        card:build(SHOW_DEFAULT__CARD__WIDTH, SHOW_DEFAULT__CARD__HEIGHT)
        card:animateToY(SHOW_DEFAULT__CARD__ANIMATE_DURATION__MOVE, SHOW_DEFAULT__CARD__Y)
    end)
end

function Stack:getPositionIndexX(width)
    LogTrace(self.className, CLASS_STACK_NAME, "getPositionIndexX")

    return GR__SCREEN__X_CENTER + (self.positionIndex * (width + (SHOW_STACK_TOP__LABEL__PADDING * 2)))
end

function Stack:foreachCard(func)
    LogTrace(self.className, CLASS_STACK_NAME, "foreachCard")

    for index, card in pairs(self.cards) do
        func(card, index)
    end
end

function Stack.getXForIndex(index)
    return GR__COLUMN__PADDING + ((GR__COLUMN__WIDTH + GR__COLUMN__PADDING) * (index - 1)) + (GR__COLUMN__WIDTH / 2)
end