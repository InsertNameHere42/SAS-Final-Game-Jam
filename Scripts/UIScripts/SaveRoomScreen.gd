class_name SaveRoomScreen extends Control

const ITEM_SCENE := preload("res://Scenes/UI/save_room_item.tscn")
const CARD_SCENE := preload("res://Scenes/UI/upgrade_card.tscn")

@export var environment: Node3D
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

var slotCards: Array[Control] = [] #SaveRoomItem or placeholder
var inventoryCards: Array[SaveRoomItem] = []

signal closed

func open() -> void:
	environment.resetCombat()
	PlayerData.restoreHp()
	print("Inventory: " + str(PlayerData.inventory))
	slotCards.resize(maxSlots)
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
	if inventoryCards.size() == 0:
		return
	match currentMode:
		Mode.INVENTORY:
			inventoryIndex = (inventoryIndex - 1 + inventoryCards.size()) % inventoryCards.size()
			_updateSelection()
		Mode.SLOT_SELECT:
			pass
			
func navigateDown() -> void:
	if inventoryCards.size() == 0:
		return
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
	slotsRow.add_theme_constant_override("separation", 16)
	for i in maxSlots:
		var equipped: Upgrade = PlayerData.equippedUpgrades[i] if i < PlayerData.equippedUpgrades.size() else null
		if equipped:
			var card := CARD_SCENE.instantiate() as UpgradeCard
			slotsRow.add_child(card)
			card.setup(equipped, 999, false) 
			slotCards.append(card)
		else:
			var placeholder := TextureRect.new()
			placeholder.texture = emptySlotTexture
			placeholder.custom_minimum_size = Vector2(90, 160)
			placeholder.size = Vector2(90, 160)
			placeholder.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			placeholder.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
			slotsRow.add_child(placeholder)
			slotCards.append(placeholder)
	
func _buildInventory() -> void:
	for child in inventoryList.get_children():
		child.queue_free()
	inventoryCards.clear()
	for upgrade in PlayerData.inventory:
		var item := ITEM_SCENE.instantiate() as SaveRoomItem
		inventoryList.add_child(item)
		item.setup(upgrade)
		inventoryCards.append(item)
	print("Inventory List " + str(inventoryList.get_children()))

func _updateSelection() -> void: #not sure if this allows empty slots to be replaced. Will have to see.
	
	for i in slotCards.size():
		var isSelected := currentMode == Mode.SLOT_SELECT and i == slotIndex
		if slotCards[i] is UpgradeCard:
			slotCards[i].modulate = Color.SKY_BLUE if isSelected else Color.WHITE
		else:
			slotCards[i].modulate = Color.SKY_BLUE if isSelected else Color.WHITE
	
	for i in inventoryCards.size():
		var equipped := PlayerData.isEquipped(inventoryCards[i].upgrade)
		var selected := currentMode == Mode.INVENTORY and i == inventoryIndex
		inventoryCards[i].refresh(equipped, selected)
	
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
	
	
	
	
