extends ObjectBase

func on_interact():
	AudioMaster.playSound("DoorOpen")
	
	await get_tree().create_timer(2).timeout
	SignalBus.exit_reached.emit(self)
