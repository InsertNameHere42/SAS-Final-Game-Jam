class_name FuzzUpgrade extends Upgrade

@export var damageBoostPercent: float = 2.0
@export var critChanceDecrease: float = 0.1

func modifyAttack(_context: AttackContext) -> void:
	_context.finalDamage = int(_context.finalDamage*damageBoostPercent)
	_context.critChance -= critChanceDecrease
