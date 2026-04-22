class_name SaveRoomState extends State

var currentSaveRoom: SaveRoomScreen

func openRoom(saveRoom: SaveRoomScreen) -> void:
	currentSaveRoom = saveRoom

func enter() -> void:
	if currentSaveRoom:
		currentSaveRoom.show()

func exit() -> void:
	print("Save Room Exited")
	if currentSaveRoom:
		currentSaveRoom.hide()
		currentSaveRoom = null

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("UI Cancel"):
		print("Save Room Attemp Exit")
		transitioned.emit(self, "roamingstate")

func physicsUpdate(_delta: float) -> void:
	pass


	
