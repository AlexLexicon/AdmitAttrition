LOGGER_LEVEL_DEBUG = 1
LOGGER_LEVEL_TRACE = 2
LOGGER_LEVEL_INFORMATION = 3
LOGGER_LEVEL_WARNING = 4
LOGGER_LEVEL_ERROR = 5

local LOGGER_LEVEL_DEBUG_NAME = "DEBUG"
local LOGGER_LEVEL_TRACE_NAME = "TRACE"
local LOGGER_LEVEL_INFORMATION_NAME = "INFO"
local LOGGER_LEVEL_WARNING_NAME = "WARN"
local LOGGER_LEVEL_ERROR_NAME = "ERROR"

--[[logger:addFilter(function ()

	if isRunning == nil or isRunning == false then
		return false
	end
end)

--logger:addFilter(LOGGER_LEVEL_INFORMATION)
--logger:addFilter(LOGGER_LEVEL_WARNING)
--logger:addFilter(LOGGER_LEVEL_ERROR)]]--

function d(value) dt(value, false) end
function dt(value, trace)

    local message = ""

    if value ~= nil or (value == nil and trace ~= true) then
        message = "'"..tostring(value).."'"
    end

    if trace ~= false then

        if message ~= "" then
            message = message..": \n"
        end

        message = message..debug.traceback()
    end

    LogDebug(message)
end

function ld(messageOrclass, method) LogDebug(messageOrclass, method) end
function LogDebug(messageOrclass, method)
    log(messageOrclass, method, LOGGER_LEVEL_DEBUG)
end

function lt(messageOrclass, method) LogTrace(messageOrclass, method) end
function LogTrace(class, baseClass, method)
    local messageOrclass = nil

    if class ~= nil then
        messageOrclass = class
    end

    if baseClass ~= nil then

        if messageOrclass ~= nil then

            if baseClass ~= messageOrclass then
                messageOrclass = messageOrclass.."<"..baseClass..">"
            end
        else
            messageOrclass = baseClass
        end
    end

    log(messageOrclass, method, LOGGER_LEVEL_TRACE)
end

function li(messageOrclass, method) logInformation(messageOrclass, method) end
function logInformation(messageOrclass, method)
    log(messageOrclass, method, LOGGER_LEVEL_INFORMATION)
end

function lw(messageOrclass, method) logWarning(messageOrclass, method) end
function logWarning(messageOrclass, method)
    log(messageOrclass, method, LOGGER_LEVEL_WARNING)
end

function le(messageOrclass, method) logError(messageOrclass, method) end
function logError(messageOrclass, method)
    log(messageOrclass, method, LOGGER_LEVEL_ERROR)
end

function l(messageOrclass, method, level) log(messageOrclass, method, level) end
function log(messageOrclass, method, level)

    if logger ~= nil then
        logger:log(messageOrclass, method, level)
    end
end

CLASS_LOGGER_NAME = "Logger"
class(CLASS_LOGGER_NAME).extends()

function Logger:init(isActive)
    self.count = 0
    self.functionFilters = {}
    self.queryFilters = {}
    self.levelFilters = {}
    self.middlewares = {}
    self.isLogging = false
    self.printing = true
    self.isTraceback = false

    if isActive == nil then
        isActive = true
    end

    self.isActive = isActive
end

function Logger:disable()
    self.isLogging = true
end

function Logger:start()
    self.isActive = true
end

function Logger:stop()
    self.isActive = false
end

function Logger:addFilter(functionOrClassMessageQueryOrLevelFilter, methodQuery, levelQuery)
    local paramType = type(functionOrClassMessageQueryOrLevelFilter)
    if paramType == "number" then
        self:addLevelFilter(functionOrClassMessageQueryOrLevelFilter)
    elseif paramType == "string" or type(methodQuery) == "string" or levelQuery == "number" then
        self:addQueryFilter(functionOrClassMessageQueryOrLevelFilter, methodQuery, levelQuery)
    else
        self:addFunctionFilter(functionOrClassMessageQueryOrLevelFilter)
    end
end

function Logger:addFunctionFilter(filterFunction)
    local index = #self.functionFilters + 1

    self.functionFilters[index] = filterFunction
end

function Logger:addQueryFilter(classOrMessageQuery, methodQuery, levelQuery)
    local index = #self.queryFilters + 1

    local query = function (classOrMessage, method, level)
        local classOrMessageCheck = classOrMessageQuery == nil or contains(classOrMessage, classOrMessageQuery)
        local methodCheck = methodQuery == nil or contains(method, methodQuery)
        local levelCheck = levelQuery == nil or levelQuery == level

        return classOrMessageCheck and methodCheck and levelCheck
    end

    self.queryFilters[index] = query
end

function Logger:addLevelFilter(level)
    local index = #self.levelFilters + 1

    self.levelFilters[index] = level
end

function Logger:addMiddleware(middleware)
    local index = #self.middlewares

    self.middlewares[index] = middleware
end

function Logger:isFilteredByFunctions(classOrMessage, method, level)
    local isFiltered = nil

    for _, filter in pairs(self.functionFilters) do
        local isIncluded = filter(classOrMessage, method, level)

        if isIncluded == false then
            isFiltered = false
        elseif isIncluded == true then
            isFiltered = true
            forced = true
            break
        end
    end

    return isFiltered
end

function Logger:isFilteredByQueries(classOrMessage, method, level, isFiltered)

    if isFiltered == false or isFiltered == true then
        return isFiltered
    end

    for _, query in pairs(self.queryFilters) do
        isFiltered = query(classOrMessage, method, level)

        if isFiltered == true then
            break
        end
    end

    return isFiltered
end

function Logger:isFilteredByLevel(level, isFiltered)

    if level == nil or isFiltered == false or isFiltered == true then
        return isFiltered
    end

    for _, levelFilter in pairs(self.levelFilters) do
        isFiltered = levelFilter == level

        if isFiltered == true then
            break
        end
    end

    return isFiltered
end

function Logger:log(classOrMessage, method, level)

    if self.isActive == true and self.isLogging == false then
        self.isLogging = true

        for _, middleware in pairs(self.middlewares) do
            middleware(classOrMessage, method)
        end

        local isFiltered = self:isFilteredByFunctions(classOrMessage, method, level)
        isFiltered = self:isFilteredByQueries(classOrMessage, method, level, isFiltered)
        isFiltered = self:isFilteredByLevel(level, isFiltered)

        if isFiltered == true then

            local levelName = ""
            local trace = ""

            if level == LOGGER_LEVEL_DEBUG then
                levelName = LOGGER_LEVEL_DEBUG_NAME
            elseif level == LOGGER_LEVEL_TRACE then
                levelName = LOGGER_LEVEL_TRACE_NAME

                if self.isTraceback then
                    trace = debug.traceback()
                end
            elseif level == LOGGER_LEVEL_INFORMATION then
                levelName = LOGGER_LEVEL_INFORMATION_NAME
            elseif level == LOGGER_LEVEL_WARNING then
                levelName = LOGGER_LEVEL_WARNING_NAME
            elseif level == LOGGER_LEVEL_ERROR then
                levelName = LOGGER_LEVEL_ERROR_NAME
            end

            if classOrMessage == nil then
                classOrMessage = ""
            elseif method == nil then
                method = ""
            else
                method = method.."()"
                classOrMessage = classOrMessage.."."
            end

            self.count = self.count + 1

            local countString = string.format("%06d", self.count)

            levelName = string.format("%5s", levelName).." "

            if self.printing then
                print(levelName.."["..countString.."]: "..tostring(classOrMessage)..tostring(method)..trace)
            end
        end

        self.isLogging = false
    end
end