class_name RoamingState extends State

func enter():
	environment.music.play()
	print("Roaming State Entered")

func exit():
	pass

func update(_delta: float):
	if Input.is_action_just_pressed("UI Accept"):
		environment.playerRoaming.tryInteract()
	
func physicsUpdate(_delta: float) -> void:
	environment.playerRoaming.handleMovement(_delta)
	environment.roamingCamera.update(_delta)
