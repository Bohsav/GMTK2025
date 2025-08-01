extends Node2D
class_name LevelRoom

@onready var fadeblack: ColorRect = $CanvasLayer/FadeBlack

var is_transition: bool = true

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(fadeblack.material, "shader_parameter/outer_radius", 0.8, 3)
