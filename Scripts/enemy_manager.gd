class_name EnemyManager extends Node

@export var encounter: CombatEncounter
@export var maxEnemies: int = 3
@export var turnDelay: float = 0.5
var enemies: Array[Enemy] = []

func start() -> void:
	for child in get_children():
		if child is Enemy:
			if enemies.size()<maxEnemies:
				child.chooseAction()
				child.tree_exiting.connect(func(): enemies.erase(child))
				enemies.append(child)
			else:
				child.queue_free() #if there's too many enemies, just remove them

func enemiesTakeTurn() -> void:
	for enemy in enemies.duplicate():
		enemy.takeTurn(_get_targets(enemy))
		enemy.chooseAction()
		await get_tree().create_timer(turnDelay).timeout

func _get_targets(enemy: Enemy) -> Array[Damagable]:
	var targets: Array[Damagable] = [encounter.player]
	for e in enemies:
		if e != enemy:
			targets.append(e)
	return targets

func resetEnemyAnimations() -> void:
	for enemy in enemies:
		enemy.play("Idle")
