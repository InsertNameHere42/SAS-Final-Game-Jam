class_name ShopState extends State

var currentShop: ShopScreen

func setShop(shop: ShopScreen) -> void:
	currentShop = shop

func enter() -> void:
	if currentShop:
		currentShop.show()

func exit() -> void:
	print("Shop Exited")
	if currentShop:
		currentShop.hide()
		currentShop = null

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("UI Cancel"):
		print("Shop Attemp Exit")
		transitioned.emit(self, "roamingstate")

func physicsUpdate(_delta: float) -> void:
	pass


	
