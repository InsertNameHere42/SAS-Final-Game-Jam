extends Node

var doubloons: int = 10
var inventory: Array[Upgrade] = []

func ownsUpgrade(upgrade: Upgrade) -> bool:
	var check := func(u): return u == upgrade
	return inventory.any(check)
