extends Node


var doubloons: int = 10
var inventory: Array[Upgrade] = []

var maxHp: int = 90
var currentHp: int = maxHp
var startingMaxEnergy: int = 1

func ownsUpgrade(upgrade: Upgrade) -> bool:
	var check := func(u): return u == upgrade
	return inventory.any(check)
