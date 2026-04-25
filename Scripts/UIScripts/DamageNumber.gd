class_name DamageNumber extends Label3D

@export var floatDistance: float = 0.3
@export var duration: float = 0.3

var floatDirection: Vector3 = Vector3.UP

func setup(damage: int, type: String) -> void:
	text = str(damage)
	floatDirection = Vector3(randf_range(-1, 1), 1.0, randf_range(-1, 1)).normalized()
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	no_depth_test = true
	font_size = 16
	
	match type:
		"crit": modulate = Color.YELLOW
		"normal": modulate = Color.WHITE
		"negcrit": modulate = Color.DIM_GRAY
	
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", position + floatDirection * floatDistance, duration) 
	tween.tween_property(self, "modulate:a", 0.0, duration).set_delay(duration * 0.3)
	tween.chain().tween_callback(queue_free)
