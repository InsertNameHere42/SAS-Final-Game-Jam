class_name ShopScreen extends Control

const ITEM_SCENE := preload("res://Scenes/UI/shop_item.tscn")

@export var availableUpgrades: Array[Upgrade] = []
@onready var itemList: VBoxContainer = $HBoxContainer/ItemList
@onready var tooltipIcon: TextureRect = $HBoxContainer/RightPanel/TooltipPanel/MarginContainer/VBoxContainer/TooltipTexture
@onready var tooltipName: Label = $HBoxContainer/RightPanel/TooltipPanel/MarginContainer/VBoxContainer/TooltipName
@onready var tooltipDesc: Label = $HBoxContainer/RightPanel/TooltipPanel/MarginContainer/VBoxContainer/TooltipDesc
@onready var tooltipCost: Label = $HBoxContainer/RightPanel/TooltipPanel/MarginContainer/VBoxContainer/TooltipCost
@onready var buyButton: Button = $HBoxContainer/RightPanel/TooltipPanel/MarginContainer/VBoxContainer/BuyButton

var items: Array[ShopItem] = []
var currentIndex: int = 0

func _ready() -> void:
	buyButton.pressed.connect(_buySelected)
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
	for i in items.size():
		items[i].setSelected(i == currentIndex)
	var upgrade: Upgrade = items[currentIndex].upgrade
	tooltipIcon.texture = upgrade.offSprite
	tooltipName.text = upgrade.upgradeName
	tooltipDesc.text = upgrade.description
	tooltipCost.text = "%d gold" % upgrade.cost
	var owned := PlayerData.ownsUpgrade(upgrade)
	buyButton.disabled = owned or PlayerData.doubloons < upgrade.cost
	buyButton.text = "owned" if owned else "buy"

func _buySelected() -> void:
	var upgrade: Upgrade = items[currentIndex].upgrade
	if PlayerData.ownsUpgrade(upgrade) or PlayerData.doubloons < upgrade.cost:
		print("Invalid Purchase")
		return
	PlayerData.doubloons -= upgrade.cost
	PlayerData.inventory.append(upgrade)
	items[currentIndex]._refresh()
	_updateTooltip()
	
	
	
	
		
		
