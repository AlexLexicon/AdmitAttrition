--INIT
local DECK__INIT__LABEL__PADDING = 15
local DECK__INIT__LABEL__WIDTH = GR__SCREEN__WIDTH - (DECK__INIT__LABEL__PADDING * 2)
local DECK__INIT__LABEL__HEIGHT = GR__SCREEN__HEIGHT / 5
local DECK__INIT__LABEL__X = -(GR__SCREEN__WIDTH + (DECK__INIT__LABEL__WIDTH / 2))
local DECK__INIT__LABEL__Y = DECK__INIT__LABEL__PADDING + (DECK__INIT__LABEL__HEIGHT / 2)

local DECK__INIT__COVER__WIDTH = GR__SCREEN__WIDTH
local DECK__INIT__COVER__HEIGHT = GR__SCREEN__HEIGHT
local DECK__INIT__COVER__X = GR__SCREEN__X_CENTER
local DECK__INIT__COVER__Y = GR__SCREEN__Y_CENTER

--SHOW BEFORE
local DECK__SHOW_BEFORE__LABEL__ANIMATE_DURATION = DURATION_MEDIUM
local DECK__SHOW_BEFORE__LABEL__X = DECK__INIT__LABEL__X

--SHOW_DECK
local DECK__SHOW_DECK__LABEL__ANIMATE_DURATION = DURATION_SHORT
local DECK__SHOW_DECK__LABEL__X = GR__SCREEN__X_CENTER

--SHOW DECK MOVE
local DECK__SHOW_DECK_MOVE__TRIGGER__DELAY = DECK__SHOW_DECK__LABEL__ANIMATE_DURATION --+ DURATION_MICRO
local DECK__SHOW_DECK_MOVE__CARD__ANIMATE_DURATION = DURATION_MEDIUM
local DECK__SHOW_DECK_MOVE__CARD__HEIGHT = (GR__SCREEN__HEIGHT / 5) * 2
local DECK__SHOW_DECK_MOVE__CARD__WIDTH = (DECK__SHOW_DECK_MOVE__CARD__HEIGHT * GR__CARD__WIDTH_RATIO) / GR__CARD__HEIGHT_RATIO

local DECK__SHOW_DECK_MOVE__DECK__SIZE_FACTOR = 7
local DECK__SHOW_DECK_MOVE__DECK__WIDTH = DECK__SHOW_DECK_MOVE__CARD__WIDTH + (DECK__SHOW_DECK_MOVE__CARD__WIDTH / DECK__SHOW_DECK_MOVE__DECK__SIZE_FACTOR)
local DECK__SHOW_DECK_MOVE__DECK__HEIGHT = DECK__SHOW_DECK_MOVE__CARD__HEIGHT + (DECK__SHOW_DECK_MOVE__CARD__HEIGHT / DECK__SHOW_DECK_MOVE__DECK__SIZE_FACTOR)
local DECK__SHOW_DECK_MOVE__DECK__X_START = GR__SCREEN__X_CENTER - ((DECK__SHOW_DECK_MOVE__DECK__WIDTH - DECK__SHOW_DECK_MOVE__CARD__WIDTH) / 2)
local DECK__SHOW_DECK_MOVE__DECK__Y_START = -DECK__SHOW_DECK_MOVE__DECK__HEIGHT
local DECK__SHOW_DECK_MOVE__DECK__X_END = DECK__SHOW_DECK_MOVE__DECK__X_START
local DECK__SHOW_DECK_MOVE__DECK__Y_END = DECK__INIT__LABEL__HEIGHT + ((GR__SCREEN__HEIGHT - DECK__INIT__LABEL__HEIGHT) / 2)

