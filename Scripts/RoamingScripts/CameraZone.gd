class_name CameraZone extends Area3D

@export var followAxis: Vector3 = Vector3.RIGHT
@export var camera: RoamingCamera

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body is PlayerRoaming:
		camera.enterZone(self)

func _on_body_exited(body: Node3D) -> void:
	if body is PlayerRoaming:
		camera.exitZone(self)
