local SELECTOR_ANIMATION_MOVE_MILLISECONDS = DURATION_SHORT
local SELECTOR_ANIMATION_BLINK_MILLISECONDS = DURATION_LONG
local SELECTOR_BORDER_THICKNESS = 5

CLASS_SELECTOR_NAME = "Selector"
class(CLASS_SELECTOR_NAME).extends(Label())

function Selector:init(x, y, border)
    LogTrace(self.className, CLASS_SELECTOR_NAME, "init")

    Selector.super.init(self, border, nil)

    self.blinker = nil
    --self.savedWidth = nil
    --self.savedHeight = nil
    self.moveAnimator = nil

    self:add()
    self:build(nil, nil, x, y)
end

--override
function Selector:update()
    LogTrace(self.className, CLASS_SELECTOR_NAME, "update")

    Selector.super.update(self)

    if self.blinker ~= nil then
        self:setVisible(self:isShow())
    end
end

function Selector:isShow()
    LogTrace(self.className, CLASS_SELECTOR_NAME, "isShow")

    return (self.moveAnimator ~= nil and not self.moveAnimator:ended()) or self.blinker.on
end

function Selector:build(width, height, x, y)
    LogTrace(self.className, CLASS_SELECTOR_NAME, "build")

    if width == nil and height == nil and x ~= nil and y ~= nil then
        self:moveTo(x, y)

        return
    end

    if width ~= nil and height ~= nil and x == nil and y == nil then
        Selector.super.build(self, width, height)
        --[[local image = gfx.image.new(width, height)

        self.savedWidth = width
        self.savedHeight = height

        gfx.pushContext(image)
            gfx.setLineWidth(SELECTOR_BORDER_THICKNESS)
            gfx.drawRect(0, 0, width, height)
        gfx.popContext()

        self:setImage(image)]]--

        return
    end

    if x ~= nil and y ~= nil and width ~= nil and height ~= nil then

        if width ~= self.savedWidth or height ~= self.savedHeight then
            self:build(width, height)
        end

        self:setVisible(true)
        self.moveAnimator = self:animateTo(SELECTOR_ANIMATION_MOVE_MILLISECONDS, x, y)

        if self.blinker == nil then
            self.blinker = gfx.animation.blinker.new()
            self.blinker.onDuration = SELECTOR_ANIMATION_BLINK_MILLISECONDS
            self.blinker.offDuration = SELECTOR_ANIMATION_BLINK_MILLISECONDS
            self.blinker:startLoop()
        end

        return
    end

    self:setVisible(false)

    if self.blinker ~= nil then
        self.blinker:stop()
        self.blinker = nil
    end
end