--SHOW DECK SPLIT
local DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT = 4
local DECK__SHOW_DECK_SPLIT__TRIGGER__DELAY = DECK__SHOW_DECK_MOVE__TRIGGER__DELAY + DECK__SHOW_DECK_MOVE__CARD__ANIMATE_DURATION + DURATION_MICRO
local DECK__SHOW_DECK_SPLIT__CARD__ANIMATE_DURATION = DURATION_MEDIUM
local DECK__SHOW_DECK_SPLIT__CARD__PADDING = 15
local DECK__SHOW_DECK_SPLIT__CARD__WIDTH = (GR__SCREEN__WIDTH - (DECK__SHOW_DECK_SPLIT__CARD__PADDING * (DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT + 1))) / DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT
local DECK__SHOW_DECK_SPLIT__CARD__HEIGHT = (DECK__SHOW_DECK_SPLIT__CARD__WIDTH * 3.5) / 2.5
local DECK__SHOW_DECK_SPLIT__CARD__X_START = DECK__SHOW_DECK_SPLIT__CARD__PADDING + (DECK__SHOW_DECK_SPLIT__CARD__WIDTH / 2)
local DECK__SHOW_DECK_SPLIT__REGION__TOP = DECK__INIT__LABEL__PADDING + DECK__INIT__LABEL__HEIGHT + DECK__SHOW_DECK_SPLIT__CARD__PADDING
local DECK__SHOW_DECK_SPLIT__CARD__Y_START = DECK__SHOW_DECK_SPLIT__REGION__TOP + (DECK__SHOW_DECK_SPLIT__CARD__HEIGHT / 2)
local DECK__SHOW_DECK_SPLIT__REGION__HEIGHT = GR__SCREEN__HEIGHT - DECK__SHOW_DECK_SPLIT__REGION__TOP - DECK__SHOW_DECK_SPLIT__CARD__PADDING

--SHOW DRAW MOVE
local DECK__SHOW_DRAW_MOVE__TRIGGER__DELAY = DURATION_SHORT
local DECK__SHOW_DRAW_MOVE__CARD__ANIMATE_DURATION = DURATION_MEDIUM
local DECK__SHOW_DRAW_MOVE__CARD__HEIGHT = (GR__SCREEN__HEIGHT / 5) * 2
local DECK__SHOW_DRAW_MOVE__CARD__WIDTH = (DECK__SHOW_DRAW_MOVE__CARD__HEIGHT * GR__CARD__WIDTH_RATIO) / GR__CARD__HEIGHT_RATIO

local DECK__SHOW_DRAW_MOVE__DECK__SIZE_FACTOR = 7
local DECK__SHOW_DRAW_MOVE__DECK__WIDTH = DECK__SHOW_DRAW_MOVE__CARD__WIDTH + (DECK__SHOW_DRAW_MOVE__CARD__WIDTH / DECK__SHOW_DRAW_MOVE__DECK__SIZE_FACTOR)
local DECK__SHOW_DRAW_MOVE__DECK__HEIGHT = DECK__SHOW_DRAW_MOVE__CARD__HEIGHT + (DECK__SHOW_DRAW_MOVE__CARD__HEIGHT / DECK__SHOW_DRAW_MOVE__DECK__SIZE_FACTOR)
local DECK__SHOW_DRAW_MOVE__DECK__X_START = GR__SCREEN__X_CENTER - ((DECK__SHOW_DRAW_MOVE__DECK__WIDTH - DECK__SHOW_DRAW_MOVE__CARD__WIDTH) / 2)
local DECK__SHOW_DRAW_MOVE__DECK__Y_START = -DECK__SHOW_DRAW_MOVE__DECK__HEIGHT
local DECK__SHOW_DRAW_MOVE__DECK__X_END = DECK__SHOW_DRAW_MOVE__DECK__X_START
local DECK__SHOW_DRAW_MOVE__DECK__Y_END = (GR__CARD__Y_PLAYER - (GR__CARD__HEIGHT / 2)) / 2

--SHOW DRAW DEAL
local DECK__SHOW_DRAW_DEAL__TRIGGER__DELAY = DURATION_MEDIUM
local DECK__SHOW_DRAW_DEAL__TRIGGER__DELAY_FIRST = DECK__SHOW_DRAW_MOVE__TRIGGER__DELAY + DECK__SHOW_DRAW_MOVE__CARD__ANIMATE_DURATION

