class_name StatusAndAttackAction extends EnemyAction

@export var statusEffect: StatusEffect
@export var atkDmg: int = 5

func execute(enemy: Enemy, targets: Array[Damagable]) -> void:
	if targets.is_empty(): return
	var target = targets[0]
	enemy.play(animationName)
	enemy.get_node("StatusEffectComponent").applyEffect(statusEffect)
	if target.has_method("takeDamage"):
		target.takeDamage(atkDmg)
	
