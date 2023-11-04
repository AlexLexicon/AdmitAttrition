CLASS_ACTOR_NAME = "Actor"
class(CLASS_ACTOR_NAME).extends()

function Actor:init()
    LogTrace(self.className, CLASS_ACTOR_NAME, "init")

    self.showSceneTable = {
        [SCENE_COMBINED] = self.showCombinedScene,
        [SCENE_HAND] = self.showHandScene,
        [SCENE_BOARD] = self.showBoardScene,
        [SCENE_PLACE] = self.showPlaceScene,
        [SCENE_STACK_BOTTOM] = self.showStackBottomScene,
        [SCENE_STACK_TOP] = self.showStackTopScene,
        [SCENE_DECK] = self.showDeckScene,
        [SCENE_DRAW] = self.showDrawScene,
        [SCENE_OPPONENT] = self.showOpponentScene,
        [SCENE_TURNOVER] = self.showTurnOverScene,
        [SCENE_GAMEOVER] = self.showGameOverScene,
    }
    self.updateSceneTable = {
        [SCENE_COMBINED] = self.updateCombinedScene,
        [SCENE_HAND] = self.updateHandScene,
        [SCENE_BOARD] = self.updateBoardScene,
        [SCENE_PLACE] = self.updatePlaceScene,
        [SCENE_STACK_BOTTOM] = self.updateStackBottomScene,
        [SCENE_STACK_TOP] = self.updateStackTopScene,
        [SCENE_DECK] = self.updateDeckScene,
        [SCENE_DRAW] = self.updateDrawScene,
        [SCENE_OPPONENT] = self.updateOpponentScene,
        [SCENE_TURNOVER] = self.updateTurnOverScene,
        [SCENE_GAMEOVER] = self.updateGameOverScene,
    }
    self.id = newGuid()
    self.director = nil
    self.isRefreshScene = false
    self.isSelected = false
    self.selectionEvent = nil
end

function Actor:dispose()
    LogTrace(self.className, CLASS_ACTOR_NAME, "dispose")
end

function Actor:addSceneTrigger(delay, callback)
    LogTrace(self.className, CLASS_ACTOR_NAME, "addSceneTrigger")

    if callback == nil then
        callback = delay
        delay = 0
    end

    self.director:addSceneTrigger(Trigger(delay, callback))
end

function Actor:addTrigger(delay, callback)
    LogTrace(self.className, CLASS_ACTOR_NAME, "addTrigger")

    if callback == nil then
        callback = delay
        delay = 0
    end

    self.director:addTrigger(Trigger(delay, callback))
end

function Actor:equals(actor)
    LogTrace(self.className, CLASS_ACTOR_NAME, "equals")

    if actor == nil or type(actor) ~= type(self) then
        return false
    end

    return actor.id == self.id
end

function Actor:setSelectionSceneEvent(actor, callback)
    LogTrace(self.className, CLASS_ACTOR_NAME, "setSelectionSceneEvent")

    self.selectionEvent = Event(callback)
    actor.director:addSceneEvent(self.selectionEvent)
end

function Actor:setIsSelected(isSelected)
    LogTrace(self.className, CLASS_ACTOR_NAME, "setIsSelected")

    if self.isSelected ~= isSelected then
        self.isSelected = isSelected

        if self.selectionEvent ~= nil and self.selectionEvent.isEnabled then

            self.selectionEvent:fire(self.isSelected)
        end
    end
end

function Actor:refresh()
    LogTrace(self.className, CLASS_ACTOR_NAME, "refresh")

    self.isRefreshScene = true
end

function Actor:beforeShowScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "beforeShowScene")
end

function Actor:afterShowScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "afterShowScene")
end

function Actor:showDefaultScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showDefaultScene")
end

function Actor:showCombinedScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showCombinedScene")
    self:showDefaultScene()
end

function Actor:showHandScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showHandScene")
    self:showDefaultScene()
end

function Actor:showBoardScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showBoardScene")
    self:showDefaultScene()
end

function Actor:showPlaceScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showPlaceScene")
    self:showDefaultScene()
end

function Actor:showStackBottomScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showStackBottomScene")
    self:showDefaultScene()
end

function Actor:showStackTopScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showStackTopScene")
    self:showDefaultScene()
end

function Actor:showDeckScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showDeckScene")
    self:showDefaultScene()
end

function Actor:showDrawScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showDrawScene")
    self:showDefaultScene()
end

function Actor:showOpponentScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showOpponentScene")
    self:showDefaultScene()
end

function Actor:showTurnOverScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showTurnOverScene")
    self:showDefaultScene()
end

function Actor:showGameOverScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "showGameOverScene")
    self:showDefaultScene()
end

function Actor:beforeUpdateScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "beforeUpdateScene")
end

function Actor:afterUpdateScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "afterUpdateScene")
end

function Actor:updateDefaultScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateDefaultScene")
end

function Actor:updateCombinedScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateCombinedScene")
    self:updateDefaultScene()
end

function Actor:updateHandScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateHandScene")
    self:updateDefaultScene()
end

function Actor:updateBoardScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateBoardScene")
    self:updateDefaultScene()
end

function Actor:updatePlaceScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updatePlaceScene")
    self:updateDefaultScene()
end

function Actor:updateStackBottomScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateStackBottomScene")
    self:updateDefaultScene()
end

function Actor:updateStackTopScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateStackTopScene")
    self:updateDefaultScene()
end

function Actor:updateDeckScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateDeckScene")
    self:updateDefaultScene()
end

function Actor:updateDrawScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateDrawScene")
    self:updateDefaultScene()
end

function Actor:updateOpponentScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateOpponentScene")
    self:updateDefaultScene()
end

function Actor:updateTurnOverScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateTurnOverScene")
    self:updateDefaultScene()
end

function Actor:updateGameOverScene()
    LogTrace(self.className, CLASS_ACTOR_NAME, "updateGameOverScene")
    self:updateDefaultScene()
end

function Actor.contains(actorsTable, actor)
    LogTrace(CLASS_ACTOR_NAME, nil, "contains")

    for _, actorInTable in pairs(actorsTable) do

        if actorInTable:equals(actor) then
            return true
        end
    end

    return false
end