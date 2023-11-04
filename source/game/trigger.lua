CLASS_TRIGGER_NAME = "Trigger"
class(CLASS_TRIGGER_NAME).extends()

function Trigger:init(delay, callback)
    LogTrace(self.className, CLASS_TRIGGER_NAME, "init")

    self.delay = delay
    self.callback = callback
    self.isRepeated = isRepeated
    self.isEnabled = true
    self.isTriggered = false
    self.isCompleted = false

    self:run()
end

function Trigger:run()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "run")

    if self.isEnabled then
        self.isTriggered = false
        self.isCompleted = false

        if self.delay ~= nil and self.delay > 0 then
            pd.timer.performAfterDelay(self.delay, self.internalCallback, self)
        else
            --if no delay is provided then we immediately callback internally (Which wont actually callback to the source until the next update call)
            self:internalCallback()
        end
    end
end

function Trigger:enable()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "enable")

    self.isEnabled = true
end

function Trigger:disable()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "disable")

    self.isEnabled = false
end

function Trigger:complete()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "complete")

    self.isCompleted = true
end

function Trigger:internalCallback()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "internalCallback")

    if self.isEnabled == true then
        self.isTriggered = true
    end
end

function Trigger:update()
    LogTrace(self.className, CLASS_TRIGGER_NAME, "update")

    if self.isTriggered and self.isCompleted == false and self.isEnabled then
        self.isTriggered = false
        self.callback()

        if self.isRepeated then
            self:run()
        else
            self:complete()
        end
    end
end