@abstract
class_name State extends Node

@export var encounter: CombatEncounter
signal transitioned

@abstract
func enter()
@abstract
func exit()
@abstract
func update(_delta: float)
@abstract
func physicsUpdate(_delta: float) -> void
