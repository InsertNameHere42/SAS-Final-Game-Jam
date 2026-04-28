class_name LimiterUpgrade extends Upgrade

@export var blockDamageDecrease: int = 2

func modifyDefend(_context: DefendContext) -> void:
	_context.blockEffect.flatDamageDecrease = blockDamageDecrease
