class_name BlockEffect extends StatusEffect

@export var percentBlockKept: float = 0.0

func _init() -> void:
	effectName = "Block"
	maxStacks = -1

func onDamageTaken(_target, _damage: int) -> int:
	var blocked = min(stacks, _damage)
	stacks -= blocked
	return _damage-blocked

func onTurnStart(_target):
	stacks = int(stacks*percentBlockKept)
	
