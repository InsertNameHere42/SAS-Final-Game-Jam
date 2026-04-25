class_name ModifyState extends State

func enter():
	environment.focusPlayer()
	environment.upgradeToggleScreen.open()
	print(environment.player.getRemainingEnergy())

func exit():
	environment.upgradeToggleScreen.hide()

func update(_delta: float):
	if Input.is_action_just_pressed("UI Move Left"):
		environment.upgradeToggleScreen.navigateLeft()
	if Input.is_action_just_pressed("UI Move Right"):
		environment.upgradeToggleScreen.navigateRight()
	if Input.is_action_just_pressed("UI Accept"):
		environment.upgradeToggleScreen.toggleCurrent()
	if Input.is_action_just_pressed("UI Cancel"):
		transitioned.emit(self, "playerturn")
		

func physicsUpdate(_delta: float) -> void:
	pass
	
