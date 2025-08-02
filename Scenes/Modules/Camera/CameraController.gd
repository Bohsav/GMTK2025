class_name CameraController extends Camera2D

@export var fade_in: float = 0.0
@export var shake_strength: float = 0.0

@onready var rng := RandomNumberGenerator.new()

var fade_length: float = 0.0

func _process(delta: float) -> void:
	if shake_strength > 0:
		var percent = fade_length / fade_in
		var offsetvalue = lerpf(0.0, shake_strength, clampf(percent, 0, 1))
		
		self.offset = randomOffset(offsetvalue)
		fade_length = fade_length + 1 + delta
		
func set_camera_limits(rect: Rect2i) -> void:
	limit_left =  rect.position.x
	limit_right = (rect.position.x + rect.size.x) * 16
	limit_top = rect.position.y
	limit_bottom = (rect.position.y + rect.size.y) * 16

func play_shake(strength: float, fadein: float) -> void:
	fade_length = 0
	shake_strength = strength
	fade_in = fadein * 60

func randomOffset(offsetvalue: float) -> Vector2:
	var rndShakeVal: float = rng.randf_range(-offsetvalue, offsetvalue)
	return Vector2(rndShakeVal, rndShakeVal)
