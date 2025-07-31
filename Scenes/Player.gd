extends Node2D
class_name Player

@onready var movementMod: MovementModule = $MovementModule
@onready var gravityMod: GravityModule = $GravityModule
@onready var inputMod: InputModule = $InputModule
@onready var playerbody: CharacterBody2D = $PlayerBody
@onready var staticbody: CollisionShape2D = $PlayerBody/PlayerCollision

@export var gravity := 400
@export var speed := 75
@export var jump_power := 200
@export var distance_interact := 40

func _draw() -> void:
	draw_line(get_local_mouse_position(), staticbody.global_position, Color.BLACK, 1)

func _physics_process(delta: float) -> void:
	updatePos()
	gravityMod.handleGravity(gravity, delta)
	handleMovement()
	playerbody.move_and_slide()
	return

func updatePos():
	self.queue_redraw()

func handleMovement():
	if inputMod.getAxisX() > 0.0:
		movementMod.move_right(speed)
	elif inputMod.getAxisX() < 0.0:
		movementMod.move_left(speed)
	else:
		movementMod.idle_x()
	
	if inputMod.getAxisY() > 0.0:
		movementMod.jump(jump_power)

func getPos() -> Vector2:
	return staticbody.global_position
