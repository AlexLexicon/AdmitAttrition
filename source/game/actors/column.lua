--INIT
local INIT__LABEL__BORDER = GR__COLUMN__BORDER_THICKNESS
local INIT__LABEL__PADDING = 2
local INIT__LABEL__WIDTH = GR__COLUMN__WIDTH
local INIT__LABEL__HEIGHT = GR__COLUMN__BLOCK__HEIGHT

--SHOW COMBINED
local SHOW_COMBINED__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_COMBINED__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_COMBINED__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_COMBINED__LABEL__X_START = GR__COLUMN__PADDING + (GR__COLUMN__WIDTH / 2)
local SHOW_COMBINED__LABEL__Y = (GR__COLUMN__HEIGHT_BOTH / 2) + GR__COLUMN__PADDING + (GR__CARD__Y_OPPONENT + (GR__CARD__HEIGHT / 2))

--SHOW BOARD
local SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_BOARD__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_BOARD__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_BOARD__LABEL__X_START = SHOW_COMBINED__LABEL__X_START
local SHOW_BOARD__LABEL__Y = GR__SCREEN__Y_CENTER

--SHOW PLACE
local SHOW_PLACE__LABEL__ANIMATE_DURATION__MOVE = SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE
local SHOW_PLACE__LABEL__WIDTH = SHOW_BOARD__LABEL__WIDTH
local SHOW_PLACE__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT
local SHOW_PLACE__LABEL__X_START = SHOW_BOARD__LABEL__X_START
local SHOW_PLACE__LABEL__Y = SHOW_BOARD__LABEL__Y

--SHOW DECK
local SHOW_DECK__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DECK__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DECK__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_DECK__LABEL__X = GR__SCREEN__WIDTH + (GR__COLUMN__WIDTH / 2)

--SHOW STACK BOTTOM
local SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_BOTTOM__LABEL__PADDING = 15
local SHOW_STACK_BOTTOM__LABEL__WIDTH = GR__SCREEN__WIDTH - (SHOW_STACK_BOTTOM__LABEL__PADDING * 2)
local SHOW_STACK_BOTTOM__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_STACK_BOTTOM__LABEL__Y = SHOW_STACK_BOTTOM__LABEL__PADDING + (SHOW_STACK_BOTTOM__LABEL__HEIGHT / 2)
local SHOW_STACK_BOTTOM__LABEL__Y_START = -(SHOW_STACK_BOTTOM__LABEL__HEIGHT / 2)

--SHOW STACK TOP
local SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_STACK_TOP__LABEL__PADDING = 15
local SHOW_STACK_TOP__LABEL__WIDTH = GR__SCREEN__WIDTH - (SHOW_STACK_TOP__LABEL__PADDING * 2)
local SHOW_STACK_TOP__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_STACK_TOP__LABEL__Y = GR__SCREEN__HEIGHT - SHOW_STACK_TOP__LABEL__PADDING - (SHOW_STACK_BOTTOM__LABEL__HEIGHT / 2)
local SHOW_STACK_TOP__LABEL__Y_START = GR__SCREEN__HEIGHT + (SHOW_STACK_TOP__LABEL__HEIGHT / 2)

--SHOW DRAW
local SHOW_DRAW__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DRAW__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DRAW__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_DRAW__LABEL__X_START = SHOW_COMBINED__LABEL__X_START
local SHOW_DRAW__LABEL__Y = SHOW_COMBINED__LABEL__Y

--SHOW OPPONENT
local SHOW_OPPONENT__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_OPPONENT__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_OPPONENT__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_OPPONENT__LABEL__X_START = GR__COLUMN__PADDING + (GR__COLUMN__WIDTH / 2)
local SHOW_OPPONENT__LABEL__Y = (GR__COLUMN__HEIGHT_OPPONENT / 2) + GR__COLUMN__PADDING + (GR__CARD__Y_OPPONENT + (GR__CARD__HEIGHT / 2))

--SHOW GAME OVER
local SHOW_GAME_OVER__LABEL__ANIMATE_DURATION__MOVE = SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE
local SHOW_GAME_OVER__LABEL__WIDTH = SHOW_BOARD__LABEL__WIDTH
local SHOW_GAME_OVER__LABEL__HEIGHT = SHOW_BOARD__LABEL__HEIGHT
local SHOW_GAME_OVER__LABEL__X_START = SHOW_BOARD__LABEL__X_START
local SHOW_GAME_OVER__LABEL__Y = SHOW_BOARD__LABEL__Y

