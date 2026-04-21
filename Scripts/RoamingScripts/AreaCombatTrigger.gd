class_name AreaCombatTrigger extends CombatTrigger

@onready var area: Area3D = $Area3D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is PlayerRoaming:
		trigger()
