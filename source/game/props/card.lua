local CORNER_RADIUS_FACTOR = 25

local WIDTH_PROPORTION = 36

local BORDER__PROPORTION = 0.75

local SYMBOL__WIDTH_PROPORTION = 6--real life: 4
local SYMBOL__PADDING_PROPORTION = 0.75

local NUMBER__HEIGHT_PROPORTION = 8--real life: 6
local NUMBER__PADDING = 4

local SUIT__HEIGHT_PROPORTION = 6.25--real life: 4.25

CLASS_CARD_NAME = "Card"
class(CLASS_CARD_NAME).extends(Prop())

function Card:init(number, suit)
    LogTrace(self.className, CLASS_CARD_NAME, "init")

    Card.super.init(self)

    self.isFront = true
    self.isSlim = false
    self.number = number
    self.suit = suit

    self:add()
end

--override
function Card:getEqualityValues()
    LogTrace(self.className, CLASS_CARD_NAME, "getEqualityValues")

    return {
        self.number,
        self.suit
    }
end

function Card:build(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "build")

    width = math.round(width)
    height = math.round(height)

    local image = gfx.image.new(width, height)

    if self.isSlim then
        local cornerRadius = width / CORNER_RADIUS_FACTOR
        local borderThickness = Card.getBorderThickness(width)

        local symbolWidth = ((width - (borderThickness * 2)) - 5) / 2

        local size = math.min(symbolWidth, height)

        local numberImage = self:generateNumberImage(size, size)
        local suitImage = self:generateSuitImage(size - 4, size - 4)

        local yCenter = (height - size) / 2

        gfx.pushContext(image)
            gfx.fillRoundRect(0, 0, width, height, cornerRadius)
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRoundRect(borderThickness, borderThickness, width - (borderThickness * 2), height - (borderThickness * 2), cornerRadius)
            gfx.setColor(gfx.kColorBlack)
            numberImage:draw(0, yCenter)
            suitImage:draw(width - size - 2, yCenter + 2)
        gfx.popContext()
    else
        local contentsImage = nil
        local cornerRadius = width / CORNER_RADIUS_FACTOR
        local borderThickness = Card.getBorderThickness(width)

        if self.isFront then
            contentsImage = self:generateFrontImage(width, height, borderThickness)
        else
            contentsImage = self:generateBackImage(width, height, borderThickness)
        end

        gfx.pushContext(image)
            gfx.fillRoundRect(0, 0, width, height, cornerRadius)
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRoundRect(borderThickness, borderThickness, width - (borderThickness * 2), height - (borderThickness * 2), cornerRadius)
            gfx.setColor(gfx.kColorBlack)
            contentsImage:draw(0, 0)
        gfx.popContext()
    end

    self:setImage(image)
end

function Card:generateFrontImage(width, height, borderThickness)
    LogTrace(self.className, CLASS_CARD_NAME, "generateFrontImage")

    width = math.round(width)
    height = math.round(height)

    local symbolPadding = Card.getSymbolPadding(width)
    local symbolWidth = Card.getSymbolWidth(width)
    local symbolHeight = Card.getSymbolHeight(width)
    local topSymbolX = borderThickness + symbolPadding
    local topSymbolY = borderThickness + symbolPadding
    local bottomSymbolX = width - borderThickness - symbolPadding - symbolWidth
    local bottomSymbolY = height - borderThickness - symbolPadding - symbolHeight

    local symbolImage = self:generateSymbolsImage(width)
    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        symbolImage:draw(topSymbolX, topSymbolY)
        symbolImage:draw(bottomSymbolX, bottomSymbolY, pd.graphics.kImageFlippedXY)
    gfx.popContext()

    return image
end

