CLASS_ENTITY_NAME = "Entity"
class(CLASS_ENTITY_NAME).extends(gfx.sprite)

function Entity:init()
    LogTrace(self.className, CLASS_ENTITY_NAME, "init")

    Entity.super.init(self)

    self.id = newGuid()
    self.animator = nil
    self.isAnimating = false

    self.animatingToX = nil
    self.animatingToY = nil

    self:add()
end

function Entity:dispose()
    LogTrace(self.className, CLASS_ENTITY_NAME, "updisposedate")

    self:remove()
end

function Entity:update()
    LogTrace(self.className, CLASS_ENTITY_NAME, "update")

    if self.isAnimating == true and (self.animator == nil or self.animator:ended()) then
        self.isAnimating = false
    end
end

function Entity:animateTo(duration, x, y)
    LogTrace(self.className, CLASS_ENTITY_NAME, "animateTo")

    local currentX, currentY = self:getPosition()
    local currentPosition = pd.geometry.point.new(currentX, currentY)

    if x == nil then

        if self.animatingToX == nil then
            x = currentX
        else
            x = self.animatingToX
        end
    end

    if y == nil then

        if self.animatingToY == nil then
            y = currentY
        else
            y = self.animatingToY
        end
    end

    self.animatingToX = x
    self.animatingToY = y

    local newPosition = pd.geometry.point.new(x, y)
    self.animator = gfx.animator.new(duration, currentPosition, newPosition)

    self.isAnimating = true
    self:setAnimator(self.animator)

    return self.animator
end

function Entity:animateToY(duration, y)
    LogTrace(self.className, CLASS_ENTITY_NAME, "animateToY")

    return self:animateTo(duration, nil, y)
end

function Entity:animateToX(duration, x)
    LogTrace(self.className, CLASS_ENTITY_NAME, "animateToX")

    return self:animateTo(duration, x, nil)
end
