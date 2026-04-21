class_name CombatEncounter extends Node3D

@onready var player: Player = $Player
@onready var enemyManager: EnemyManager = $EnemyManager
@onready var stateMachine: StateMachine = $StateMachine
@onready var upgradeToggleScreen: UpgradeToggleScreen = $UpgradeToggleScreen
@onready var combatCamera: Camera3D = $CombatCamera
@onready var damageNumberManager: DamageNumberManager = $DamageNumberManager

@export var enemyStepX: float = 10.0
@export var enemyStepZ: float = 10.0
@export var defaultCameraPosition: Vector3 = Vector3(-2, 5, 7)
@export var defaultCameraTarget: Vector3 = Vector3(0, 0, 0)
@export var environment: Node

var gameStateMachine: StateMachine
	
func startCombat(gsm: StateMachine, enemyScenes: Array[PackedScene]) -> void:
	print("Combat Started")
	combatCamera.current = true
	gameStateMachine = gsm
	enemyManager.spawnEnemies(enemyScenes)
	_placeEnemies()
	combatCamera.make_current()
	stateMachine.start()
	enemyManager.start()

func _placeEnemies() -> void:
	var i: int = 0
	for child in enemyManager.get_children():
		if child is Enemy:
			var x := (i+1) * enemyStepX
			var z := enemyStepZ * (1 if i % 2 == 0 else -1)
			child.global_position = to_global(Vector3(x, 0, z))
			i += 1
	print("total enemies placed: ", i)

func endCombat() -> void:
	environment.roamingCamera.make_current()
	gameStateMachine.onChildTransition(gameStateMachine.currentState, "roamingstate")


	
