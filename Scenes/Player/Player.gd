extends Node

@onready var movementMod: MovementModule = $MovementModule
@onready var gravityMod: GravityModule = $GravityModule
@onready var inputMod: InputModule = $InputModule
@onready var playerbody: CharacterBody2D = $PlayerBody

@export var gravity := 400
@export var speed := 75
@export var jump_power := 200

func _physics_process(delta: float) -> void:
	gravityMod.handleGravity(gravity, delta)
	handleMovement()
	playerbody.move_and_slide()
	return
	
func handleMovement():
	if inputMod.getAxisX() > 0.0:
		movementMod.move_right(speed)
	elif inputMod.getAxisX() < 0.0:
		movementMod.move_left(speed)
	else:
		movementMod.idle_x()
		
	if inputMod.getAxisY() > 0.0:
		movementMod.jump(jump_power)
