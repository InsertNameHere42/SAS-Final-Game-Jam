class_name SaveRoomScreen extends Control

const CARDSCENE := preload("res://Scenes/UI/upgrade_card.tscn")

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
	currentMode = Mode.INVENTORY
	inventoryIndex = 0
	slotIndex = 0
	pendingUpgrade = null
	_buildSlots()
	_buildInventory()
	_updateSelection()
	show()
func closed() -> void:
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
			slotIndex = (slotIndex - 1 + maxSlots.size()) % maxSlots
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
			pendingUpgrrade = null
			currentMode = Mode.INVENTORY
			_updateSelectin()
		Mode.Inventory():
			close()
