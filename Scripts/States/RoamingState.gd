class_name RoamingState extends State

func enter():
	print("Roaming State Entered")

func exit():
	pass

func update(_delta: float):
	pass
	
func physicsUpdate(_delta: float) -> void:
	environment.playerRoaming.handleMovement(_delta)
