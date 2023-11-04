CLASS_EVENT_NAME = "Event"
class(CLASS_EVENT_NAME).extends()

function Event:init(callback)
    LogTrace(self.className, CLASS_EVENT_NAME, "init")

    self.callback = callback
    self.args = nil
    self.isEnabled = true
    self.isFired = false
end

function Event:fire(...)
    LogTrace(self.className, CLASS_EVENT_NAME, "run")

    if self.isEnabled then
        self.isFired = true
        self.args = ...
    end
end

function Event:enable()
    LogTrace(self.className, CLASS_EVENT_NAME, "enable")

    self.isEnabled = true
end

function Event:disable()
    LogTrace(self.className, CLASS_EVENT_NAME, "disable")

    self.isEnabled = false
end

function Event:callBack()

    if self.isFired and self.isEnabled then
        self.isFired = false
        self.callback(self.args)
    end
end

function Event:update()
    LogTrace(self.className, CLASS_EVENT_NAME, "update")

    self:callBack()
end