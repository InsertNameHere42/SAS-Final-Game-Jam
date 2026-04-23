class_name SaveRoomScreen extends Control

const CARD_SCENE := preload("res://Scenes/UI/upgrade_card.tscn")

@export var emptySlotTexture: Texture2D
@export var maxSlots: int = 6

@onready var slotsRow: HBoxContainer = $HBoxContainer/EquippedPanel/MarginContainer/VBoxContainer/SlotsRow
@onready var inventoryList: VBoxContainer = $HBoxContainer/InventoryPanel/MarginContainer/VBoxContainer/ScrollContainer/InventoryList
@onready var tooltipPanel: PanelContainer = $TooltipPanel
@onready var tooltipName: Label = $TooltipPanel/VBoxContainer/NameLabel
@onready var tooltipDesc: Label = $TooltipPanel/VBoxContainer/DescLabel
@onready var exitButton: Button = $ExitButton

enum Mode {INVENTORY, SLOT_SELECT}
var currentMode: Mode = Mode.INVENTORY
var inventoryIndex: int = 0
var slotIndex: int = 0
var pendingUpgrade: Upgrade = null

var slotCards: Array[UpgradeCard] = []
var inventoryCards: Array[UpgradeCard] = []

signal closed

func open() -> void:
	PlayerData.restoreHp()
	print("Inventory: " + str(PlayerData.inventory))
	currentMode = Mode.INVENTORY
	inventoryIndex = 0
	slotIndex = 0
	pendingUpgrade = null
	_buildSlots()
	_buildInventory()
	_updateSelection()
	show()
	
func close() -> void:
	closed.emit()
	hide()
	
func navigateUp() -> void:
	match currentMode:
		Mode.INVENTORY:
			inventoryIndex = (inventoryIndex - 1 + inventoryCards.size()) % inventoryCards.size()
			_updateSelection()
		Mode.SLOT_SELECT:
			pass
			
func navigateDown() -> void:
	match currentMode:
		Mode.INVENTORY:
			inventoryIndex = ((inventoryIndex + 1) % inventoryCards.size())
			_updateSelection()
		Mode.SLOT_SELECT:
			pass
			
func navigateLeft() -> void:
	match currentMode:
		Mode.SLOT_SELECT:
			slotIndex = ((slotIndex - 1 + maxSlots) % maxSlots)
			_updateSelection()
		Mode.INVENTORY:
			pass

func navigateRight() -> void:
	match currentMode:
		Mode.SLOT_SELECT:
			slotIndex = ((slotIndex + 1) % maxSlots)
			_updateSelection()
		Mode.INVENTORY:
			pass

func confirm() -> void:
	match currentMode:
		Mode.INVENTORY:
			_handleInventoryConfirm()
		Mode.SLOT_SELECT:
			_handleSlotConfirm()

func cancel() -> void:
	match currentMode:
		Mode.SLOT_SELECT:
			pendingUpgrade = null
			currentMode = Mode.INVENTORY
			_updateSelection()
		Mode.INVENTORY:
			close()

func _handleInventoryConfirm() -> void:
	if inventoryCards.is_empty(): return
	var upgrade: Upgrade = inventoryCards[inventoryIndex].upgrade
	if PlayerData.isEquipped(upgrade):
		PlayerData.unequipUpgrade(upgrade)
		_buildSlots()
		_buildInventory()
		_updateSelection()
	else:
		pendingUpgrade = upgrade
		currentMode = Mode.SLOT_SELECT
		slotIndex = 0
		_updateSelection()

func _handleSlotConfirm() -> void:
	if pendingUpgrade == null: return
	PlayerData.equipUpgrade(pendingUpgrade, slotIndex)
	pendingUpgrade = null
	currentMode = Mode.INVENTORY
	_buildSlots()
	_buildInventory()
	_updateSelection()
	
func _buildSlots() -> void:
	for child in slotsRow.get_children():
		child.queue_free()
	slotCards.clear()
	slotsRow.add_theme_constant_override("seperation", 16)
	for i in maxSlots:
		var equipped: Upgrade = PlayerData.equippedUpgrades[i] if i < PlayerData.equippedUpgrades.size() else null
		if equipped:
			var card := CARD_SCENE.instantiate() as UpgradeCard
			slotsRow.add_child(card)
			card.setup(equipped, 999, false) #the 999 is kinda a band-aid fix because that's the remaining energy field which doesn't really apply here
			card.modulate.a = 1.0
			slotCards.append(card)
		else:
			var placeholder := TextureRect.new()
			placeholder.texture = emptySlotTexture
			placeholder.custom_minimum_size = Vector2(64, 64)
			placeholder.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			placeholder.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slotsRow.add_child(placeholder)
			slotCards.append(null)
	
func _buildInventory() -> void:
	for child in inventoryList.get_children():
		child.queue_free()
	inventoryCards.clear()
	for upgrade in PlayerData.inventory:
		var card := CARD_SCENE.instantiate() as UpgradeCard
		inventoryList.add_child(card)
		card.custom_minimum_size = Vector2(64, 64)
		card.setup(upgrade, 999, false)
		card.modulate.a = 0.4 if PlayerData.isEquipped(upgrade) else 1.0
		inventoryCards.append(card)

func _updateSelection() -> void: #not sure if this allows empty slots to be replaced. Will have to see.
	for i in slotCards.size():
		if slotCards[i] != null:
			slotCards[i].modulate = Color.SKY_BLUE if (currentMode == Mode.SLOT_SELECT and i == slotIndex) else Color.WHITE
	
	for i in inventoryCards.size():
		var isSelected := currentMode == Mode.INVENTORY and i == inventoryIndex
		inventoryCards[i].modulate.a = 0.4 if PlayerData.isEquipped(inventoryCards[i].upgrade) else 1.0
		if isSelected:
			inventoryCards[i].modulate = Color.SKY_BLUE
		
	_updateTooltip()

func _updateTooltip() -> void:
	var upgrade: Upgrade = null

	match currentMode:
		Mode.INVENTORY:
			if not inventoryCards.is_empty():
				upgrade = inventoryCards[inventoryIndex].upgrade
		Mode.SLOT_SELECT:
			if slotIndex < PlayerData.equippedUpgrades.size():
				upgrade = PlayerData.equippedUpgrades[slotIndex]

	if upgrade == null:
		tooltipPanel.hide()
		return
	
	tooltipName.text = upgrade.upgradeName
	tooltipDesc.text = upgrade.description
	tooltipPanel.show()
	await get_tree().process_frame
	_positionTooltip()

func _positionTooltip() -> void:
	match currentMode:
		Mode.INVENTORY:
			if inventoryCards.is_empty(): return
			var card := inventoryCards[inventoryIndex]
			tooltipPanel.global_position = Vector2(
				card.global_position.x - tooltipPanel.size.x - 8,
				card.global_position.y
			)
		Mode.SLOT_SELECT:
			if slotCards[slotIndex] == null: return
			var card := slotCards[slotIndex]
			tooltipPanel.global_position = Vector2(
				card.global_position.x + (card.size.x / 2) - (tooltipPanel.size.x / 2),
				card.global_position.y + card.size.y + 8
			)

func _ready() -> void:
	exitButton.pressed.connect(close)
	tooltipDesc.autowrap_mode = TextServer.AUTOWRAP_WORD
	tooltipPanel.custom_minimum_size.x = 150
	hide()
	
	
	
	