function Card:generateBackImage(width, height, borderThickness)
    LogTrace(self.className, CLASS_CARD_NAME, "generateBackImage")

    width = math.round(width)
    height = math.round(height)

    local symbolPadding = Card.getSymbolPadding(width) * 2
    local x = borderThickness + symbolPadding
    local y = borderThickness + symbolPadding
    local designWidth = width - (borderThickness * 2) - (symbolPadding * 2)
    local designHeight = height - (borderThickness * 2) - (symbolPadding * 2)

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.setPattern(0xaa, 0xaa, 0xaa, 0xaa, 0x55, 0x55, 0x55, 0x55)
        gfx.fillRect(x, y, designWidth, designHeight)
    gfx.popContext()

    return image
end

function Card:generateSymbolsImage(width)
    LogTrace(self.className, CLASS_CARD_NAME, "generateSymbolsImage")

    width = math.round(width)

    local symbolPadding = Card.getSymbolPadding(width)
    local symbolsWidth = Card.getSymbolWidth(width)
    local numberHeight = Card.getNumberHeight(width)
    local suitHeight = Card.getSuitHeight(width)
    local numberImage = self:generateNumberImage(symbolsWidth, numberHeight)
    local suitImage = self:generateSuitImage(symbolsWidth, suitHeight)

    local imageWidth = symbolsWidth
    local imageHeight = numberHeight + suitHeight + symbolPadding

    local suitX = 0
    local suitY = numberHeight + symbolPadding

    imageWidth = math.round(imageWidth)
    imageHeight = math.round(imageHeight)

    local image = gfx.image.new(imageWidth, imageHeight)

    gfx.pushContext(image)
        numberImage:draw(0, 0)
        suitImage:draw(suitX, suitY)
    gfx.popContext()

    return image
end

function Card:generateNumberImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateNumberImage")

    width = math.round(width)
    height = math.round(height)

    local textWidth, textHeight = gfx.getTextSize(self.number)

    textWidth = math.round(textWidth)
    textHeight = math.round(textHeight)

    textWidth = textWidth + 2
    textHeight = textHeight + 2

    local textImage = gfx.image.new(textWidth, textHeight)

    gfx.pushContext(textImage)
        gfx.drawText(self.number, 1, 1)
    gfx.popContext()

    local scale = math.min(width / textWidth, height / textHeight)
    local newStringImageWidth = textWidth * scale
    local newStringImageHeight = textHeight * scale
    local textImageX = (width / 2) - (newStringImageWidth / 2)
    local textImageY = (height / 2) - (newStringImageHeight / 2)
    local scaledImage = gfx.image.new(width, height)

    gfx.pushContext(scaledImage)
        textImage:drawScaled(textImageX, textImageY, scale)
    gfx.popContext()

    return scaledImage
end

function Card:generateSuitImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateSuitImage")

    if self.suit == GAME__CARD__SUIT_SPADES then
        return self:generateSuitSpadeImage(width, height)
    end

    if self.suit == GAME__CARD__SUIT_HEARTS then
        return self:generateHeartImage(width, height)
    end

    if self.suit == GAME__CARD__SUIT_CLUBS then
        return self:generateClubImage(width, height)
    end

    if self.suit == GAME__CARD__SUIT_DIAMONDS then
        return self:generateDiamondImage(width, height)
    end

    error("The suit '"..suit.."' does not have a sprite implementation.")
end

function Card:generateSuitSpadeImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateSuitSpadeImage")

    width = math.round(width)
    height = math.round(height)

    local circleDiameter = width / 2
    local stumpSize = width / 5
    local xCenter = width / 2
    local yCenter = height / 2
    local yOffset = width / 5

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.fillPolygon(0, yCenter + (circleDiameter / 4) - yOffset, xCenter, 0, width, yCenter + (circleDiameter / 4) - yOffset, width, yCenter + (circleDiameter / 2) - yOffset, 0, yCenter + (circleDiameter / 2) - yOffset)
        gfx.fillCircleInRect(0, yCenter - yOffset, circleDiameter, circleDiameter)
        gfx.fillCircleInRect(width - circleDiameter, yCenter - yOffset, circleDiameter, circleDiameter)
        gfx.fillRect(xCenter - (stumpSize / 2), circleDiameter / 2, stumpSize, (height / 2) + (circleDiameter / 2))
    gfx.popContext()

    return image
