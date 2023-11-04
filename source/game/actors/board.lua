--INIT
local INIT__SELECTOR__BORDER_THICKNESS = 2

--SHOW PLACE
local SHOW_PLACE__SELECTOR__WIDTH = GR__COLUMN__WIDTH + (INIT__SELECTOR__BORDER_THICKNESS * 2)
local SHOW_PLACE__SELECTOR__HEIGHT = GR__SCREEN__HEIGHT - (GR__COLUMN__PADDING * 2) + (INIT__SELECTOR__BORDER_THICKNESS * 2)
local SHOW_PLACE__SELECTOR__X_START = GR__COLUMN__PADDING - INIT__SELECTOR__BORDER_THICKNESS + (SHOW_PLACE__SELECTOR__WIDTH / 2)
local SHOW_PLACE__SELECTOR__Y = GR__SCREEN__Y_CENTER

CLASS_BOARD_NAME = "Board"
class(CLASS_BOARD_NAME).extends(Actor())

function Board:init(columns)
    LogTrace(self.className, CLASS_BOARD_NAME, "init")

    Board.super.init(self)

    self.columns = columns
    self.winLabel = Label(0)
    self.winLabel:setVisible(false)
    self.winLabel:setZIndex(GR__ZINDEX__HIGHEST + 2)
    self.winCover = Cover()
    self.winCover:setVisible(false)
    self.winCover:setZIndex(GR__ZINDEX__HIGHEST + 1)
    self.selectedColumn = nil
    self.nextSelectedColumn = nil
    self.previousSelectedColumn = nil
    self.selector = Selector(GR__SCREEN__X_CENTER, GR__SCREEN__Y_CENTER, INIT__SELECTOR__BORDER_THICKNESS)
end

function Board:dispose()
    LogTrace(self.className, CLASS_BOARD_NAME, "dispose")

    Board.super.dispose(self)

    self.winLabel:dispose()
    self.winCover:dispose()
end

function Board:getSelectedColumnSide()
    LogTrace(self.className, CLASS_BOARD_NAME, "getSelectedColumnSide")

    local columnsOnRight = #self.columns - index
    local columnsOnLeft = #self.columns - columnsOnRight - 1

    if columnsOnRight > columnsOnLeft then
        return RIGHT
    else
        return LEFT
    end
end

function Board:beforeShowScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "beforeShowScene")

    self.selector:build()
end

function Board:canPlayCard(cardToPlay, fromHand)
    LogTrace(self.className, CLASS_BOARD_NAME, "canPlayCard")

    if self.selectedColumn == nil then
        logWarning("The selected column is nil.")
        return false
    end

    if self.selectedColumn:canAddCard(cardToPlay, fromHand) == false then
        logWarning("The selected column cannot have any cards added to it.")
        return false
    end

    return true
end

function Board:playCard(cardToPlay, fromHand)
    LogTrace(self.className, CLASS_BOARD_NAME, "playCard")

    if self:canPlayCard(cardToPlay, fromHand) == false then
        error("You cannot place a card on this board. Call canPlayCard() first to check.")
    end

    cardToPlay.isFront = true

    self.selectedColumn:addCard(cardToPlay, fromHand)
end

function Board:selectNextColumn()
    LogTrace(self.className, CLASS_BOARD_NAME, "selectNextColumn")

    self:selectColumn(self.nextSelectedColumn)
end

function Board:selectPreviousColumn()
    LogTrace(self.className, CLASS_BOARD_NAME, "selectPreviousColumn")

    self:selectColumn(self.previousSelectedColumn)
end

--move to director?
function Board:onColumnSelected(callback)
    LogTrace(self.className, CLASS_BOARD_NAME, "onChooseColumn")

    self.onChooseColumnCallback = callback
end

