class_name OverdriveUpgrade extends Upgrade

@export var critDamageBoost: float = 0.75

func modifyAttack(_context: AttackContext) -> void:
	_context.critDamageMultiplier+=critDamageBoost
