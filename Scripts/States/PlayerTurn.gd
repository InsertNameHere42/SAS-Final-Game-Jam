class_name PlayerTurn extends State

func enter():
	if environment.enemyManager.enemies.is_empty():
		environment.endCombat(true)
	environment.focusDefault()
	environment.player.returnToIdle()
	environment.enemyManager.resetEnemyAnimations()
func exit():
	pass
func update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		transitioned.emit(self, "enemyselect")
	if Input.is_action_just_pressed("Defend"):
		var context: DefendContext = environment.player.defend()
		context.applyBlock()
		environment.player.statusEffectComponent.applyEffect(context.blockEffect) #a bit wonky I know, but since block is the main part of defending. I'm keeping it as it's own variable
		for effect in context.statusEffectsToApplyPlayer:
			environment.player.statusEffectComponent.applyEffects(effect)
		transitioned.emit(self, "enemyturn")
	if Input.is_action_just_pressed("Modify"):
		transitioned.emit(self, "modifystate")
		
func physicsUpdate(_delta: float) -> void:
	pass
