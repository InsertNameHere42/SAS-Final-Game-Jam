class_name LimiterUpgrade extends Upgrade

@export var blockGainMult: float = 2.0

func modifyDefend(_context: DefendContext) -> void:
	_context.blockEffect.stacks = int(_context.blockEffect.stacks*blockGainMult)
