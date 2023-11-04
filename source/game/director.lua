SCENE_COMBINED = 1
SCENE_HAND = 2
SCENE_BOARD = 3
SCENE_PLACE = 4
SCENE_STACK_BOTTOM = 5
SCENE_STACK_TOP = 6
SCENE_DECK = 7
SCENE_DRAW = 8
SCENE_OPPONENT = 9
SCENE_TURNOVER = 10
SCENE_GAMEOVER = 11

CLASS_DIRECTOR_NAME = "Director"
class(CLASS_DIRECTOR_NAME).extends()

function Director:init()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "init")
	local columns = {}

	self.actors = {}

    for index = 1, BOARD_COLUMNS_COUNT do
		local text = "K"..index
		local canWin = true

		if index >= BOARD_COLUMNS_COUNT then
			text = "Free"
			canWin = false
		end

		local opponentStack = Stack(TOP, canWin)
		local playerStack = Stack(BOTTOM, canWin)
		local column = Column(index, opponentStack, playerStack, text)

		opponentStack.column = column
		playerStack.column = column

		table.add(columns, column)
		table.add(self.actors, opponentStack)
		table.add(self.actors, playerStack)
		table.add(self.actors, column)
    end

	self.board = Board(columns)
	self.player = Player(self.board)
	self.opponent = Opponent(self.board)
	self.deck = Deck(self.player, self.opponent)

	table.add(self.actors, self.board)
	table.add(self.actors, self.player)
	table.add(self.actors, self.opponent)
	table.add(self.actors, self.deck)

	self:foreachActor(function (actor)
		actor.director = self
	end)

    self.scene = nil
	self.previousScene = nil

	self.triggers = {}
	self.sceneTriggers = {}
	self.events = {}
	self.sceneEvents = {}

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
end

function Director:dispose()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "dispose")

	self:foreachActor(function (actor)
		actor:dispose()
	end)
end

function Director:beforeShowScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "beforeShowScene")
end

function Director:afterShowScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "afterShowScene")
end

function Director:showCombinedScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showCombinedScene")
end

function Director:showHandScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showHandScene")
end

function Director:showBoardScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showBoardScene")
end

function Director:showPlaceScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showPlaceScene")
end

function Director:showStackBottomScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showStackBottomScene")
end

function Director:showStackTopScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showStackTopScene")
end

function Director:showDeckScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showDeckScene")
end

function Director:showDrawScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "showDrawScene")
end

function Director:showOpponentScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "showOpponentScene")
end

function Director:showTurnOverScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "showTurnOverScene")
end

function Director:showGameOverScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "showGameOverScene")
end

function Director:beforeUpdateScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "beforeUpdateScene")

	if self.scene ~= SCENE_DRAW and self.deck:totalCardsToDealCount() > 0 then
        self:setScene(SCENE_DRAW)
	elseif self.scene == SCENE_TURNOVER and self.deck:totalCardsToDealCount() <= 0 then
		self:setScene(SCENE_COMBINED)

		if self.deck:canDeal(self.player) then
			self.deck:deal(self.player)
		end

		if self.deck:canDeal(self.opponent) then
			self.deck:deal(self.opponent)
		end
    end
end

function Director:afterUpdateScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "afterUpdateScene")
end

function Director:updateCombinedScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateCombinedScene")

	if released(INPUT_COMBINED_SHOW_HAND) then
		self:setScene(SCENE_HAND)
	elseif released(INPUT_COMBINED_SHOW_BOARD) then
		self:setScene(SCENE_BOARD)
	end

	if released(INPUT_COMBINED_SELECT_NEXT_CARD) or held(INPUT_COMBINED_SELECT_NEXT_CARD, INPUT_COMBINED_SELECT_NEXT_CARD_HELD_DELAY) then
        self.player:selectNextCard()
    elseif released(INPUT_COMBINED_SELECT_PREVIOUS_CARD) or held(INPUT_COMBINED_SELECT_PREVIOUS_CARD, INPUT_COMBINED_SELECT_PREVIOUS_CARD_HELD_DELAY) then
        self.player:selectPreviousCard()
    elseif released(INPUT_COMBINED_PLAY_CARD) and self.player:canPlaceSelectedCard() then
        self:setScene(SCENE_PLACE)
    end
end

