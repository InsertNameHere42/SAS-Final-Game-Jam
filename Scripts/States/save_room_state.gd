class_name SaveRoomState extends State

var currentSaveRoom: SaveRoomScreen

func openRoom(saveRoom: SaveRoomScreen) -> void:
	currentSaveRoom = saveRoom

func enter() -> void:
	if currentSaveRoom:
		currentSaveRoom.open()

func exit() -> void:
	if currentSaveRoom:
		currentSaveRoom.hide()
		currentSaveRoom = null

func update(_delta: float) -> void:
	if currentSaveRoom:
		if Input.is_action_just_pressed("UI Cancel") and currentSaveRoom.currentMode == currentSaveRoom.Mode.INVENTORY:
			print("Exit saveroom")
			transitioned.emit(self, "roamingstate")

func physicsUpdate(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if currentSaveRoom:
		if event.is_action_pressed("UI Move Up"):
			currentSaveRoom.navigateUp()
		if event.is_action_pressed("UI Move Down"):
			currentSaveRoom.navigateDown()
		if event.is_action_pressed("UI Move Left"):
			currentSaveRoom.navigateLeft()
		if event.is_action_pressed("UI Move Right"):
			currentSaveRoom.navigateRight()
		if event.is_action_pressed("UI Accept"):
			currentSaveRoom.confirm()
		if event.is_action_pressed("UI Cancel"):
			currentSaveRoom.cancel()

	
