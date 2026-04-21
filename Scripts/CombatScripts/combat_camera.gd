class_name CombatCamera extends Camera3D

@export var tweenSpeed: float = 0.3
@export var baseHeight: float = 5.0
@export var baseDistance: float = 12
@export var baseTiltDegrees: float = -25.0
@export var baseHorizontalOffset: float = 0.0 # side offset from center

var _baseLookTarget: Vector3
var _baseYaw: float
var _baseRotationDegrees: Vector2 = Vector2.ZERO
