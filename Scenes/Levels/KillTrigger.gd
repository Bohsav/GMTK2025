extends Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.get_parent().die()
		get_node("CollisionShape2D").process_mode = Node.PROCESS_MODE_DISABLED
