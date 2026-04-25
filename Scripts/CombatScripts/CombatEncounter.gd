class_name CombatEncounter extends Node3D

@onready var player: Player = $Player
@onready var enemyManager: EnemyManager = $EnemyManager
@onready var stateMachine: StateMachine = $StateMachine
@onready var upgradeToggleScreen: UpgradeToggleScreen = $UpgradeToggleScreen
@onready var combatCamera: CombatCamera = $CombatCamera
@onready var damageNumberManager: DamageNumberManager = $DamageNumberManager

@export var enemyStepX: float = 10.0
@export var enemyStepZ: float = 10.0
@export var environment: Node

var gameStateMachine: StateMachine

func _process(delta: float) -> void:
	combatCamera.update(delta)
	
func focusDefault() -> void:
	combatCamera.focusDefault()
func focusEnemy(enemy: Enemy) -> void:
	combatCamera.focusEnemy(enemy)
func focusPlayer() -> void:
	combatCamera.focusPlayer()
func playerAttacking() -> void:
	combatCamera.attacking()

func startCombat(gsm: StateMachine, enemyScenes: Array[PackedScene]) -> void:
	print("Combat Started")
	enemyManager.spawnEnemies(enemyScenes)
	_placeEnemies()
	gameStateMachine = gsm
	combatCamera.make_current()
	enemyManager.start()
	stateMachine.start()

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
	stateMachine.stopCombat()
	await ScreenFade.fadeOut()
	print("Combat Ended")
	print("Enemies Left: " + str(enemyManager.enemies))
	await get_tree().create_timer(1, true, false, true).timeout
	environment.roamingCamera.make_current()
	gameStateMachine.onChildTransition(gameStateMachine.currentState, "roamingstate")
	await ScreenFade.fadeIn()

func shakeCamera(strength: float = 0.15, duration: float = 0.05) -> void:
	combatCamera.shake(strength, duration)

func screenFreeze(duration: float = 0.05):
	ScreenFreeze.freeze(duration)
	

	