function Director:updateHandScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateHandScene")

	if released(INPUT_HAND_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	elseif released(INPUT_HAND_CANCEL_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	end

	if released(INPUT_HAND_SELECT_NEXT_CARD) or held(INPUT_HAND_SELECT_NEXT_CARD, INPUT_HAND_SELECT_NEXT_CARD_HELD_DELAY) then
        self.player:selectNextCard()
    elseif released(INPUT_HAND_SELECT_PREVIOUS_CARD) or held(INPUT_HAND_SELECT_PREVIOUS_CARD, INPUT_HAND_SELECT_PREVIOUS_CARD_HELD_DELAY) then
        self.player:selectPreviousCard()
    elseif released(INPUT_HAND_PLAY_CARD) and self.player:canPlaceSelectedCard() then
        self:setScene(SCENE_PLACE)
    end
end

function Director:updateBoardScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateBoardScene")

	if released(INPUT_BOARD_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	elseif released(INPUT_BOARD_SHOW_STACK_BOTTOM) then
		self:setScene(SCENE_STACK_BOTTOM)
	elseif released(INPUT_BOARD_SHOW_DECK) then
		self:setScene(SCENE_DECK)
	elseif released(INPUT_BOARD_CANCEL_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	end
end

function Director:updatePlaceScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updatePlaceScene")

	if released(INPUT_PLACE_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	elseif released(INPUT_PLACE_SHOW_PREVIOUS) then
		self:showPreviousScene()
	end

	if released(INPUT_PLACE_SELECT_NEXT_COLUMN) or held(INPUT_PLACE_SELECT_NEXT_COLUMN, INPUT_PLACE_SELECT_NEXT_COLUMN_HELD_DELAY) then
        self.board:selectNextColumn()
    elseif released(INPUT_PLACE_SELECT_PREVIOUS_COLUMN) or held(INPUT_PLACE_SELECT_PREVIOUS_COLUMN, INPUT_PLACE_SELECT_PREVIOUS_COLUMN_HELD_DELAY) then
        self.board:selectPreviousColumn()
    end

	if released(INPUT_PLACE_PLAY) then

		if self.player:canPlaySelectedCard() then
			self.player:playSelectedCard()
			self:setScene(SCENE_COMBINED)
		end
    end
end

function Director:updateStackBottomScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateStackBottomScene")

	if released(INPUT_STACK_BOTTOM_SHOW_BOARD) then
		self:setScene(SCENE_BOARD)
	elseif released(INPUT_STACK_BOTTOM_SHOW_STACK_TOP) then
		self:setScene(SCENE_STACK_TOP)
	elseif  released(INPUT_STACK_BOTTOM_CANCEL_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	end

	if released(INPUT_STACK_BOTTOM_SELECT_NEXT_COLUMN) or held(INPUT_STACK_BOTTOM_SELECT_NEXT_COLUMN, INPUT_STACK_BOTTOM_SELECT_NEXT_COLUMN_HELD_DELAY) then
        self.board:selectNextColumn()
    elseif released(INPUT_STACK_BOTTOM_SELECT_PREVIOUS_COLUMN) or held(INPUT_STACK_BOTTOM_SELECT_PREVIOUS_COLUMN, INPUT_STACK_BOTTOM_SELECT_PREVIOUS_COLUMN_HELD_DELAY) then
        self.board:selectPreviousColumn()
    end
end

function Director:updateStackTopScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateStackTopScene")

	if released(INPUT_STACK_TOP_SHOW_STACK_BOTTOM) then
		self:setScene(SCENE_STACK_BOTTOM)
	elseif  released(INPUT_STACK_TOP_CANCEL_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	end

	if released(INPUT_STACK_TOP_SELECT_NEXT_COLUMN) or held(INPUT_STACK_TOP_SELECT_NEXT_COLUMN, INPUT_STACK_TOP_SELECT_NEXT_COLUMN_HELD_DELAY) then
        self.board:selectNextColumn()
    elseif released(INPUT_STACK_TOP_SELECT_PREVIOUS_COLUMN) or held(INPUT_STACK_TOP_SELECT_PREVIOUS_COLUMN, INPUT_STACK_TOP_SELECT_PREVIOUS_COLUMN_HELD_DELAY) then
        self.board:selectPreviousColumn()
    end
end

function Director:updateDeckScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateDeckScene")

	if released(INPUT_DECK_SHOW_BOARD) then
		self:setScene(SCENE_BOARD)
	elseif released(INPUT_DECK_CANCEL_SHOW_COMBINED) then
		self:setScene(SCENE_COMBINED)
	end
end

function Director:updateDrawScene()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateDrawScene")

	if self.scene == SCENE_DRAW and self.deck.isDealing == false then
		self:showPreviousScene()
	end
end

function Director:updateOpponentScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateOpponentScene")
end

function Director:updateTurnOverScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateTurnOverScene")
end

function Director:updateGameOverScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "updateGameOverScene")
end

function Director:addTrigger(trigger)
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "addTrigger")

	local index = #self.triggers + 1

	if trigger == nil then
		throw("You cannot provide a nil trigger.")
	end

	self.triggers[index] = trigger
end

function Director:addSceneTrigger(trigger)
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "addSceneTrigger")

	local index = #self.sceneTriggers + 1

	if trigger == nil then
		throw("You cannot provide a nil trigger.")
	end

	self.sceneTriggers[index] = trigger
end

function Director:addEvent(event)
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "addTrigger")

	local index = #self.events + 1

	if event == nil then
		throw("You cannot provide a nil event.")
	end

	self.events[index] = event
end

function Director:addSceneEvent(event)
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "addSceneTrigger")

	local index = #self.sceneEvents + 1

	if event == nil then
		throw("You cannot provide a nil event.")
	end

	self.sceneEvents[index] = event
end

function Director:setScene(scene)
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "setScene")

	if self.scene ~= scene then
		local directorShowSceneFunction = self.showSceneTable[scene]

		--clear the scene triggers by disabling any current ones
		for _, trigger in pairs(self.sceneTriggers) do
			trigger:disable()
		end

		for _, event in pairs(self.sceneEvents) do
			event:disable()
		end

		self.sceneTriggers = {}
		self.sceneEvents = {}
		self.previousScene = self.scene
		self.scene = scene

		for _, actor in pairs(self.actors) do
			self:setActorScene(actor, scene)
		end

		self:beforeShowScene()
		directorShowSceneFunction(self)
		self:afterShowScene()
	end
end

function Director:setActorScene(actor, scene)
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "setActorScene")

	local actorShowSceneFunction = actor.showSceneTable[scene]

	actor.isRefreshScene = false
	actor:beforeShowScene()
	actorShowSceneFunction(actor)
	actor:afterShowScene()
