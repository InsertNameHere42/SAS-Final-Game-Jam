extends Node3D

@onready var playerRoaming: PlayerRoaming = $PlayerRoaming
@onready var stateMachine: StateMachine = $StateMachine
@onready var roamingCamera: RoamingCamera = $RoamingCamera
@onready var enemyCombatTriggers: Node = $EnemyCombatTriggers
@onready var music: AudioStreamPlayer = $Music



func _ready() -> void:
	stateMachine.start()
	PlayerData.loaded.connect(_onSaveLoaded)
	_onSaveLoaded()
	await ScreenFade.fadeIn()


func resetCombat() -> void:
	for child in enemyCombatTriggers.get_children():
		if child is CombatTrigger:
			child.reset()
			
func _onSaveLoaded():
	resetCombat()
	if PlayerData.lastSpawnPosition != Vector3.ZERO:
		playerRoaming.global_position = PlayerData.lastSpawnPosition
		
