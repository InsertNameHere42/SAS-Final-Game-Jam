class_name ChorusUpgrade extends Upgrade

@export var healAmount: float = 0.3

func modifyAttack(_context: AttackContext) -> void:
	var result := _context.calculateDamage()
	_context.amountHealed = int(result.damage * healAmount)
