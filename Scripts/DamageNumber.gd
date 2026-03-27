class_name DamageNumber extends Label3D

@export var floatDistance: float = 0.3
@export var duration: float = 0.3

func setup(damage: int, type: String) -> void:
	text = str(damage)
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	no_depth_test = true
	font_size = 64
	
	match type:
		"crit": modulate = Color.YELLOW
		"normal": modulate = Color.WHITE
		"negcrit": modulate = Color.DIM_GRAY
	
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y", position.y + floatDistance, duration)
	tween.tween_property(self, "modulate:a", 0.0, duration).set_delay(duration * 0.3)
	tween.chain().tween_callback(queue_free)
