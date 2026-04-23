class_name SaveRoomInteractable extends Interactable

var stateMachine: StateMachine
var saveRoomScreen: SaveRoomScreen

func interact() -> void:
	print("Interacted")
	stateMachine.openSaveRoom(saveRoomScreen)