--SHOW DEFAULT
local SHOW_DEFAULT__LABEL__ANIMATE_DURATION__MOVE = DURATION_MEDIUM
local SHOW_DEFAULT__LABEL__WIDTH = INIT__LABEL__WIDTH
local SHOW_DEFAULT__LABEL__HEIGHT = INIT__LABEL__HEIGHT
local SHOW_DEFAULT__LABEL__X_START = SHOW_COMBINED__LABEL__X_START
local SHOW_DEFAULT__LABEL__Y = -(GR__COLUMN__HEIGHT_BOTH / 2)

CLASS_COLUMN_NAME = "Column"
class(CLASS_COLUMN_NAME).extends(Actor())

function Column:init(index, opponentStack, playerStack, text)
    LogTrace(self.className, CLASS_COLUMN_NAME, "init")

    Column.super.init(self)

    self.index = index

    self.label = Label(INIT__LABEL__BORDER, INIT__LABEL__PADDING)
    self.label:build(INIT__LABEL__WIDTH, INIT__LABEL__HEIGHT, text)

    self.opponentStack = opponentStack
    self.playerStack = playerStack

    self.positionIndex = 0
end

function Column:dispose()
    LogTrace(self.className, CLASS_COLUMN_NAME, "dispose")

    Column.super.dispose(self)

    self.label:dispose()
end

function Column:setPositionIndex(positionIndex)
    LogTrace(self.className, CLASS_COLUMN_NAME, "setPositionIndex")

    self.positionIndex = positionIndex
    self.opponentStack:setPositionIndex(positionIndex)
    self.playerStack:setPositionIndex(positionIndex)

    if self.director.scene == SCENE_STACK_BOTTOM then
        self:showStackBottomScene_Select()
    elseif self.director.scene == SCENE_STACK_TOP then
        self:showStackTopScene_Select()
    end
end

function Column:canAddCard(cardToAdd, fromHand)
    LogTrace(self.className, CLASS_COLUMN_NAME, "canAddCard")

    if cardToAdd == nil then
        logWarning("The provided card to add is nil.")
        return false
    end

    if fromHand == nil then
        logWarning("The provided hand is nil.")
        return false
    end

    if ctype(fromHand) == CLASS_PLAYER_NAME then
        return self.playerStack:canAddCard(cardToAdd)
    elseif ctype(fromHand) == CLASS_OPPONENT_NAME then
        return self.opponentStack:canAddCard(cardToAdd)
    end

    notImplemented("The provided hand is not the player or the opponent.")
end

function Column:addCard(cardToAdd, fromHand)
    LogTrace(self.className, CLASS_COLUMN_NAME, "addCard")

    if ctype(fromHand) == CLASS_PLAYER_NAME then

        if self.playerStack:canAddCard(cardToAdd) == false then
            throw("Cannot add the provided card. Call 'canAddCard()' before calling 'addCard()' to handle this error.")
        end

        self.playerStack:addCard(cardToAdd)
    elseif ctype(fromHand) == CLASS_OPPONENT_NAME then

        if self.opponentStack:canAddCard(cardToAdd) == false then
            throw("Cannot add the provided card. Call 'canAddCard()' before calling 'addCard()' to handle this error.")
        end

        self.opponentStack:addCard(cardToAdd)
    else
        notImplemented("The provided hand is not the player or the opponent.")
    end
end

function Column:showCombinedScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showCombinedScene")

    local x = SHOW_COMBINED__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_COMBINED__LABEL__WIDTH, SHOW_COMBINED__LABEL__HEIGHT)
    self.label:animateTo(SHOW_COMBINED__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_COMBINED__LABEL__Y)
end

function Column:showBoardScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showBoardScene")

    local x = SHOW_BOARD__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_BOARD__LABEL__WIDTH, SHOW_BOARD__LABEL__HEIGHT)
    self.label:animateTo(SHOW_BOARD__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_BOARD__LABEL__Y)
end

