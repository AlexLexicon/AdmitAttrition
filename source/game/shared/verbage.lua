local VERBAGE__DECK__LABEL_START = "The deck has "
local VERBAGE__DECK__LABEL_END = " cards remaining"

VERBAGE__PLAYER__LABEL = "You have no cards left"

function VERBAGE__DECK__LABEL(cardsCount)
    return VERBAGE__DECK__LABEL_START..cardsCount..VERBAGE__DECK__LABEL_END
end