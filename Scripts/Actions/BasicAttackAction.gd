class_name BasicAttackAction extends EnemyAction

@export var atkDmg: int = 5

func execute(enemy: Enemy, targets: Array[Damagable]) -> void:
	if targets.is_empty(): return
	var target = targets[0]
	enemy.play(animationName)
	if target.has_method("takeDamage"):
		target.takeDamage(atkDmg)
	
