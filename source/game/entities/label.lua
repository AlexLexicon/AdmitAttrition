local LABEL_DEFAULT_BORDER_THICKNESS = 5
local LABEL_DEFAULT_TEXT_PADDING = 10

CLASS_LABEL_NAME = "Label"
class(CLASS_LABEL_NAME).extends(Entity())

function Label:init(border, textPadding)
    LogTrace(self.className, CLASS_LABEL_NAME, "init")

    Label.super.init(self)

    self.borderTop = LABEL_DEFAULT_BORDER_THICKNESS
    self.borderRight = LABEL_DEFAULT_BORDER_THICKNESS
    self.borderBottom = LABEL_DEFAULT_BORDER_THICKNESS
    self.borderLeft = LABEL_DEFAULT_BORDER_THICKNESS

    self:setBorder(border)

    self.textPadding = textPadding
    self.savedWidth = nil
    self.savedHeight = nil
    self.text = ""
    self.isFilled = false

    if self.textPadding == nil then
        self.textPadding = LABEL_DEFAULT_TEXT_PADDING
    end

    self:add()
end

function Label:setFill(isFilled)
    LogTrace(self.className, CLASS_LABEL_NAME, "setFill")

    self.isFilled = isFilled
    self:build()
end

function Label:setBorder(border)
    LogTrace(self.className, CLASS_LABEL_NAME, "setBorder")

    if type(border) == "number" then
        self.borderTop = border
        self.borderRight = border
        self.borderBottom = border
        self.borderLeft = border
    elseif type(border) == "table" then
        self.borderTop = border[TOP]
        self.borderRight = border[RIGHT]
        self.borderBottom = border[BOTTOM]
        self.borderLeft = border[LEFT]
    end
end

function Label:generateTextImage(width, height)
    LogTrace(self.className, CLASS_LABEL_NAME, "generateTextImage")

    width = math.round(width)
    height = math.round(height)

    local text = self.text

    if text == nil or text == "" then
        return nil
    end

    local textWidth, textHeight = gfx.getTextSize(text)

    textWidth = math.round(textWidth)
    textHeight = math.round(textHeight)

    --we are adding 2 here and applying an offset of 1 during the draw in order to add a single pixel padding around the text which helps the scaling look much better.
    textWidth = textWidth + 2
    textHeight = textHeight + 2

    local stringImage = gfx.image.new(textWidth, textHeight)

    gfx.pushContext(stringImage)
        gfx.drawText(text, 1, 1)
    gfx.popContext()

    local targetWidth = width - (self.textPadding * 2)
    local targetHeight = height - (self.textPadding * 2)
    local scale = math.min(targetWidth / textWidth, targetHeight / textHeight)
    local newStringImageWidth = textWidth * scale
    local newStringImageHeight = textHeight * scale
    local textImageX = (width / 2) - (newStringImageWidth / 2)
    local textImageY = (height / 2) - (newStringImageHeight / 2)
    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        stringImage:drawScaled(textImageX, textImageY, scale)
    gfx.popContext()

    return image
end

function Label:build(width, height, text)
    LogTrace(self.className, CLASS_LABEL_NAME, "build")

    if type(width) == "string" and text == nil then
        text = width
        width = nil
    end

    if text ~= nil then
        self.text = text
    end

    if width == nil then
        width = self.savedWidth
    end
    if height == nil then
        height = self.savedHeight
    end

    width = math.round(width)
    height = math.round(height)

    --width = math.ceil(width)
    --height = math.ceil(height)

    self.savedWidth = width
    self.savedHeight = height

    local image = gfx.image.new(width, height)

    local textImage = self:generateTextImage(width, height)

    gfx.pushContext(image)
        gfx.setColor(gfx.kColorBlack)

        if self.isFilled then
            gfx.fillRect(0, 0, width, height)
        else
            if self.borderTop > 0 then
                gfx.fillRect(0, 0, width, self.borderTop)
            end

            if self.borderRight > 0 then
                gfx.fillRect(width - self.borderRight, 0, width, height)
            end

            if self.borderBottom > 0 then
                gfx.fillRect(0, height - self.borderBottom, width, height)
            end

            if self.borderLeft > 0 then
                gfx.fillRect(0, 0, self.borderLeft, height)
            end
        end

        if textImage ~= nil then
            textImage:draw(0, 0)
        end
    gfx.popContext()

    self:setImage(image)
end