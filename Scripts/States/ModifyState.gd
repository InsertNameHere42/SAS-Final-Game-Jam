class_name ModifyState extends State

func enter():
	encounter.upgradeToggleScreen.open()
	print(encounter.player.getRemainingEnergy())

func exit():
	encounter.upgradeToggleScreen.hide()

func update(_delta: float):
	if Input.is_action_just_pressed("UI Move Left"):
		encounter.upgradeToggleScreen.navigateLeft()
	if Input.is_action_just_pressed("UI Move Right"):
		encounter.upgradeToggleScreen.navigateRight()
	if Input.is_action_just_pressed("UI Accept"):
		encounter.upgradeToggleScreen.toggleCurrent()
	if Input.is_action_just_pressed("UI Cancel"):
		transitioned.emit(self, "playerturn")
		

func physicsUpdate(_delta: float) -> void:
	pass
	
