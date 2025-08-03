extends Node2D

@export var offset = Vector2(3500, 0)
@export var duration = 50.0

@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	move_right()
	sound.play()

func move_right():
	var tween = create_tween()
	tween.tween_property(self, "position", position + offset, duration)

func _on_body_entered(body: Node2D) -> void:
	if get_tree() != null and body is CharacterBody2D:
		body.get_parent().die()
