@abstract
class_name Damagable extends AnimatedSprite3D

@onready var healthBar: ProgressBar = $HealthViewPort/ProgressBar
@export var maxHp: int
var currentHp: int


func _ready() -> void:
	currentHp = maxHp
	healthBar.max_value = maxHp
	healthBar.value = currentHp

func takeDamage(damage: int) -> void:
	damage = $StatusEffectComponent.triggerDamageTaken(damage)
	currentHp-=damage
	healthBar.value = currentHp
	print(healthBar.value)
	print(healthBar.max_value)
	if currentHp<=0:
		die()

@abstract 
func die()
