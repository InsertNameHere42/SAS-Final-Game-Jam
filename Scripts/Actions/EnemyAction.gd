@abstract
class_name EnemyAction extends Resource

@export var actionName: String = "empty"
@export var weight: int = 25
@export var animationName: String

@abstract
func execute(enemy: Enemy, targets: Array[Damagable]) -> void

func _init() -> void:
	resource_local_to_scene = true

	