end

function Director:showPreviousScene()
	LogTrace(self.className, CLASS_DIRECTOR_NAME, "showPreviousScene")

	if self.previousScene ~= nil then
		self:setScene(self.previousScene)
	end
end

function Director:update()
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "update")

	self:beforeUpdateScene()

	local scene = self.scene
	local directorUpdateSceneFunction = self.updateSceneTable[scene]

    for _, actor in pairs(self.actors) do
		local actorUpdateSceneFunction = actor.updateSceneTable[scene]

		if actor.isRefreshScene == true then
			self:setActorScene(actor, self.scene)
		end

		actor:beforeUpdateScene()
		actorUpdateSceneFunction(actor)
		actor:afterUpdateScene()
    end

	directorUpdateSceneFunction(self)

	if #self.sceneTriggers > 0 then
		local sceneTriggersToRemoveIndices = {}

		for index, sceneTrigger in pairs(self.sceneTriggers) do

			sceneTrigger:update()

			if sceneTrigger.isComplete then
				local removeIndex = #sceneTriggersToRemoveIndices + 1

				sceneTriggersToRemoveIndices[removeIndex] = index
			end
		end

		if #sceneTriggersToRemoveIndices > 0 then

			--when a trigger is completed we remove it from the director
			for _, scenetriggerIndex in pairs(sceneTriggersToRemoveIndices) do
				table.remove(self.sceneTriggers, scenetriggerIndex)
			end
		end
	end

	if #self.triggers > 0 then
		local triggersToRemoveIndices = {}

		for index, trigger in pairs(self.triggers) do
			trigger:update()

			if trigger.isComplete then
				local removeIndex = #triggersToRemoveIndices + 1

				triggersToRemoveIndices[removeIndex] = index
			end
		end

		if #triggersToRemoveIndices > 0 then

			--when a trigger is completed we remove it from the director
			for _, triggerIndex in pairs(triggersToRemoveIndices) do
				table.remove(self.triggers, triggerIndex)
			end
		end
	end

	for _, event in pairs(self.sceneEvents) do
		event:update()
	end

	for _, event in pairs(self.events) do
		event:update()
	end

	self:afterUpdateScene()
end

function Director:foreachActor(func)
    LogTrace(self.className, CLASS_DIRECTOR_NAME, "foreachActor")

    for index, actor in pairs(self.actors) do
        func(actor, index)
    end
end