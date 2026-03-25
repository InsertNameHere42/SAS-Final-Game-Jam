class_name BasicStatusAction extends EnemyAction

@export var statusEffect: StatusEffect

func execute(enemy: Enemy, _targets: Array[Damagable]) -> void:
	enemy.get_node("StatusEffectComponent").applyEffect(statusEffect)
