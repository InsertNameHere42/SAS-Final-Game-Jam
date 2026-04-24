extends Node

var maxHp: int = 90
var currentHp: int = 90
var inventory: Array[Upgrade] = []
var equippedUpgrades: Array[Upgrade] = []
var maxUpgrades: int = 6
var doubloons: int = 10
var startingMaxEnergy: int = 1

func _ready() -> void:
	equippedUpgrades.resize(maxUpgrades)

func restoreHp():
	currentHp = maxHp

func equipUpgrade(upgrade: Upgrade, slotIndex: int) -> bool:
	if slotIndex>=maxUpgrades:
		return false
	equippedUpgrades[slotIndex] = upgrade
	return true
	
func unequipUpgrade(upgrade: Upgrade) -> void:
	var idx := equippedUpgrades.find(upgrade)
	if idx != -1:
		equippedUpgrades[idx] = null
	
func isEquipped(upgrade: Upgrade) -> bool:
	return equippedUpgrades.has(upgrade)

func ownsUpgrade(upgrade: Upgrade) -> bool:
	var check := func(u): return u == upgrade
	return inventory.any(check)
