extends Node2D

@onready var breath_resource: AudioStreamOggVorbis = preload("res://Assets/Audio/Breathing.ogg")
@onready var heavy_breath_resource: AudioStreamOggVorbis = preload("res://Assets/Audio/HeavyBreathing.ogg")

@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D
@onready var breathing: AudioStreamPlayer = $BreathingStreamer

var counter: int = 0

func setImageScene(name: String, frame: int):
	sprites.animation = name
	sprites.frame = frame
	
func playDoorSwing():
	sprites.play("open_door")

func playAudio(name: String):
	if AudioMaster.playing:
		AudioMaster.stop()
	AudioMaster.playSound(name)

func stopAudio():
	AudioMaster.stop()

func startBreathing():
	breathing.stream = breath_resource
	breathing.play()

func startHeavyBreathing():
	breathing.stream = heavy_breath_resource
	breathing.play()
