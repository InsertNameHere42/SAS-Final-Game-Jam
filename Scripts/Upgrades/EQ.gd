class_name EQUpgrade extends Upgrade

@export var critChanceBoost: float = 0.2

func modifyAttack(_context: AttackContext) -> void:
	_context.critChance+=critChanceBoost