function Column:showPlaceScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showPlaceScene")

    local x = SHOW_PLACE__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_PLACE__LABEL__WIDTH, SHOW_PLACE__LABEL__HEIGHT)
    self.label:animateTo(SHOW_PLACE__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_PLACE__LABEL__Y)
end

function Column:showDeckScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showDeckScene")

    self.label:build(SHOW_DECK__LABEL__WIDTH, SHOW_DECK__LABEL__HEIGHT)
    self.label:animateToX(SHOW_DECK__LABEL__ANIMATE_DURATION__MOVE, SHOW_DECK__LABEL__X)
end

function Column:showStackBottomScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showStackBottomScene")

    local x = self:getPositionIndexX(SHOW_STACK_BOTTOM__LABEL__WIDTH)

    self.label:build(SHOW_STACK_BOTTOM__LABEL__WIDTH, SHOW_STACK_BOTTOM__LABEL__HEIGHT)
    self.label:moveTo(x, SHOW_STACK_BOTTOM__LABEL__Y_START)
    self.label:animateTo(SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_STACK_BOTTOM__LABEL__Y)
end

function Column:showStackBottomScene_Select()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showStackBottomScene_Select")

    local x = self:getPositionIndexX(SHOW_STACK_BOTTOM__LABEL__WIDTH)

    self.label:animateToX(SHOW_STACK_BOTTOM__LABEL__ANIMATE_DURATION__MOVE, x)
end

function Column:showStackTopScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showStackTopScene")

    local x = self:getPositionIndexX(SHOW_STACK_TOP__LABEL__WIDTH)

    self.label:build(SHOW_STACK_TOP__LABEL__WIDTH, SHOW_STACK_TOP__LABEL__HEIGHT)
    self.label:moveTo(x, SHOW_STACK_TOP__LABEL__Y_START)
    self.label:animateTo(SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_STACK_TOP__LABEL__Y)
end

function Column:showStackTopScene_Select()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showStackTopScene_Select")

    local x = self:getPositionIndexX(SHOW_STACK_TOP__LABEL__WIDTH)

    self.label:animateToX(SHOW_STACK_TOP__LABEL__ANIMATE_DURATION__MOVE, x)
end

function Column:showDrawScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showDrawScene")

    local x = SHOW_DRAW__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_DRAW__LABEL__WIDTH, SHOW_DRAW__LABEL__HEIGHT)
    self.label:animateTo(SHOW_DRAW__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_DRAW__LABEL__Y)
end

function Column:showOpponentScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showOpponentScene")

    local x = SHOW_OPPONENT__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_OPPONENT__LABEL__WIDTH, SHOW_OPPONENT__LABEL__HEIGHT)
    self.label:animateTo(SHOW_OPPONENT__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_OPPONENT__LABEL__Y)
end

function Column:showTurnOverScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showTurnOverScene")

    if self.playerStack.isFull and self.opponentStack.isFull then
        self.playerStack:calculateCurrentScore()
        self.opponentStack:calculateCurrentScore()

        self.opponentStack:setWin(self.playerStack.score)
        self.playerStack:setWin(self.opponentStack.score)
    end
end

function Column:showGameOverScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showGameOverScene")

    local x = SHOW_GAME_OVER__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_GAME_OVER__LABEL__WIDTH, SHOW_GAME_OVER__LABEL__HEIGHT)
    self.label:animateTo(SHOW_GAME_OVER__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_GAME_OVER__LABEL__Y)
end

function Column:showDefaultScene()
    LogTrace(self.className, CLASS_COLUMN_NAME, "showDefaultScene")

    local x = SHOW_DEFAULT__LABEL__X_START + (GR__COLUMN__WIDTH_AND_PADDING * (self.index - 1))

    self.label:build(SHOW_DEFAULT__LABEL__WIDTH, SHOW_DEFAULT__LABEL__HEIGHT)
    self.label:animateTo(SHOW_DEFAULT__LABEL__ANIMATE_DURATION__MOVE, x, SHOW_DEFAULT__LABEL__Y)
end

function Column:getPositionIndexX(width)
    LogTrace(self.className, CLASS_COLUMN_NAME, "getPositionIndexX")

    return GR__SCREEN__X_CENTER + (self.positionIndex * (width + (SHOW_STACK_BOTTOM__LABEL__PADDING * 2)))
end