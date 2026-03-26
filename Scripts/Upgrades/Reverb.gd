class_name ReverbUpgrade extends Upgrade

@export var blockKept: float = 0.25

func modifyDefend(_context: DefendContext) -> void:
	_context.blockEffect.percentBlockKept += blockKept
