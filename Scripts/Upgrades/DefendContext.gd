class_name DefendContext extends RefCounted

var blockEffect: BlockEffect
var blockAmount: int
var statusEffectsToApplyPlayer: Array[StatusEffect] = []

func _init(amount: int, block: BlockEffect) -> void:
	blockEffect = block.duplicate()
	blockEffect.stacks = 0
	blockAmount = amount
	
func applyBlock() -> void:
	blockEffect.stacks = blockAmount
