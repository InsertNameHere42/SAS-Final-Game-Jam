class_name UpgradeCard extends TextureButton

signal toggledUpgrade(upgrade: Upgrade)
signal hovered(upgrade: Upgrade)
signal unhovered

var upgrade: Upgrade

@onready var costLabel: Label = $CostLabel

func setup(u: Upgrade, remainingEnergy: int, showCost: bool) -> void:
	upgrade = u
	texture_normal = u.offSprite
	texture_pressed = u.onSprite
	custom_minimum_size = Vector2(64, 64)
	button_pressed = u.isOn
	self_modulate.a = 1.0 if (u.isOn or remainingEnergy >= u.energyCost) else 0.4
	modulate.a = 1.0 if (u.isOn or remainingEnergy >= u.energyCost) else 0.4
	if(showCost):
		costLabel.text = str(u.energyCost)

func _on_pressed() -> void:
	toggledUpgrade.emit(upgrade)

func _on_mouse_entered() -> void:
	hovered.emit(upgrade)

func _on_mouse_exited() -> void:
	unhovered.emit()
