extends Node2D

@export var offset = Vector2(1000, 0)
@export var duration = 200.0

func _ready():
	move_right()

func move_right():
	var tween = create_tween()
	tween.tween_property(self, "position", position + offset, duration)
