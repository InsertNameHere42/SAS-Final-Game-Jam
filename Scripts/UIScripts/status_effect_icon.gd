class_name StatusEffectIcon extends HBoxContainer

@onready var icon: TextureRect = $TextureRect
@onready var label: Label = $Label

func setup(effect: StatusEffect, stacks: int) -> void:
	icon.texture = effect.texture
	icon.custom_minimum_size = Vector2(20, 20)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	label.text = "x%d" % stacks
