extends CanvasLayer

@onready var overlay: ColorRect = $ColorRect

func fadeOut() -> void:
	var tween := create_tween()
	tween.tween_property(overlay, "modulate:a", 1.0, 0.4)
	await tween.finished

func fadeIn() -> void:
	var tween := create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 0.4)
	await tween.finished
