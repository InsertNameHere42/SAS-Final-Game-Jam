@abstract
class_name Upgrade extends Resource

@export var upgradeName: String = ""
@export var description: String = ""
@export var offSprite: Texture2D
@export var onSprite: Texture2D
@export var energyCost: int = 1
@export var cost: int = 5
var isOn: bool = false

func _init() -> void:
	resource_local_to_scene = true
	
func modifyAttack(_context: AttackContext) -> void:
	pass

func modifyDefend(_context: DefendContext) -> void:
	pass
