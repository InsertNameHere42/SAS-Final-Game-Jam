class_name CombatTrigger extends Node3D

@export var encounter: CombatEncounter
@export var stateMachine: StateMachine #the main game state machine
@export var enemyScenes: Array[PackedScene] = []


var triggered: bool = false

func trigger() -> void:
	if triggered:
		return
	triggered = true
	encounter.startCombat(stateMachine, enemyScenes)
	stateMachine.startCombat(encounter)
	
func reset() -> void:
	triggered = false
