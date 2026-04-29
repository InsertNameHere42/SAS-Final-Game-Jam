class_name ChorusUpgrade extends Upgrade

@export var healAmount: float = 0.3

func modifyAttack(_context: AttackContext) -> void:
	_context.amountHealed = int(_context.finalDamage * healAmount)