end

function Card:generateHeartImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateHeartImage")

    width = math.round(width)
    height = math.round(height)

    local circleDiameter = width / 2
    local xCenter = width / 2
    local yCenter = height / 2

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.fillCircleInRect(0, 0, circleDiameter, circleDiameter)
        gfx.fillCircleInRect(xCenter, 0, circleDiameter, circleDiameter)
        gfx.fillPolygon(0, circleDiameter / 2, 0, yCenter - (circleDiameter / 4), xCenter, height, width, yCenter - (circleDiameter / 4), width, circleDiameter / 2)
    gfx.popContext()

    return image
end

function Card:generateClubImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateClubImage")

    width = math.round(width)
    height = math.round(height)

    local circleDiameter = width / 2
    local stumpSize = circleDiameter / 3
    local xCenter = width / 2

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.fillCircleInRect((width / 2) - (circleDiameter / 2), 0, circleDiameter, circleDiameter)
        gfx.fillCircleInRect(0, (circleDiameter / 4) * 3, circleDiameter, circleDiameter)
        gfx.fillCircleInRect(xCenter, (circleDiameter / 4) * 3, circleDiameter, circleDiameter)
        gfx.fillRect(xCenter - (stumpSize / 2), circleDiameter / 2, stumpSize, (height / 2) + (circleDiameter / 2))
    gfx.popContext()

    return image
end

function Card:generateDiamondImage(width, height)
    LogTrace(self.className, CLASS_CARD_NAME, "generateDiamondImage")

    width = math.round(width)
    height = math.round(height)

    local xCenter = width / 2
    local yCenter = height / 2

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.fillPolygon(xCenter, 0, width, yCenter, xCenter, height, 0, yCenter)
    gfx.popContext()

    return image
end

function Card.getBorderThickness(width)
    LogTrace(CLASS_CARD_NAME, nil, "getBorderThickness")

    return (width * BORDER__PROPORTION) / WIDTH_PROPORTION
end

function Card.getSymbolPadding(width)
    LogTrace(CLASS_CARD_NAME, nil, "getSymbolPadding")

    return (width * SYMBOL__PADDING_PROPORTION) / WIDTH_PROPORTION
end

function Card.getSymbolWidth(width)
    LogTrace(CLASS_CARD_NAME, nil, "getSymbolWidth")

    return (width * SYMBOL__WIDTH_PROPORTION) / WIDTH_PROPORTION
end

function Card.getSymbolHeight(width)
    LogTrace(CLASS_CARD_NAME, nil, "getSymbolHeight")

    local numberHeight = Card.getNumberHeight(width)
    local suitHeight = Card.getSuitHeight(width)
    local symbolPadding = Card.getSymbolPadding(width)
    return numberHeight + symbolPadding + suitHeight
end

function Card.getNumberHeight(width)
    LogTrace(CLASS_CARD_NAME, nil, "getNumberHeight")

    return (width * NUMBER__HEIGHT_PROPORTION) / WIDTH_PROPORTION
end

function Card.getSuitHeight(width)
    LogTrace(CLASS_CARD_NAME, nil, "getSuitHeight")

    return (width * SUIT__HEIGHT_PROPORTION) / WIDTH_PROPORTION
end

function Card.getSymbolRegionWidth(width)
    LogTrace(CLASS_CARD_NAME, nil, "getSymbolRegionWidth")

    local borderThickness = Card.getBorderThickness(width)
    local symbolPadding = Card.getSymbolPadding(width)
    local symbolWidth = Card.getSymbolWidth(width)

    return symbolWidth + (symbolPadding * 2) + borderThickness
end
