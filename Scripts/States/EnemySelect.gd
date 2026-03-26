class_name EnemySelect extends State

@export var enemyHitTicks: float = 0.05
@export var playerToEnemyTurnDelay: float = 0.5
var currentIndex: int = 0

func enter() -> void:
	_highlightTarget()

func exit() -> void:
	_clearHighlight()

func update(_delta: float) -> void:
	var enemies := encounter.enemyManager.enemies
	
	if enemies.is_empty() or Input.is_action_just_pressed("UI Cancel"):
		transitioned.emit(self, "playerturn")
		return
	if Input.is_action_just_pressed("UI Move Right"):
		currentIndex = (currentIndex + 1) % enemies.size()
		_highlightTarget()
	if Input.is_action_just_pressed("UI Move Left"):
		currentIndex = (currentIndex - 1 + enemies.size()) % enemies.size()
		_highlightTarget()
	
	if Input.is_action_just_pressed("UI Accept"):
		var selectedTarget: Enemy = encounter.enemyManager.enemies[currentIndex]
		var attackContext := encounter.player.attack()
		for i in attackContext.hitCount:
			if selectedTarget and is_instance_valid(selectedTarget):
				selectedTarget.takeDamage(attackContext.calculateDamage())
				for effect in attackContext.effectsToApplyEnemy:
					selectedTarget.status_effect_component.applyEffect(effect)
				for effect in attackContext.effectsToApplyPlayer:
					encounter.player.statusEffectComponent.applyEffect(effect)
			await get_tree().create_timer(enemyHitTicks).timeout
		_clearHighlight()
		await get_tree().create_timer(playerToEnemyTurnDelay).timeout
		transitioned.emit(self, "enemyturn")

func physicsUpdate(_delta: float) -> void:
	pass

func _highlightTarget() -> void:
	var enemies: Array[Enemy] = encounter.enemyManager.enemies
	if enemies.is_empty(): return
	
	for enemy in enemies:
		enemy.modulate = Color.WHITE
	enemies[currentIndex].modulate = Color.RED

func _clearHighlight() -> void:
	for enemy in encounter.enemyManager.enemies:
		enemy.modulate = Color.WHITE
