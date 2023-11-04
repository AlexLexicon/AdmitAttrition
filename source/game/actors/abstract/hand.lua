CLASS_HAND_NAME = "Hand"
class(CLASS_HAND_NAME).extends(Actor())

function Hand:init(board)
    LogTrace(self.className, CLASS_HAND_NAME, "init")

    Hand.super.init(self)

    self.cards = {}
    self.board = board
    self.selectedCard = nil
end

function Hand:dispose()
    LogTrace(self.className, CLASS_HAND_NAME, "dispose")

    Hand.super.dispose(self)

    self:foreachCard(function (card)
        card:dispose()
    end)
end

function Hand:foreachCard(func)
    LogTrace(self.className, CLASS_HAND_NAME, "foreachCard")

    for index, card in pairs(self.cards) do
        func(card, index)
    end
end

function Hand:canAddCard(cardToAdd)
    LogTrace(self.className, CLASS_HAND_NAME, "canAddCard")

    self:foreachCard(function (card)

        if card:equals(cardToAdd) then
            logWarning("the card is already contained in the cards table.")
            return false
        end
    end)

    return true
end

function Hand:addCard(cardToAdd)
    LogTrace(self.className, CLASS_HAND_NAME, "addCard")

    if self:canAddCard(cardToAdd) == false then
        throw("Cannot add the provided card. Call 'canAddCard()' before calling 'addCard()' to handle this error.")
    end

    local index = #self.cards + 1

    self.cards[index] = cardToAdd
    self:refresh()
end

function Hand:canPlaySelectedCard()
    LogTrace(self.className, CLASS_HAND_NAME, "canPlaySelectedCard")

    local cardsCount = #self.cards
    local hasAtLeastOneCard = cardsCount > 0
    local selectedCardIsNotNil = self.selectedCard ~= nil
    local canPlayOnBoard = self.board:canPlayCard(self.selectedCard, self)

    if hasAtLeastOneCard == false then
        logWarning("The hand does not have at least one card.")
        return false
    end

    if selectedCardIsNotNil == false then
        logWarning("The selected card is not nil.")
        return false
    end

    if canPlayOnBoard == false then
        logWarning("Cannot play the card on the board.")
        return false
    end

    return true
end

function Hand:playSelectedCard()
    LogTrace(self.className, CLASS_HAND_NAME, "playSelectedCard")

    if self:canPlaySelectedCard() == false then
        throw("Cannot play the selected card. Call 'canPlaySelectedCard()' before calling 'playSelectedCard()' to handle this error.")
    end

    self:foreachCard(function (card, index)

        if card:equals(self.selectedCard) then
            selectedCardIndex = index
        end
    end)

    if selectedCardIndex == nil then
        throw("The resulting 'selectedCardIndex' was nil, but the actual 'selectedCard' was not.")
    end

    self.board:playCard(self.selectedCard, self)
    table.remove(self.cards, selectedCardIndex)
    self:refresh()
end