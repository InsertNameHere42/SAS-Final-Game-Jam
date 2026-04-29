class_name PlayerRoaming extends CharacterBody3D

@onready var playerSprite: AnimatedSprite3D = $AnimatedSprite3D
@onready var interactArea: Area3D = $InteractArea

@onready var footsteps: AudioStreamPlayer3D = $Footsteps
@export var interactOffset: float = 1.0
@export var moveSpeed: float = 5.0
@export var camera: RoamingCamera

var lastDirection: Vector2 = Vector2.RIGHT
var footstepFrames: Array[int] = [3, 9]

func handleMovement(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("RoamLeft", "RoamRight", "RoamUp", "RoamDown")
	
	var axes = camera.getMovementAxes()
	var camRight: Vector3 = axes[0]
	var camForward: Vector3 = axes[1]
	
	var direction := (camRight * input_dir.x + camForward * -input_dir.y).normalized()
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
			playerSprite.play("RunRight")
		else:
			playerSprite.play("RunLeft")
	else:
		if input_dir.y < 0:
			playerSprite.play("RunUp")
		else:
			playerSprite.play("RunDown")

func playIdleAnimation(lastDir: Vector2) -> void:
	if abs(lastDir.x) >= abs(lastDir.y):
		if lastDir.x > 0:
			playerSprite.play("IdleRight")
		else:
			playerSprite.play("IdleLeft")
	else:
		if lastDir.y < 0:
			playerSprite.play("IdleUp")
		else:
			playerSprite.play("IdleDown")



func _on_animated_sprite_3d_frame_changed() -> void:
	if not velocity==Vector3.ZERO:
		if footstepFrames.has(playerSprite.frame):
			footsteps.pitch_scale = randf_range(0.9, 1.1)
			footsteps.play()
