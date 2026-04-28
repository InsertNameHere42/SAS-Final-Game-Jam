extends CanvasLayer

@onready var cityAmbience: AudioStreamPlayer = $CityAmbience

func _ready() -> void:
	await ScreenFade.fadeIn()

func _on_start_button_pressed() -> void:
	await ScreenFade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/roaming.tscn")

func _on_credits_button_pressed() -> void:
	await ScreenFade.fadeOut()
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_city_ambience_finished() -> void: #no build in loop?
	cityAmbience.play()
