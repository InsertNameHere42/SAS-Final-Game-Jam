class_name MusicShop extends StaticBody3D

@export var shopScreen: ShopScreen
@export var stateMachine: StateMachine

@onready var shopTrigger: Area3D = $ShopTrigger

func _ready() -> void:
	shopTrigger.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if body is PlayerRoaming:
		stateMachine.openShop(shopScreen)
