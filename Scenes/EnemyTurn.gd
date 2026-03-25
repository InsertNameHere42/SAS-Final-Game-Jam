class_name EnemyTurn extends State

func enter():
	await encounter.enemyManager.enemiesTakeTurn()
	transitioned.emit(self, "playerturn")
func exit():
	pass
func update(_delta: float):
	pass
func physicsUpdate(_delta: float) -> void:
	pass
