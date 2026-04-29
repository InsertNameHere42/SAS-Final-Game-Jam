class_name Enemy extends Damagable

@onready var nextActionTooltip: Label3D = $NextActionTooltip
@onready var hoverDetector: Area3D = $HoverDetector
@onready var status_effect_component: StatusEffectComponent = $StatusEffectComponent
@export var possibleActions: Array[EnemyAction]
@export var verticalOffset: float = 0
var nextAction: EnemyAction
var hovered: bool = false


func startCombat() -> void:
	super.startCombat()
	selected(false)
	hoverDetector.mouse_entered.connect(onMouseEntered)
	hoverDetector.mouse_exited.connect(onMouseExited)

func _ready() -> void:
	super._ready()
	

func chooseAction() -> void:
	nextAction = _weighted_random(possibleActions)
	nextActionTooltip.text = "This enemy intends to " + nextAction.actionName
	
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

func onMouseEntered():
	hovered = true
	selected(hovered)
	
func onMouseExited():
	hovered = false
	selected(hovered)

func selected(isSelected: bool):
	if isSelected:
		nextActionTooltip.show()
	else:
		nextActionTooltip.hide()
