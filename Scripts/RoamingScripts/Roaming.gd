extends Node3D

@onready var playerRoaming: PlayerRoaming = $PlayerRoaming
@onready var stateMachine: StateMachine = $StateMachine
@onready var roamingCamera: RoamingCamera = $RoamingCamera

func _ready() -> void:
	await ScreenFade.fadeIn()
	stateMachine.start()
