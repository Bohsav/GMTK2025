extends Node
class_name InputModule

var axis_x := 0.0
var axis_y := 0.0

func _unhandled_input(event: InputEvent) -> void:
	axis_x = Input.get_axis("move_left", "move_right")
	axis_y = Input.get_axis("move_down", "jump")

func getAxisX() -> float:
	return axis_x

func getAxisY() -> float:
	return axis_y
