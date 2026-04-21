class_name CombatState extends State

var currentEncounter: CombatEncounter

func setEncounter(encounter: CombatEncounter) -> void:
	currentEncounter = encounter

func enter() -> void:
	if currentEncounter:
		environment.playerRoaming.hide()
		currentEncounter.show()

func exit() -> void:
	environment.playerRoaming.show()
	currentEncounter.hide()
	currentEncounter.enemyManager.cleanup()
	currentEncounter = null

func update(_delta: float) -> void:
	pass

func physicsUpdate(_delta: float) -> void:
	pass
