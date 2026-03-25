class_name PlayerTurn extends State

func enter():
	encounter.player.returnToIdle()
	encounter.enemyManager.resetEnemyAnimations()
func exit():
	pass
func update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		encounter.enemyManager.enemies[0].takeDamage(encounter.player.attack())
		transitioned.emit(self, "enemyturn")
		
func physicsUpdate(_delta: float) -> void:
	pass
