extends Resource
class_name SoundEffect

@export var name: String
@export var audio: AudioStreamOggVorbis

static func create(name: String, ogg: AudioStreamOggVorbis) -> SoundEffect:
	var s = SoundEffect.new()
	s.name = name
	s.audio = ogg
	return s
