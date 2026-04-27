class_name UpgradeToggleScreen extends CanvasLayer

@export var encounter: CombatEncounter
@export var placeholderSize: Vector2 = Vector2(96, 96)

const cardScene := preload("res://Scenes/UI/upgrade_card.tscn")

@onready var energyLabel: RichTextLabel = $PanelContainer/PedalboardTexture/EnergyLabel
@onready var upgradeRow: HBoxContainer = $PanelContainer/MarginContainer/UpgradeRow
@onready var tooltipDesc: Label = $TooltipPanel/VBoxContainer/DescLabel
@onready var tooltipName: Label = $TooltipPanel/VBoxContainer/NameLabel
@onready var tooltipPanel: PanelContainer = $TooltipPanel

var cards: Array[UpgradeCard] = []
var currentIndex: int = 0

func open() -> void:
	currentIndex = 0
	_buildCards()
	_updateTooltip()
	show()

func _buildCards() -> void:
	for child in upgradeRow.get_children():
		child.queue_free()
	cards.clear()
	
	upgradeRow.add_theme_constant_override("separation", 16)
	updateEnergy()
	
	
	for upgrade in encounter.player.upgradeSlots:
		if upgrade:
			var card: UpgradeCard = cardScene.instantiate()
			card.toggledUpgrade.connect(_onToggled)
			card.custom_minimum_size = Vector2(64, 64)
			upgradeRow.add_child(card)
			card.setup(upgrade, encounter.player.getRemainingEnergy(), true)
			cards.append(card)
		else:
			var placeholder := Control.new()
			placeholder.custom_minimum_size = placeholderSize
			upgradeRow.add_child(placeholder)
		
func _rebuildCards() -> void:
	for i in cards.size():
		cards[i].setup(cards[i].upgrade, encounter.player.getRemainingEnergy(), true)
	updateEnergy()

func navigateLeft() -> void:
	currentIndex = (currentIndex - 1 + cards.size()) % cards.size()
	_updateTooltip()

func navigateRight() -> void:
	currentIndex = (currentIndex + 1) % cards.size()
	_updateTooltip()

func toggleCurrent() -> void:
	if cards.is_empty(): return
	encounter.player.toggleUpgrade(cards[currentIndex].upgrade)
	_rebuildCards()
	_updateTooltip()

func _updateTooltip() -> void:
	if cards.is_empty():
		tooltipPanel.hide()
		return
	var upgrade: Upgrade = cards[currentIndex].upgrade
	tooltipName.text = upgrade.upgradeName
	tooltipDesc.text = upgrade.description
	tooltipPanel.show()
	_highlightCurrent()
	_positionTooltip()

func _highlightCurrent() -> void:
	for i in cards.size():
		cards[i].modulate = Color.WHITE if i != currentIndex else Color.SKY_BLUE

func _onToggled(upgrade: Upgrade) -> void:
	encounter.player.toggleUpgrade(upgrade)
	_rebuildCards()
	_updateTooltip()
	updateEnergy()

func _positionTooltip() -> void:
	var card: UpgradeCard = cards[currentIndex]
	await get_tree().process_frame
	var cardPos := card.global_position
	var tooltipX := cardPos.x + (card.size.x / 2) - (tooltipPanel.size.x / 2)
	var tooltipY := cardPos.y + card.size.y + 8
	tooltipPanel.global_position = Vector2(tooltipX, tooltipY)
		
func updateEnergy() -> void:
	energyLabel.text = "[font size=32][shake][color=#FFFF00]energy: " + str(encounter.player.getRemainingEnergy()) + "/" + str(encounter.player.maxEnergy)
		
		
		
		
		
		
		
	
