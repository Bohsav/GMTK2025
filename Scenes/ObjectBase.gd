extends Node2D
class_name ObjectBase

var is_hovering := false
var min_distance := 40.0

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact"): return
	if event is InputEventMouseButton:
		var player: Player = NodeUtils.getChildByType(NodeUtils.getChildByType(get_tree().root, LevelRoom), Player) 
		var is_valid: bool = is_hovering and player and player.getPos().distance_to(get_global_mouse_position()) < min_distance
		if is_valid:
			on_interact()

func on_interact() -> void:
	pass

func _on_area_2d_mouse_entered() -> void: 
	is_hovering = true
	pass

func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
	pass
