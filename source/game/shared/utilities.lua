function notImplemented(description)
    LogTrace(nil, nil, "throw")

    local message = ""

    if description ~= nil then
        message = ": "..tostring(description)
    end

    throw("[NOT IMPLEMENTED]"..message)
end

function throw(message)
    LogTrace(nil, nil, "throw")

    logError(message)
    error(message)
end

function newGuid()
    LogTrace(nil, nil, "newGuid")

    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'

    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

function ctype(class)
    LogTrace(nil, nil, "ctype")

    return class.className
end

function cRequire(className, classes)
    LogTrace(nil, nil, "cRequire")

    local instance = nil

    for _, class in pairs(classes) do
        local classType = ctype(class)

        if classType == className then

            if instance ~= nil then
                throw("Only one '"..className.."' class is required.")
            end

            instance = class
        end
    end

    if instance == nil then
        throw("You must provide the required class '"..className.."'.")
    end

    return instance
end

function contains(str, value)
    LogTrace(nil, nil, "contains")

    if str == nil or value == nil then
        return false
    end

    if str == value then
        return true
    end

    if string.find(str, value, 0, true) then
        return true
    end

    return false
end

function math.round(num, numDecimalPlaces)

    if numDecimalPlaces == nil or numDecimalPlaces < 0 then
        numDecimalPlaces = 0
    end

    local mult = 10^(numDecimalPlaces)

    return math.floor(num * mult + 0.5) / mult
end

function table.add(table, element)
    LogTrace("table", nil, "add")

    table[#table + 1] = element
end

function table.contains(table, element)
    LogTrace("table", nil, "contains")

    for _, value in pairs(table) do

        if value == element then
            return true
        end
    end

    return false
  end

function table.random(table)
    LogTrace("table", nil, "randomItem")

    return table[math.random(#table)]
end

function table.shuffle(table)
    LogTrace("table", nil, "shuffle")

    for index = #table, 2, -1 do
        local newIndex = math.random(index)

        table[index], table[newIndex] = table[newIndex], table[index]
    end
    return table
end
