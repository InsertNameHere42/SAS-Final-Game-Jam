class_name PlayerRoaming extends CharacterBody3D

@onready var playerSprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var interactArea: Area3D = $InteractArea

@export var interactOffset: float = 1.0
@export var moveSpeed: float = 5.0

var lastDirection: Vector2 = Vector2.RIGHT

func handleMovement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("RoamDown", "RoamUp", "RoamLeft", "RoamRight")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * moveSpeed
		velocity.z = direction.z * moveSpeed
		lastDirection = input_dir
		_updateInteractArea(direction)
		playRunAnimation(input_dir)
	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)
		velocity.z = move_toward(velocity.z, 0, moveSpeed)
		playIdleAnimation(lastDirection)

	move_and_slide()
	
func _updateInteractArea(direction: Vector3) -> void:
	interactArea.position = direction * interactOffset

func tryInteract() -> void:
	for body in interactArea.get_overlapping_areas():
		if body is Interactable:
			body.interact()
			return

func playRunAnimation(input_dir: Vector2) -> void:
	if abs(input_dir.x) >= abs(input_dir.y):
		if input_dir.x > 0:
			playerSprite.play("RunUp")
		else:
			playerSprite.play("RunDown")
	else:
		if input_dir.y < 0:
			playerSprite.play("RunLeft")
		else:
			playerSprite.play("RunRight")

func playIdleAnimation(lastDir: Vector2) -> void:
	if abs(lastDir.x) >= abs(lastDir.y):
		if lastDir.x > 0:
			playerSprite.play("IdleUp")
		else:
			playerSprite.play("IdleDown")
	else:
		if lastDir.y < 0:
			playerSprite.play("IdleLeft")
		else:
			playerSprite.play("IdleRight")
