extends Node
class_name GravityModule

var characterbody2d: CharacterBody2D
var isFalling := false

func _enter_tree() -> void:
	characterbody2d = NodeUtils.getChildByType(get_parent(), CharacterBody2D)

func handleGravity(force: float, delta: float) -> void:
	if not characterbody2d.is_on_floor():
		characterbody2d.velocity.y += force * delta
	isFalling = characterbody2d.velocity.y > 0 and not characterbody2d.is_on_floor()
