extends StaticBody3D


@export var stateMachine: StateMachine
@export var saveRoomScreen: SaveRoomScreen

@onready var interactDetector: SaveRoomInteractable = $InteractDetector

func _ready() -> void:
	interactDetector.stateMachine = stateMachine
	interactDetector.saveRoomScreen = saveRoomScreen
