extends Node
class_name MovementModule

@export var default_coyote_time := 12

var characterbody2d: CharacterBody2D
var coyotetime := 0
var has_jumped := false

func _physics_process(delta: float) -> void:
	if coyotetime <= 0:
		has_jumped = true
	if coyotetime > 0:
		coyotetime = coyotetime - 1
	if characterbody2d.is_on_floor():
		coyotetime = default_coyote_time
		has_jumped = false

func _enter_tree() -> void:
	characterbody2d = NodeUtils.getChildByType(get_parent(), CharacterBody2D)

func move_by_axis_x(axis: float, speed: float):
	characterbody2d.velocity.x = axis * speed

func move_right(speed: float):
	characterbody2d.velocity.x = speed
	
func move_left(speed: float):
	characterbody2d.velocity.x = -speed
	
func move_up(speed: float):
	characterbody2d.velocity.y = -speed
	
func move_down(speed: float):
	characterbody2d.velocity.y = speed

func jump(power: float) -> bool:
	if coyotetime > 0 and not has_jumped:
		has_jumped = true
		characterbody2d.velocity.y = -power
		return true
	return false

func idle_x():
	characterbody2d.velocity.x = 0

func hasJumped() -> bool:
	return has_jumped