function Board:chooseColumn(index)
    LogTrace(self.className, CLASS_BOARD_NAME, "chooseColumn")

    if self.onChooseColumnCallback ~= nil then
        local columnsOnRight = #self.columns - index
        local columnsOnLeft = #self.columns - columnsOnRight - 1

        self.onChooseColumnCallback(index, columnsOnRight, columnsOnLeft)
    end
end

function Board:selectColumn(columnToSelect)
    LogTrace(self.className, CLASS_BOARD_NAME, "selectColumn")

    local firstColumn = nil
    local lastColumn = nil
    local isLastSelected = false

    self.nextSelectedColumn = nil
    self.previousSelectedColumn = nil

    self:foreachColumn(function (column, index)
        local isSelectedColumn = column:equals(columnToSelect)

        if firstColumn == nil then
            firstColumn = column
        end

        if isLastSelected then
            isLastSelected = false

            self.nextSelectedColumn = column
        end

        if isSelectedColumn then
            isLastSelected = true

            self.selectedColumn = column
            self.previousSelectedColumn = lastColumn

            self:chooseColumn(index)
        end

        column:setIsSelected(isSelectedColumn)
        lastColumn = column
    end)

    if self.selectedColumn ~= nil then
        self:foreachColumn(function (column, index)
            column:setPositionIndex(index - self.selectedColumn.index)
        end)
    end

    if self.nextSelectedColumn == nil then
        self.nextSelectedColumn = firstColumn
    end

    if self.previousSelectedColumn == nil then
        self.previousSelectedColumn = lastColumn
    end

    if self.director.scene == SCENE_PLACE then
        self:refresh()
    end
end

function Board:showPlaceScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "showPlaceScene")

    if self.selectedColumn == nil then
        self:selectColumn(self.columns[1])
    end

    local index = self.selectedColumn.index - 1
    local x = SHOW_PLACE__SELECTOR__X_START + (index * (GR__COLUMN__WIDTH + GR__COLUMN__PADDING))

    self.selector:setZIndex(GR__ZINDEX__MEDIUM)
    self.selector:build(SHOW_PLACE__SELECTOR__WIDTH, SHOW_PLACE__SELECTOR__HEIGHT, x, SHOW_PLACE__SELECTOR__Y)
end

function Board:showStackBottomScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "showStackBottomScene")

    if self.selectedColumn == nil then
        self:selectColumn(self.columns[1])
    end
end

function Board:showStackTopScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "showStackTopScene")

    if self.selectedColumn == nil then
        self:selectColumn(self.columns[1])
    end
end

function Board:showTurnOverScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "showTurnOverScene")

    local playerTotalScore = 0
    local opponentTotalScore = 0

    self:foreachColumn(function (column)

        if column.playerStack.isWon then
            playerTotalScore = playerTotalScore + 1
        elseif column.opponentStack.isWon then
            opponentTotalScore = opponentTotalScore + 1
        end
    end)

    local winText = " Won"

    if playerTotalScore >= 3 then
        winText = "GameOver: You"..winText
        self.director:setScene(SCENE_GAMEOVER)
    elseif opponentTotalScore >= 3 then
        winText = "GameOver: Opponent"..winText
        self.director:setScene(SCENE_GAMEOVER)
    end

    self.winLabel:build(GR__SCREEN__WIDTH, GR__SCREEN__HEIGHT, winText)
end

function Board:showGameOverScene()
    LogTrace(self.className, CLASS_BOARD_NAME, "showTurnOverScene")

    self.winLabel:setVisible(true)
    self.winLabel:moveTo(GR__SCREEN__WIDTH / 2, GR__SCREEN__HEIGHT / 2)
    self.winCover:build(GR__SCREEN__WIDTH / 2, GR__SCREEN__HEIGHT / 2, GR__SCREEN__WIDTH, GR__SCREEN__HEIGHT)
    self.winCover:setVisible(true)
end

function Board:foreachColumn(func)
    LogTrace(self.className, CLASS_BOARD_NAME, "foreachColumn")

    for index, column in pairs(self.columns) do
        func(column, index)
    end
end