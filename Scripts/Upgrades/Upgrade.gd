@abstract
class_name Upgrade extends Resource

@export var upgradeName: String = ""
@export var description: String = ""
@export var icon: Texture2D

func _init() -> void:
	resource_local_to_scene = true
	
func modifyAttack(_context: AttackContext) -> void:
	pass

func modifyDefend(_context: DefendContext) -> void:
	pass
