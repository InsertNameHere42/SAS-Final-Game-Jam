class_name DistortionUpgrade extends Upgrade

@export var damageBoostPercent: float = 1.5

func modifyAttack(_context: AttackContext) -> void:
	_context.finalDamage = int(_context.finalDamage*damageBoostPercent)
