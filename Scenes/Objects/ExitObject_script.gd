extends ObjectBase

func on_interact():
	SignalBus.exit_reached.emit(self)
