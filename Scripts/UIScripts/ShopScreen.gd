class_name ShopScreen extends Control

const ITEM_SCENE := preload("res://Scenes/UI/shop_item.tscn")

@export var availableUpgrades: Array[Upgrade] = []

@onready var itemList: VBoxContainer = $HBoxContainer/ItemList
@onready var tooltipIcon: TextureRect = $HBoxContainer/RightPanel/TooltipPanel/VBoxContainer/TooltipIcon
@onready var tooltipName: Label = $HBoxContainer/RightPanel/TooltipPanel/VBoxContainer/TooltipName
@onready var tooltipDesc: Label = $HBoxContainer/RightPanel/TooltipPanel/VBoxContainer/TooltipDesc
@onready var tooltipCost: Label = $HBoxContainer/RightPanel/TooltipPanel/VBoxContainer/TooltipCost
@onready var buyButton: Button = $HBoxContainer/RightPanel/TooltipPanel/VBoxContainer/BuyButton

var items: Array[ShopItem] = []
var currentIndex: int = 0

func _ready() -> void:
	_buildList()
	_updateTooltip()
	
func _buildList() -> void:
	for child in itemList.get_children():
		child.queue_free()
	items.clear()
	for upgrade in availableUpgrades:
		var item := ITEM_SCENE.instantiate()
		itemList.add_child(item)
		item.setup(upgrade)
		items.append(item)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("UI Move Up"):
		currentIndex = (currentIndex - 1 + items.size()) % items.size()
		_updateTooltip()
	if event.is_action_pressed("UI Move Down"):
		currentIndex = (currentIndex + 1) % items.size()
		_updateTooltip()
	if event.is_action_pressed("UI Accept"):
		_buySelected()
		
func _updateTooltip() -> void:
	pass

func _buySelected() -> void:
	pass
		
		
