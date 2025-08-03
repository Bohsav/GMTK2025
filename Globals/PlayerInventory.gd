extends Node

var inventory: Array = []

func add(name: String) -> void:
	inventory.append(name)
	
func has(name: String) -> bool:
	for item in inventory:
		if item == name:
			return true
	return false

func clearInventory():
	inventory.clear()
