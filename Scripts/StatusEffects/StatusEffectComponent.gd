class_name StatusEffectComponent extends Node

var activeEffects: Array[StatusEffect] = []

func applyEffect(newEffect: StatusEffect):
	var existing = _findEffect(newEffect.effectName)
	if existing:
		if existing.maxStacks == -1:
			existing.stacks+=newEffect.stacks
		else:
			existing.stacks = min(existing.stacks + newEffect.stacks, existing.maxStacks)
		existing.onApply(owner)
	else:
		var effect = newEffect.duplicate()
		activeEffects.append(effect)
		effect.onApply(owner)
	
func triggerDamageTaken(damage: int) -> int:
	for effect in activeEffects:
		damage = effect.onDamageTaken(owner, damage)
	return damage

func triggerAttack():
	for effect in activeEffects:
		effect.onAttack(owner)

func _findEffect(searchName: String) -> StatusEffect:
	for effect in activeEffects: if effect.effectName == searchName: return effect
	return null

func tickAllEnd():
	for effect in activeEffects:
		effect.onTurnEnd(owner)
	activeEffects = activeEffects.filter(func(e): return e.stacks > 0)

func tickAllStart():
	for effect in activeEffects:
		effect.onTurnStart(owner)
	activeEffects = activeEffects.filter(func(e): return e.stacks > 0)

func removeEffect(effect: StatusEffect):
	effect.onRemove(owner)
	activeEffects.erase(effect)

	
	
	
	
