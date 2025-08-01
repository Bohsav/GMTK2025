extends Node2D
	
func _on_start_pressed() -> void:
	GameMaster.loadLevel("uid://dyltwnfekx7mr")


func _on_exit_pressed() -> void:
	get_tree().quit()
