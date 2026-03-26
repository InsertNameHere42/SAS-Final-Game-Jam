class_name Player extends Damagable

signal playerDied
@export var baseMaxEnergy: int = 3
@export var baseDamage: int = 5
@export var baseCritChance: float = 0.1
@export var baseCritDamageMultiplier: float = 1.5
@export var baseBlock: BlockEffect
var currentEnergy: int

@export var maxUpgradeSlots: int = 6
var upgradeSlots: Array[Upgrade] = []


func _process(_delta: float) -> void:
	pass
		

func _ready() -> void:
	super._ready()
	turnStart()


		
func die() -> void:
	emit_signal("playerDied")
	
#this will play an attack animation and calculate the damage done
func attack() -> AttackContext: 
	turnEnd()
	var context := AttackContext.new(baseDamage, baseCritChance, baseCritDamageMultiplier)
	play("Attack")
	for upgrade in upgradeSlots:
		if upgrade:
			upgrade.modifyAttack(context)
	return context

func defend() -> DefendContext:
	play("Block")
	turnEnd()
	var context := DefendContext.new(baseBlock)
	for upgrade in upgradeSlots:
		if upgrade:
			upgrade.modifyDefend(context)
	return context

func returnToIdle() -> void:
	play("Idle")
func turnStart() -> void:
	returnToIdle()
	currentEnergy = baseMaxEnergy
	statusEffectComponent.tickAllStart()

func turnEnd() -> void:
	statusEffectComponent.tickAllEnd()
