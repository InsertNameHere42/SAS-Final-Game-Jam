class_name DelayUpgrade extends Upgrade

@export var damageBoostPercent: float = 0.75
@export var additionalHits: int = 1

func modifyAttack(_context: AttackContext) -> void:
	_context.finalDamage = int(_context.finalDamage*damageBoostPercent)
	_context.hitCount+=additionalHits
