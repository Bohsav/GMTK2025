extends Node2D

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("one"):
		get_tree().change_scene_to_file("res://level_1.tscn")
	
	if Input.is_action_pressed("two"):
		get_tree().quit()
