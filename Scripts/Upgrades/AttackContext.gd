class_name AttackContext extends RefCounted

var finalDamage: int
var critChance: float
var critDamageMultiplier: float
var hitCount: int = 1
var effectsToApplyEnemy: Array[StatusEffect] = []
var effectsToApplyPlayer: Array[StatusEffect] = []

func _init(damage: int, inpCritChance: float, inpCritDamage: float) -> void:
	finalDamage = damage
	critChance = inpCritChance
	critDamageMultiplier = inpCritDamage

func calculateDamage() -> int:
	var damage: int = finalDamage
	var rng = RandomNumberGenerator.new()
	if critChance >= 0:
		if critChance >= rng.randf_range(0.0, 1.0):
			damage = int(damage*critDamageMultiplier)
			print("Crit!")
	else: #negative critical strikes
		critChance*=-1
		if critChance >= rng.randf_range(0.0, 1.0):
			damage = int(damage*(1.0/critDamageMultiplier))
			print("Negative Crit!")
	return damage
