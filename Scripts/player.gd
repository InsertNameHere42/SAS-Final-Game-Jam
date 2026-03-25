class_name Player extends Damagable

signal playerDied
@export var baseDamage: int = 5
@export var baseBlock: int = 5


func _process(_delta: float) -> void:
	pass
		

func _ready() -> void:
	super._ready()
	print(maxHp)
	print(currentHp)


		
func die() -> void:
	emit_signal("playerDied")
	
#this will play an attack animation and calculate the damage done
func attack() -> int: 
	play("Attack")
	return baseDamage

func returnToIdle() -> void:
	play("Idle")
