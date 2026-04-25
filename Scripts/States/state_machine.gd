class_name StateMachine extends Node

@export var initialState : State
var currentState: State
var states: Dictionary = {}

func start() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			if not child.transitioned.is_connected(onChildTransition):
				child.transitioned.connect(onChildTransition)
	if initialState:
		initialState.enter()
		currentState = initialState

func _process(delta):
	if currentState:
		currentState.update(delta)

func _physics_process(delta):
	if currentState:
		currentState.physicsUpdate(delta)

func onChildTransition(state: State, newStateName: String):
	if state != currentState:
		return
	var newState = states.get(newStateName.to_lower())
	if !newState:
		return
	currentState.exit()
	newState.enter()
	currentState = newState
		
func openShop(shop: ShopScreen) -> void:
	var shopState := states.get("shopstate") as ShopState
	if shopState:
		shopState.setShop(shop)
		onChildTransition(currentState, "shopstate")

func openSaveRoom(saveRoom: SaveRoomScreen) -> void:
	var saveRoomState := states.get("saveroomstate") as SaveRoomState
	if saveRoomState:
		saveRoomState.openRoom(saveRoom)
		onChildTransition(currentState, "saveroomstate")

func startCombat(encounter: CombatEncounter) -> void:
	print("State Machine combat start")
	var combatState := states.get("combatstate") as CombatState
	if combatState:
		combatState.setEncounter(encounter)
		onChildTransition(currentState, "combatstate")

func stopCombat() -> void:
	for child in get_children():
		if child is State:
			if child.transitioned.is_connected(onChildTransition):
				child.transitioned.disconnect(onChildTransition)
	currentState = null
	states.clear()
		
