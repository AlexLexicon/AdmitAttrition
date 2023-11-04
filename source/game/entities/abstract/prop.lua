CLASS_PROP_NAME = "Prop"
class(CLASS_PROP_NAME).extends(Entity())

function Prop:init()
    LogTrace(self.className, CLASS_PROP_NAME, "init")

    Prop.super.init(self)

    self.isSelected = false
    self.selectionEvent = nil

    --self:add()
end

function Prop:getEqualityValues()
    LogTrace(self.className, CLASS_PROP_NAME, "getEqualityValues")

    return error("must implement the getEqualityValues() method from derived Prop class.")
end

function Prop:equals(prop)
    LogTrace(self.className, CLASS_PROP_NAME, "equals")

    if prop == nil or type(prop) ~= type(self) then
        return false
    end

    local propEqualityValues = prop:getEqualityValues()
    local myEqualityValues = self:getEqualityValues()

    for index, myEqualityValue in pairs(myEqualityValues) do
        local propEqualityValue = propEqualityValues[index]

        if myEqualityValue ~= propEqualityValue then
            return false
        end
    end

    return true
end

function Prop:setSelectionSceneEvent(actor, callback)
    LogTrace(self.className, CLASS_PROP_NAME, "setSelectionSceneEvent")

    self.selectionEvent = Event(callback)
    actor.director:addSceneEvent(self.selectionEvent)
end

function Prop:setIsSelected(isSelected)
    LogTrace(self.className, CLASS_PROP_NAME, "setIsSelected")

    if self.isSelected ~= isSelected then
        self.isSelected = isSelected

        if self.selectionEvent ~= nil and self.selectionEvent.isEnabled then

            self.selectionEvent:fire(self.isSelected)
        end
    end
end
