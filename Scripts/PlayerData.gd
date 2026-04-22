extends Node

var maxHp: int = 90
var currentHp: int = 90
var inventory: Array[Upgrade] = []
var equippedUpgrades: Array[Upgrade] = []
var maxUpgrades: int = 6
var doubloons: int = 10
var startingMaxEnergy: int = 1

func restoreHp():
	currentHp = maxHp

func equipUpgrade(upgrade: Upgrade, slotIndex: int) -> bool:
	if slotIndex>=maxUpgrades:
		return false
	equippedUpgrades[slotIndex] = upgrade
	return true
	
func unequipUpgrade(slotIndex: int) -> bool:
	if equippedUpgrades[slotIndex]:
		equippedUpgrades[slotIndex] = null
		return true
	return false
	
func isEquipped(upgrade: Upgrade) -> bool:
	return equippedUpgrades.has(upgrade)

func ownsUpgrade(upgrade: Upgrade) -> bool:
	var check := func(u): return u == upgrade
	return inventory.any(check)
