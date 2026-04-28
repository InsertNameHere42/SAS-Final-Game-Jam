class_name BlockEffect extends StatusEffect

@export var percentBlockKept: float = 0.0
@export var percentDamageTaken: float = 1.0
@export var flatDamageDecrease: int = 0


func _init() -> void:
	texture = load("res://Assets/UI/blockeffect (3).png")
	effectName = "Block"
	maxStacks = -1

func onDamageTaken(_target, _damage: int) -> int:
	_damage = int(_damage*percentDamageTaken)
	_damage -= flatDamageDecrease
	var blocked = min(stacks, _damage)
	stacks -= blocked
	return _damage-blocked

func onTurnStart(_target):
	stacks = int(stacks*percentBlockKept)
	
