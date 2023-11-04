GAME__CARD__SUIT_SPADES = 1
GAME__CARD__SUIT_HEARTS = 2
GAME__CARD__SUIT_CLUBS = 3
GAME__CARD__SUIT_DIAMONDS = 4

GAME__CARD_SUITS = { GAME__CARD__SUIT_SPADES, GAME__CARD__SUIT_HEARTS, GAME__CARD__SUIT_CLUBS, GAME__CARD__SUIT_DIAMONDS }
GAME__CARD_NUMBERS = { 2, 3, 4, 5, 6, 7, 8, 9, 10 }

GAME__DECK_SIZE = #GAME__CARD_NUMBERS * #GAME__CARD_SUITS

GAME__HAND_SIZE = 5

STACK_MAXIMUM_CARD_COUNT = 3

STACK_SCORE_MULTIPLER_NONE = 1
STACK_SCORE_MULTIPLER_STRAIGHT = 10
STACK_SCORE_MULTIPLER_FLUSH = 100
STACK_SCORE_MULTIPLER_MATCH = 1000
STACK_SCORE_MULTIPLER_STRAIGHTFLUSH = 10000

BOARD_COLUMNS_COUNT = 6