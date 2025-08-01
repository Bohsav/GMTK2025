class_name CameraController extends Camera2D

func set_camera_limits(rect: Rect2i) -> void:
	limit_left =  rect.position.x
	limit_right = (rect.position.x + rect.size.x) * 16
	limit_top = rect.position.y
	limit_bottom = (rect.position.y + rect.size.y) * 16
