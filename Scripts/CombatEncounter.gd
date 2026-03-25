class_name CombatEncounter extends Node3D

@onready var player: Player = $Player
@onready var enemyManager: EnemyManager = $EnemyManager
@onready var stateMachine: StateMachine = $StateMachine

func _ready() -> void:
	stateMachine.start()
	enemyManager.start()
	
