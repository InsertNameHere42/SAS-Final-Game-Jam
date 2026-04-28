class_name RoamingCamera extends Camera3D

@export var player: PlayerRoaming
@export var followAxis: Vector3 = Vector3.RIGHT
@export var followSpeed: float = 5.0

var _targetPosition: Vector3
var _zoneStack: Array[CameraZone]
var followOffset: Vector3 = Vector3.ZERO
var lookOffset: Vector3 = Vector3.ZERO

func _ready() -> void:
	_targetPosition = global_position

func enterZone(zone: CameraZone) -> void:
	_zoneStack.push_back(zone)
	_applyZone(zone)

func exitZone(zone: CameraZone) -> void:
	_zoneStack.erase(zone)
	if _zoneStack.is_empty():
		return
	_applyZone(_zoneStack.back())

func update(delta: float) -> void:
	if not player:
		return
	_update_position(delta)
	var lookAtTarget := player.global_position + lookOffset
	if global_position.is_equal_approx(player.global_position):
		return
	look_at(lookAtTarget, Vector3.UP)

func _update_position(delta: float) -> void:
	var to_player := player.global_position - _targetPosition
	var offset := followAxis * followAxis.dot(to_player)
	_targetPosition += offset
	global_position = global_position.lerp(_targetPosition + followOffset, delta * followSpeed)

func _applyZone(zone: CameraZone) -> void:
	followAxis = zone.followAxis.normalized()
	var alongAxis := followAxis * followAxis.dot(global_position)
	var perpendicular := zone.global_position - followAxis * followAxis.dot(zone.global_position)
	followOffset = zone.followOffset
	lookOffset = zone.lookOffset
	_targetPosition = alongAxis + perpendicular

func getMovementAxes() -> Array[Vector3]:
	var toPlayer := player.global_position - (_targetPosition + followOffset)
	toPlayer.y = 0
	var forward := toPlayer.normalized()
	var right := forward.cross(Vector3.UP).normalized()
	return [right, forward]
