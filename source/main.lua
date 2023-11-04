import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "configuration"
import "game/constants/general"
import "game/constants/game"
import "game/shared/logger"
import "game/shared/input"
import "game/shared/verbage"
import "game/shared/utilities"
import "game/director"
import "game/trigger"
import "game/event"
import "game/abstract/actor"
import "game/abstract/entity"
import "game/actors/abstract/hand"
import "game/entities/abstract/prop"
import "game/props/card"
import "game/constants/graphics"
import "game/entities/label"
import "game/entities/selector"
import "game/entities/cover"
import "game/actors/player"
import "game/actors/opponent"
import "game/actors/column"
import "game/actors/board"
import "game/actors/deck"
import "game/actors/stack"

--call game "card stack kings?""

local includeTrace = false
logger = Logger()
--logger:addFilter(nil, "showStackBottomScene")
--logger:addFilter(nil, "setActorScene")
logger:addFilter(function (_, _, level)

	if level == LOGGER_LEVEL_DEBUG then
		return true
	end
end)
logger:addFilter(LOGGER_LEVEL_INFORMATION)
logger:addFilter(LOGGER_LEVEL_WARNING)
logger:addFilter(LOGGER_LEVEL_ERROR)
if includeTrace then
	logger:addFilter(LOGGER_LEVEL_TRACE)
	logger:addFilter(function (_, method)

		if contains(method, "update") or contains(method, "Update") then
			return false
		end
	end)
end
--logger:addFilter(nil, "animateTo")
--logger:stop()
--logger:addFilter("Player", "showCombinedScene")
--logger:addFilter(LOGGER_LEVEL_TRACE)

local director = nil
local menu = playdate.getSystemMenu()

menu:addMenuItem("Restart", function()

	if director ~= nil then
		director:dispose()
	end

    director = nil
end)

--[Run]
isRunning = false

function pd.update()
	inputUpdate()

	if director == nil then
		isRunning = true

		director = Director()

		director:setScene(SCENE_COMBINED)

		for _ = 1, GAME__HAND_SIZE do
			director.deck:deal(director.player)
			director.deck:deal(director.opponent)
		end
	else
		director:update()
		gfx.sprite.update()
		gfx.animation.blinker.updateAll()
		pd.timer.updateTimers()
	end
	--pd.drawFPS(0,0)
end
