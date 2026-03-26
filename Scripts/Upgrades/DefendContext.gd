class_name DefendContext extends RefCounted

var blockEffect: BlockEffect
var statusEffectsToApplyPlayer: Array[StatusEffect] = []

func _init(block: BlockEffect) -> void:
	blockEffect = block
