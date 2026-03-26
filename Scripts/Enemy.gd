class_name Enemy extends Damagable

@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent
@export var possibleActions: Array[EnemyAction]
var nextAction: EnemyAction

func chooseAction() -> void:
	nextAction = _weighted_random(possibleActions)
func takeTurn(targets: Array[Damagable]) -> void:
	if nextAction:
		nextAction.execute(self, targets)

func die():
	queue_free()

func _weighted_random(actions: Array[EnemyAction]) -> EnemyAction:
	var total_weight := 0
	for action in actions:
		total_weight += action.weight

	var roll := randi() % total_weight
	var cumulative := 0
	for action in actions:
		cumulative += action.weight
		if roll < cumulative:
			return action

	return actions.back()
