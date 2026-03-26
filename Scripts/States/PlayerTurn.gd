class_name PlayerTurn extends State

func enter():
	encounter.player.returnToIdle()
	encounter.enemyManager.resetEnemyAnimations()
func exit():
	pass
func update(_delta: float):
	if Input.is_action_just_pressed("Attack"):
		transitioned.emit(self, "enemyselect")
	if Input.is_action_just_pressed("Defend"):
		var context := encounter.player.defend()
		encounter.player.statusEffectComponent.applyEffect(context.blockEffect) #a bit wonky I know, but since block is the main part of defending. I'm keeping it as it's own variable
		for effect in context.statusEffectsToApplyPlayer:
			encounter.player.statusEffectComponent.applyEffects(effect)
		transitioned.emit(self, "enemyturn")
		
func physicsUpdate(_delta: float) -> void:
	pass
