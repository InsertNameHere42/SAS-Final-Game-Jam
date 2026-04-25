class_name EnemyTurn extends State

func enter():
	environment.focusDefault()
	if environment.enemyManager.enemies.is_empty():
		environment.endCombat()
	else:
		await environment.enemyManager.enemiesTakeTurn()
		environment.player.turnStart()
		transitioned.emit(self, "playerturn")
func exit():
	pass
func update(_delta: float):
	pass
func physicsUpdate(_delta: float) -> void:
	pass
