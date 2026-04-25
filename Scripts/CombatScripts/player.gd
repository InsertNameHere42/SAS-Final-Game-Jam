class_name Player extends Damagable

signal playerDied
@export var baseDamage: int = 5
@export var baseCritChance: float = 0.1
@export var baseCritDamageMultiplier: float = 1.5
@export var baseBlock: BlockEffect
@export var baseBlockAmount: int = 7
var maxEnergy: int = 0
var usedEnergy: int = 0

@export var upgradeSlots: Array[Upgrade] = []

func startCombat():
	print("Combat Started Player")
	maxHp = PlayerData.maxHp
	currentHp = PlayerData.currentHp
	upgradeSlots = PlayerData.equippedUpgrades
	maxEnergy = PlayerData.startingMaxEnergy
	maxEnergy = 1
	usedEnergy = 0
	for upgrade in upgradeSlots: #reset at start of combat
		if upgrade and upgrade.isOn:
			upgrade.isOn = false
			print("Upgrade disabled")

func _process(_delta: float) -> void:
	pass
		

func _ready() -> void:
	super._ready()
	turnStart()


		
func die() -> void:
	print("Player Died")
	emit_signal("playerDied")
	
#this will play an attack animation and calculate the damage done
func attack() -> AttackContext: 
	turnEnd()
	var context := AttackContext.new(baseDamage, baseCritChance, baseCritDamageMultiplier)
	for upgrade in upgradeSlots:
		if upgrade and upgrade.isOn:
			upgrade.modifyAttack(context)
	return context

func attackAnim() -> void:
	if animation == "Attack" and is_playing():
		frame = 1
	else:
		play("Attack")

func defend() -> DefendContext:
	print(baseBlock.stacks)
	play("Block")
	turnEnd()
	var context := DefendContext.new(baseBlockAmount, baseBlock)
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
	print(upgrade)
	if upgrade.isOn:
		upgrade.isOn = false
		usedEnergy -= upgrade.energyCost
		print("Upgrade disabled")
		return true
	elif getRemainingEnergy() >= upgrade.energyCost:
		upgrade.isOn = true
		usedEnergy += upgrade.energyCost
		print("Upgrade enabled")
		return true
	print("Couldn't activate upgrade")
	return false                                                                                            
