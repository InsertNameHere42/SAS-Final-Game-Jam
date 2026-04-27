class_name EnemyManager extends Node

@export var encounter: CombatEncounter
@export var maxEnemies: int = 5
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
		if not is_instance_valid(enemy):
			continue
		enemy.status_effect_component.tickAllStart()
		if not is_instance_valid(enemy): #just incase enemy dies from a turn start DOT
			continue
		enemy.takeTurn(_get_targets(enemy))
		if is_instance_valid(enemy):
			enemy.chooseAction()
			enemy.status_effect_component.tickAllEnd()
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

func spawnEnemies(scenes: Array[PackedScene]) -> void:
	for scene in scenes:
		var enemy: Enemy = scene.instantiate() as Enemy
		add_child(enemy)
		enemy.damageNumberManager = encounter.damageNumberManager

func cleanup() -> void:
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.queue_free()
	enemies.clear()
	
	
func startCombat() -> void:
	for enemy in enemies:
		if enemy:
			enemy.startCombat()
