class_name DamageNumberManager extends Node

const damageNumber := preload("res://Scenes/damage_number.tscn")

func spawn(damage: int, type: String, worldPos: Vector3) -> void:
	var label: DamageNumber = damageNumber.instantiate()
	add_child(label)
	label.global_position = worldPos + Vector3(randf_range(-0.2, 0.2), 0.5, 0.0)
	label.setup(damage, type)