--SHOW DEFAULT
local DECK__SHOW_DEFAULT__CARD__ANIMATE_DURATION = DURATION_MEDIUM
local DECK__SHOW_DEFAULT__CARD__WIDTH = DECK__SHOW_DECK_MOVE__CARD__WIDTH
local DECK__SHOW_DEFAULT__CARD__HEIGHT = DECK__SHOW_DECK_MOVE__CARD__HEIGHT
local DECK__SHOW_DEFAULT__CARD__X = DECK__SHOW_DECK_MOVE__DECK__X_START
local DECK__SHOW_DEFAULT__CARD__Y = DECK__SHOW_DECK_MOVE__DECK__Y_START

CLASS_DECK_NAME = "Deck"
class(CLASS_DECK_NAME).extends(Actor())

function Deck:init(...)
    LogTrace(self.className, CLASS_DECK_NAME, "init")

    Deck.super.init(self)

    self.hands = {...}
    self.handsToDealCardsCount = {}
    self.isDealing = false

    for _, hand in pairs(self.hands) do
        self.handsToDealCardsCount[hand] = 0
    end

    self.label = Label()
    self.cover = Cover()

    self.label:moveTo(DECK__INIT__LABEL__X, DECK__INIT__LABEL__Y)
    self.label:build(DECK__INIT__LABEL__WIDTH, DECK__INIT__LABEL__HEIGHT)
    self.cover:build(DECK__INIT__COVER__X, DECK__INIT__COVER__Y, DECK__INIT__COVER__WIDTH, DECK__INIT__COVER__HEIGHT)

    self.allCards = {}
    self.cards = {}
    self:generateDeck()
end

function Deck:dispose()
    LogTrace(self.className, CLASS_DECK_NAME, "dispose")

    Deck.super.dispose(self)

    self.label:dispose()
    self.cover:dispose()

    for _, card in pairs(self.allCards) do
        card:dispose()
    end
end

function Deck:generateDeck()
    LogTrace(self.className, CLASS_DECK_NAME, "generateDeck")

    local suitIndex = 0
    local totalCards = GAME__DECK_SIZE

    for index = 1, totalCards do
        local cardIndex = index % #GAME__CARD_NUMBERS

        if cardIndex == 0 then
            cardIndex = #GAME__CARD_NUMBERS
        elseif cardIndex == 1 then
            suitIndex = suitIndex + 1
        end

        local number = GAME__CARD_NUMBERS[cardIndex]
        local suit = GAME__CARD_SUITS[suitIndex]
        local card = Card(number, suit)
        card.isFront = false

        self.allCards[index] = card
    end

    self:shuffle()
end

function Deck:shuffle()
    LogTrace(self.className, CLASS_DECK_NAME, "shuffle")

    table.shuffle(self.allCards)

    --take back all cards from hands
    for _, hand in pairs(self.hands) do
        hand.cards = {}
    end

    --reset the cards collection to all the cards
    self.cards = {}
    for index, card in pairs(self.allCards) do
        self.cards[index] = card
    end
end

function Deck:totalCardsToDealCount()
    LogTrace(self.className, CLASS_DECK_NAME, "cardsToDealCount")

    local count = 0
    for _, hand in pairs(self.hands) do
        local dealCount = self.handsToDealCardsCount[hand]
        count = count + dealCount
    end

    return count
end

function Deck:cardsCountRemaining()
    LogTrace(self.className, CLASS_DECK_NAME, "countAfterDeals")

    return #self.cards - self:totalCardsToDealCount()
end

function Deck:canDeal(hand)
    LogTrace(self.className, CLASS_DECK_NAME, "canDeal")

    if hand == nil then
        logWarning("Tried to deal to a nil hand.")
        return false
    end

    if Actor.contains(self.hands, hand) == false then
        logWarning("Tried to deal to a hand that this deck does not own.")
        return false
    end

    if self.handsToDealCardsCount[hand] == nil then
        logWarning("Tried to deal to a hand but that hand was not an index of cardsToDealCount")
        return false
    end

    if (self:cardsCountRemaining() > 0) == false then
        logWarning("Tried to deal when there are no cards left in the deck.")
        return false
    end

    return true
end

