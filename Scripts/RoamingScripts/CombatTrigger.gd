class_name CombatTrigger extends Node3D

@export var encounter: CombatEncounter
@export var stateMachine: StateMachine #the main game state machine
@export var enemyScenes: Array[PackedScene] = []


var triggered: bool = false

func trigger() -> void:
	if triggered:
		return
	triggered = true
	await ScreenFade.fadeOut()
	await get_tree().create_timer(1, true, false, true).timeout
	encounter.startCombat(stateMachine, enemyScenes)
	stateMachine.startCombat(encounter)
	await ScreenFade.fadeIn()
	
func reset() -> void:
	triggered = false
