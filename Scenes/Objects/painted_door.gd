extends ObjectBase

func on_interact() -> void:
	if randi() % 2 == 0:
		SignalBus.play_dialog.emit("Level_3.PaintedDoor")
	else:
		SignalBus.play_dialog.emit("Level_3.PaintedDoor_2")
