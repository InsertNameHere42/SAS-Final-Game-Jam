extends Node3D

@onready var playerRoaming: PlayerRoaming = $PlayerRoaming
@onready var stateMachine: StateMachine = $StateMachine

func _ready() -> void:
	stateMachine.start()
