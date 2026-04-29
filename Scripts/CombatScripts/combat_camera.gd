class_name CombatCamera extends Camera3D

@export var encounter: CombatEncounter

@export var defaultPositon: Node3D
@export var defaultLookAt: Node3D
@export var playerTarget: Player
@export var moveSpeed: float = 5.0
@export var fovSpeed: float = 15.0

var _targetPosition: Vector3
var _targetLookAt: Vector3
var _targetFOV: float

var _shakeStrength: float = 0.0
var _shakeDuration: float = 0.0
@export var shakeDecay: float = 5.0

func _ready() -> void:
	_targetPosition = global_position
	_targetLookAt = global_position + Vector3.FORWARD
	_targetFOV = fov

func update(delta: float) -> void:
	global_position = global_position.lerp(_targetPosition, delta * moveSpeed)
	fov = lerpf(fov, _targetFOV, delta * fovSpeed)
	
	if _shakeDuration > 0.0:
		_shakeDuration -= delta
		var shakeAmount := Vector3(
			randf_range(-1, 1),
			randf_range(-1, 1),
			0.0
		) * _shakeStrength
		global_position += shakeAmount
		_shakeStrength = lerpf(_shakeStrength, 0.0, delta*shakeDecay)
		
	var lookAt := global_position.direction_to(_targetLookAt)
	if lookAt.length() > 0.01:
		look_at(_targetLookAt, Vector3.UP)

func focusDefault() -> void:
	_targetFOV = 90
	_targetPosition = defaultPositon.global_position
	_targetLookAt = defaultLookAt.global_position

func focusEnemy(enemy: Enemy) -> void:
	_targetFOV = 75
	var offset: Vector3 = encounter.global_transform.basis * Vector3(0.0, -0.5, 1.0)
	_targetPosition = enemy.global_position + Vector3.UP * 1.5 + offset
	_targetLookAt = enemy.global_position

func focusPlayer() -> void:
	_targetFOV = 65
	var offset: Vector3 = encounter.global_transform.basis * Vector3(2, 0.5, 1)
	var lookOffset := Vector3(5, 0, -1)
	_targetPosition = playerTarget.global_position + offset
	_targetLookAt = playerTarget.global_position + lookOffset

func attacking() -> void:
	_targetFOV = 40
	var offset: Vector3 = encounter.global_transform.basis * Vector3(-3, 0.5, 2) 
	var lookOffset: Vector3 = encounter.global_transform.basis * Vector3(5, 0, 1)
	_targetPosition = playerTarget.global_position + offset
	_targetLookAt = playerTarget.global_position + lookOffset

func shake(strength: float = 0.15, duration: float = 0.1) -> void:
	_shakeStrength = strength
	_shakeDuration = duration
