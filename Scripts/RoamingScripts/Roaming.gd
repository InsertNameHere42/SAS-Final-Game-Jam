extends Node3D

@onready var playerRoaming: PlayerRoaming = $PlayerRoaming
@onready var stateMachine: StateMachine = $StateMachine
@onready var roamingCamera: RoamingCamera = $RoamingCamera
@onready var enemyCombatTriggers: Node = $EnemyCombatTriggers

func _ready() -> void:
	await ScreenFade.fadeIn()
	stateMachine.start()

func resetCombat() -> void:
	for child in enemyCombatTriggers.get_children():
		if child is CombatTrigger:
			child.reset()
			
