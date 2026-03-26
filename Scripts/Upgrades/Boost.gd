class_name BoostUpgrade extends Upgrade

@export var damageBoostAmount: int = 2

func modifyAttack(_context: AttackContext) -> void:
	_context.finalDamage+=damageBoostAmount
