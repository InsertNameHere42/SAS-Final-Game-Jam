class_name ShopItem extends PanelContainer

var upgrade: Upgrade
@export var iconSize: int = 48

@onready var icon: TextureRect = $HBoxContainer/Icon
@onready var nameLabel: Label = $HBoxContainer/NameLabel
@onready var costLabel: Label = $HBoxContainer/CostLabel

func setup(u: Upgrade) -> void:
	upgrade = u
	icon.texture = u.offSprite
	icon.custom_minimum_size = Vector2(iconSize, iconSize)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	nameLabel.text = u.upgradeName
	costLabel.text = str(u.cost)
	_refresh()
	
func _refresh() -> void:
	modulate.a = 0.4 if PlayerData.ownsUpgrade(upgrade) else 1.0

func setSelected(selected: bool) -> void:
	var style := StyleBoxFlat.new()
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.border_color = Color("#7F77DD") if selected else Color.TRANSPARENT
	add_theme_stylebox_override("panel", style)
