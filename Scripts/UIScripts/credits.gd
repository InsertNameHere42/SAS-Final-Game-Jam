extends CanvasLayer

func _ready() -> void:
	await ScreenFade.fadeIn()

func _on_back_button_pressed() -> void:
	await ScreenFade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
