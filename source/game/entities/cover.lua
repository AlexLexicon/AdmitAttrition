CLASS_COVER_NAME = "Cover"
class(CLASS_COVER_NAME).extends(Entity())

function Cover:init()
    LogTrace(self.className, CLASS_COVER_NAME, "init")

    Cover.super.init(self)
    self:add()
    self:setVisible(false)
end

function Cover:build(x, y, width, height)
    LogTrace(self.className, CLASS_COVER_NAME, "build")

    width = math.round(width)
    height = math.round(height)

    local patternImage = gfx.image.new(width, height)

    gfx.pushContext(patternImage)
        gfx.setPattern(0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55)
        gfx.fillRect(0, 0, width, height)
    gfx.popContext()

    local image = gfx.image.new(width, height)

    gfx.pushContext(image)
        gfx.setImageDrawMode(gfx.kDrawModeBlackTransparent)
        patternImage:draw(0, 0)
    gfx.popContext()

    self:setImage(image)
    self:moveTo(x, y)
end