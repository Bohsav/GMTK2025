extends Node2D

@onready var selectSprite: AnimatedSprite2D = $SelectSprite

func _ready() -> void:
	selectSprite.visible = false

func _process(delta: float) -> void:
	selectSprite.global_position = get_global_mouse_position()

func _physics_process(delta):
	var space = get_world_2d().direct_space_state
	var mousePos = get_global_mouse_position()
	var params = PhysicsPointQueryParameters2D.new()
	params.collide_with_areas = true
	params.collide_with_bodies = false
	params.position = mousePos

	var found = false
	for object in space.intersect_point(params, 15):
		if object.collider.get_parent() is ObjectBase:
			found = true
			break
			
	selectSprite.visible = found and not GameMaster.is_dialog
		 
