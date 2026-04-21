extends Node3D

@onready var playerRoaming: PlayerRoaming = $PlayerRoaming
@onready var stateMachine: StateMachine = $StateMachine
@onready var roamingCamera: Camera3D = $PlayerRoaming/Camera3D

func _ready() -> void:
	stateMachine.start()
