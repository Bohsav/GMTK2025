extends AudioStreamPlayer

var soundLibrary: Array[SoundEffect]

func _init() -> void:
	self.max_polyphony = 5
	soundLibrary.append(SoundEffect.create("Alarm", preload("res://Assets/Audio/Alarm.ogg")))
	soundLibrary.append(SoundEffect.create("Alarm_Loop", preload("res://Assets/Audio/Alarm_Loop.ogg")))
	soundLibrary.append(SoundEffect.create("DoorKnocking", preload("res://Assets/Audio/Door Knocking.ogg")))
	soundLibrary.append(SoundEffect.create("DoorOpen", preload("res://Assets/Audio/Door Open.ogg")))
	soundLibrary.append(SoundEffect.create("WakingUp", preload("res://Assets/Audio/get up from bed.ogg")))
	soundLibrary.append(SoundEffect.create("HeartBeat", preload("res://Assets/Audio/Heartbeat.ogg")))
	soundLibrary.append(SoundEffect.create("JumpLanding", preload("res://Assets/Audio/Jump Landing.ogg")))
	soundLibrary.append(SoundEffect.create("KeyInCoat", preload("res://Assets/Audio/Key in Coat.ogg")))
	soundLibrary.append(SoundEffect.create("Panting", preload("res://Assets/Audio/panting.ogg")))
	soundLibrary.append(SoundEffect.create("Running", preload("res://Assets/Audio/Running.ogg")))
	soundLibrary.append(SoundEffect.create("Tentacle", preload("res://Assets/Audio/Tentacle.ogg")))
	soundLibrary.append(SoundEffect.create("Tripping", preload("res://Assets/Audio/tripping.ogg")))
	soundLibrary.append(SoundEffect.create("Walking", preload("res://Assets/Audio/Walking.ogg")))
	soundLibrary.append(SoundEffect.create("WindowOpen", preload("res://Assets/Audio/window open.ogg")))
	soundLibrary.append(SoundEffect.create("WindBlowing", preload("res://Assets/Audio/Wind Blowing.ogg")))

func playSound(name: String) -> void:
	for sound in soundLibrary:
		if sound.name == name:
			self.stream = sound.audio
			play()
			return

func playSoundPitch(name: String, pitch: float) -> void:
	for sound in soundLibrary:
		if sound.name == name:
			self.pitch_scale = pitch
			self.stream = sound.audio
			play()
			return
