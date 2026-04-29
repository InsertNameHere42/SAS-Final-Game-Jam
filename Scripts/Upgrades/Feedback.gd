class_name Feedback extends Upgrade

@export var healAmount: int = 3

func modifyAttack(_context: AttackContext) -> void:
	_context.amountHealed = healAmount
