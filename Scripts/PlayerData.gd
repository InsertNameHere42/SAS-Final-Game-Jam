extends Node


const SAVE_PATH = "user://saves/save.json"

var lastSaveRoomId: String = ""
var lastSpawnPosition: Vector3 = Vector3.ZERO
var lastScenePath: String = ""

var maxHp: int = 90
var currentHp: int = 90
var inventory: Array[Upgrade] = []
var equippedUpgrades: Array[Upgrade] = []
var maxUpgrades: int = 6
var doubloons: int = 50
var startingMaxEnergy: int = 1

signal loaded

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
	
func save(saveRoom: SaveRoomScreen):
	lastSaveRoomId = saveRoom.saveRoomId
	lastSpawnPosition = saveRoom.spawnPosition
	lastScenePath = saveRoom.get_tree().current_scene.scene_file_path
	_writeToFile()

func _writeToFile() -> void:
	DirAccess.make_dir_recursive_absolute("user://saves")
	DirAccess.make_dir_recursive_absolute("user://saves/upgrades")
	
	var inventoryPaths: Array = []
	for u in inventory:
		var path := "user://saves/upgrades/" + u.upgradeName + ".tres"
		ResourceSaver.save(u, path)
		inventoryPaths.append(path)
	
	var equippedPaths: Array = []
	for u in equippedUpgrades:
		if u:
			var path := "user://saves/upgrades/" + u.upgradeName + ".tres"
			ResourceSaver.save(u, path)
			equippedPaths.append(path)
		else:
			equippedPaths.append("")
	
	var data := {
		"currentHp": currentHp,
		"maxHp": maxHp,
		"doubloons": doubloons,
		"startingMaxEnergy": startingMaxEnergy,
		"lastSaveRoomId": lastSaveRoomId,
		"lastSpawnPosition": { "x": lastSpawnPosition.x, "y": lastSpawnPosition.y, "z": lastSpawnPosition.z },
		"lastScenePath": lastScenePath,
		"inventory": inventoryPaths,
		"equippedUpgrades": equippedPaths
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	print("Save written successfully, error: ", FileAccess.get_open_error())

func loadFromFile() -> void:
	print("File Loaded")
	if not FileAccess.file_exists(SAVE_PATH): return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data: Dictionary = JSON.parse_string(file.get_as_text())
	file.close()
	
	currentHp = data["currentHp"]
	maxHp = data["maxHp"]
	doubloons = data["doubloons"]
	startingMaxEnergy = data["startingMaxEnergy"]
	lastSaveRoomId = data["lastSaveRoomId"]
	lastScenePath = data["lastScenePath"]
	var sp = data["lastSpawnPosition"]
	lastSpawnPosition = Vector3(sp["x"], sp["y"], sp["z"])
	
	inventory.clear()
	for path in data["inventory"]:
		inventory.append(load(path))
	
	equippedUpgrades.resize(maxUpgrades)
	for i in data["equippedUpgrades"].size():
		var path: String = data["equippedUpgrades"][i]
		equippedUpgrades[i] = load(path) if path != "" else null


	loaded.emit()
	
	
	
