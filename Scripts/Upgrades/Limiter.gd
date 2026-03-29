class_name LimiterUpgrade extends Upgrade

@export var blockGainMult: float = 2.0

func modifyDefend(_context: DefendContext) -> void:
	_context.blockAmount = int(_context.blockAmount*blockGainMult)
