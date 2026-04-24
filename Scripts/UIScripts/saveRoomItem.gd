class_name SaveRoomItem extends PanelContainer

enum DisplayMode {CARD, LIST}

var upgrade: Upgrade
const iconSize: int = 48

@onready var icon: TextureRect = $HBoxContainer/Icon
@onready var nameLabel: Label = $HBoxContainer/NameLabel

func setup(u: Upgrade, mode: DisplayMode) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.15, 0.15, 0.2, 1.0)  # adjust color to match your UI theme
	add_theme_stylebox_override("panel", style)
	upgrade = u
	icon.custom_minimum_size = Vector2(iconSize, iconSize)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.texture = u.offSprite
	nameLabel.text = u.upgradeName
	icon.visible = true
	
	if mode == DisplayMode.CARD:
		custom_minimum_size = Vector2(64, 64)
		nameLabel.visible = false
		icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	else:
		custom_minimum_size = Vector2(0, 48)
		nameLabel.visible = true

func refresh(is_equipped: bool, is_selected: bool) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.15, 0.15, 0.2, 1.0)
	style.border_width_left = 2
	style.border_width_right = 2
	style.border_width_top = 2
	style.border_width_bottom = 2
	style.border_color = Color.SKY_BLUE if is_selected else Color.TRANSPARENT
	add_theme_stylebox_override("panel", style)
	
	modulate = Color(1, 1, 1, 0.4) if (is_equipped and not is_selected) else Color.WHITE
