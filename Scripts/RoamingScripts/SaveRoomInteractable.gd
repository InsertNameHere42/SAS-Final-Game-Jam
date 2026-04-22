class_name SaveRoomInteractable extends Interactable

@export var stateMachine: StateMachine
@export var saveRoomScreen: SaveRoomScreen

func interact() -> void:
	stateMachine.openSaveRoom(saveRoomScreen)
