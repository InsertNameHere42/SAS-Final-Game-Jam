class_name NoiseGateUpgrade extends Upgrade #noise gate is used to "cut through unwanted noise" I'm interpreting it as cutting through blocks

@export var blockModifier: StatusEffect

func modifyAttack(_context: AttackContext) -> void:
	_context.effectsToApplyEnemy.append(blockModifier)
