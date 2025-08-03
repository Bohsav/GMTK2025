extends Node2D

@export var offset = Vector2(2000, 0)
@export var duration = 85.0

func _ready():
	move_right()

func move_right():
	var tween = create_tween()
	tween.tween_property(self, "position", position + offset, duration)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.get_parent().die()
