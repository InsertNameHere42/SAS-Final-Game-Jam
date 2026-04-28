class_name SingleHitDmgBoost extends StatusEffect

var percentIncreasePerStack = 0.1

func _init() -> void:
	texture = load("res://Assets/Kenny Particle Pack/scorch_01.png")
	effectName = "Single Hit Damage Boost"
	maxStacks = -1

func onAttack(_target, attackContext: AttackContext): 
	stacks=0
	attackContext.finalDamage = int(attackContext.finalDamage*(1+percentIncreasePerStack*stacks))
	print(attackContext.finalDamage)
	return attackContext
	
