class_name AreaCombatTrigger extends CombatTrigger

@onready var area: Area3D = $Area3D
@export var sprites: Node3D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func reset() -> void:
	super.reset()
	if sprites:
		print("Sprites Shown")
		sprites.show()

func _on_body_entered(body: Node) -> void:
	if body is PlayerRoaming:
		if sprites:
			sprites.hide()
		trigger()
