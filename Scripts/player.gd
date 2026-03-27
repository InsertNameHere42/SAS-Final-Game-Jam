class_name Player extends Damagable

signal playerDied
@export var baseMaxEnergy: int = 3
@export var baseDamage: int = 5
@export var baseCritChance: float = 0.1
@export var baseCritDamageMultiplier: float = 1.5
@export var baseBlock: BlockEffect
var maxEnergy: int = 1
var usedEnergy: int = 0

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
		if upgrade and upgrade.isOn:
			upgrade.modifyAttack(context)
	return context

func defend() -> DefendContext:
	play("Block")
	turnEnd()
	var context := DefendContext.new(baseBlock)
	for upgrade in upgradeSlots:
		if upgrade and upgrade.isOn:
			upgrade.modifyDefend(context)
	return context

func returnToIdle() -> void:
	play("Idle")
func turnStart() -> void:
	returnToIdle()
	maxEnergy += 1
	statusEffectComponent.tickAllStart()

func turnEnd() -> void:
	statusEffectComponent.tickAllEnd()
	
func getRemainingEnergy() -> int:
	return maxEnergy - usedEnergy

func toggleUpgrade(upgrade: Upgrade) -> bool:
	if upgrade.isOn:
		upgrade.isOn = false
		usedEnergy -= upgrade.energyCost
		return true
	elif getRemainingEnergy() >= upgrade.energyCost:
		upgrade.isOn = true
		usedEnergy += upgrade.energyCost
		return true
	return false
	