function Deck:deal(hand)
    LogTrace(self.className, CLASS_DECK_NAME, "deal")

    if self:canDeal(hand) == false then
        throw("Cannot deal a card to the provided hand. Call 'canDeal()' before calling 'deal()' to handle this error.")
    end

    self.handsToDealCardsCount[hand] = self.handsToDealCardsCount[hand] + 1
end

function Deck:beforeShowScene()
    LogTrace(self.className, CLASS_DECK_NAME, "beforeShowScene")

    self.cover:setVisible(false)
    self.label:animateToX(DECK__SHOW_BEFORE__LABEL__ANIMATE_DURATION, DECK__SHOW_BEFORE__LABEL__X)
end

function Deck:showDefaultScene()
    LogTrace(self.className, CLASS_DECK_NAME, "showDefaultScene")

    self:foreachCard(function (card)
        card:build(DECK__SHOW_DEFAULT__CARD__WIDTH, DECK__SHOW_DEFAULT__CARD__HEIGHT)
        card:animateTo(DECK__SHOW_DEFAULT__CARD__ANIMATE_DURATION, DECK__SHOW_DEFAULT__CARD__X, DECK__SHOW_DEFAULT__CARD__Y)
    end)
end

function Deck:showDeckScene()
    LogTrace(self.className, CLASS_DECK_NAME, "showDeckScene")

    self.label:build(VERBAGE__DECK__LABEL(#self.cards))
    self.label:animateToX(DECK__SHOW_DECK__LABEL__ANIMATE_DURATION, DECK__SHOW_DECK__LABEL__X)

    self:showDeckScene_Move()
    self:showDeckScene_Split()
end

function Deck:showDeckScene_Move()
    LogTrace(self.className, CLASS_DECK_NAME, "showDeckScene_MoveDeck")

    self:addSceneTrigger(DECK__SHOW_DECK_MOVE__TRIGGER__DELAY, function ()
        local cardsCount = #self.cards
        local xDiffrence = (DECK__SHOW_DECK_MOVE__DECK__WIDTH - DECK__SHOW_DECK_MOVE__CARD__WIDTH) / cardsCount
        local yDiffrence = (DECK__SHOW_DECK_MOVE__DECK__HEIGHT - DECK__SHOW_DECK_MOVE__CARD__HEIGHT) / cardsCount

        self:foreachCard(function (card, index)
            local xOffset = xDiffrence * (index - 1)
            local yOffset = yDiffrence * (index - 1)
            local xStart = DECK__SHOW_DECK_MOVE__DECK__X_START + xOffset
            local yStart = DECK__SHOW_DECK_MOVE__DECK__Y_START + yOffset
            local xEnd = DECK__SHOW_DECK_MOVE__DECK__X_END + xOffset
            local yEnd = DECK__SHOW_DECK_MOVE__DECK__Y_END + yOffset

            card:setZIndex(GR__ZINDEX__HIGHEST + (cardsCount - index))
            card:build(DECK__SHOW_DECK_MOVE__CARD__WIDTH, DECK__SHOW_DECK_MOVE__CARD__HEIGHT)
            card:moveTo(xStart, yStart)
            card:animateTo(DECK__SHOW_DECK_MOVE__CARD__ANIMATE_DURATION, xEnd, yEnd)
        end)
    end)
end

function Deck:showDeckScene_Split()
    LogTrace(self.className, CLASS_DECK_NAME, "showDeckScene_SplitDeck")

    self:addSceneTrigger(DECK__SHOW_DECK_SPLIT__TRIGGER__DELAY, function ()
        local cardsCount = #self.cards
        local cardsPerColumnCount = math.ceil(cardsCount / DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT)
        local yDiffrence = 0
        if cardsPerColumnCount > 1 then
            yDiffrence = math.max((DECK__SHOW_DECK_SPLIT__REGION__HEIGHT - DECK__SHOW_DECK_SPLIT__CARD__HEIGHT) / (cardsPerColumnCount - 1), 0)
        end

        self:foreachCard(function (card, index)
            local rowIndex = math.floor((index - 1) / DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT)
            local columnIndex = (index - 1) - (rowIndex * DECK__SHOW_DECK_SPLIT__COLUMNS_COUNT)
            local x = DECK__SHOW_DECK_SPLIT__CARD__X_START + (columnIndex * (DECK__SHOW_DECK_SPLIT__CARD__WIDTH + DECK__SHOW_DECK_SPLIT__CARD__PADDING))
            local y = DECK__SHOW_DECK_SPLIT__CARD__Y_START + (yDiffrence * (rowIndex))

            card:build(DECK__SHOW_DECK_SPLIT__CARD__WIDTH, DECK__SHOW_DECK_SPLIT__CARD__HEIGHT)
            card:animateTo(DECK__SHOW_DECK_SPLIT__CARD__ANIMATE_DURATION, x, y)
        end)
    end)
end

function Deck:showDrawScene()
    LogTrace(self.className, CLASS_DECK_NAME, "showDrawScene")

    self.cover:setVisible(true)
    self:showDrawScene_Move()
    self:showDrawScene_Deal(DECK__SHOW_DRAW_DEAL__TRIGGER__DELAY_FIRST)
end

function Deck:showDrawScene_Move()
    LogTrace(self.className, CLASS_DECK_NAME, "showDrawScene_Move")

    self:addSceneTrigger(DECK__SHOW_DRAW_MOVE__TRIGGER__DELAY, function ()
        local cardsCount = #self.cards
        local xDiffrence = (DECK__SHOW_DRAW_MOVE__DECK__WIDTH - DECK__SHOW_DRAW_MOVE__CARD__WIDTH) / cardsCount
        local yDiffrence = (DECK__SHOW_DRAW_MOVE__DECK__HEIGHT - DECK__SHOW_DRAW_MOVE__CARD__HEIGHT) / cardsCount

        self:foreachCard(function (card, index)
            local xOffset = xDiffrence * (index - 1)
            local yOffset = yDiffrence * (index - 1)
            local xStart = DECK__SHOW_DRAW_MOVE__DECK__X_START + xOffset
            local yStart = DECK__SHOW_DRAW_MOVE__DECK__Y_START + yOffset
            local xEnd = DECK__SHOW_DRAW_MOVE__DECK__X_END + xOffset
            local yEnd = DECK__SHOW_DRAW_MOVE__DECK__Y_END + yOffset

            card:setZIndex(GR__ZINDEX__HIGHEST + (cardsCount - index))
            card:build(DECK__SHOW_DRAW_MOVE__CARD__WIDTH, DECK__SHOW_DRAW_MOVE__CARD__HEIGHT)
            card:moveTo(xStart, yStart)
            card:animateTo(DECK__SHOW_DRAW_MOVE__CARD__ANIMATE_DURATION, xEnd, yEnd)
        end)
    end)
end

function Deck:showDrawScene_Deal(delay)
    LogTrace(self.className, CLASS_DECK_NAME, "showDrawScene_Deal")

    self.isDealing = true

    if #self.cards > 0 and self:totalCardsToDealCount() > 0 then
        self:addSceneTrigger(delay, function ()
            local topCardIndex = #self.cards
            local topCard = self.cards[topCardIndex]

            local handToDealTo = nil

            for _, hand in pairs(self.hands) do
                local dealCount = self.handsToDealCardsCount[hand]

                if dealCount > 0 then
                    handToDealTo = hand
                    break
                end
            end

            if handToDealTo:canAddCard(topCard) then
                topCard.isFront = true
                handToDealTo:addCard(topCard)
                self.handsToDealCardsCount[handToDealTo] = self.handsToDealCardsCount[handToDealTo] - 1
                table.remove(self.cards, topCardIndex)
                self:showDrawScene_Deal(DECK__SHOW_DRAW_DEAL__TRIGGER__DELAY)
            end
        end)
    else
        --we use this boolean so that we can finish the animation delay one last time
        self.isDealing = false
    end
end

function Deck:foreachCard(func)
    LogTrace(self.className, CLASS_DECK_NAME, "eachCard")

    for index, card in pairs(self.cards) do
        func(card, index)
    end
end