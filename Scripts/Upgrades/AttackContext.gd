class_name AttackContext extends RefCounted

var finalDamage: int
var critChance: float
var critDamageMultiplier: float
var hitCount: int = 1
var effectsToApplyEnemy: Array[StatusEffect] = []
var effectsToApplyPlayer: Array[StatusEffect] = []
var amountHealed: int = 0

func _init(damage: int, inpCritChance: float, inpCritDamage: float) -> void:
	finalDamage = damage
	critChance = inpCritChance
	critDamageMultiplier = inpCritDamage

func calculateDamage() -> Dictionary:
	var damage: int = finalDamage
	var type := "normal"
	var roll := randf()
	if critChance >= 0:
		if critChance >= roll:
			damage = int(damage*critDamageMultiplier)
			type = "crit"
	else: #negative critical strikes
		critChance*=-1
		if critChance >= roll:
			damage = int(damage*(1.0/critDamageMultiplier))
			type = "negcrit"
	if damage == 0: damage = 1
	return {"damage": damage, "type": type}
