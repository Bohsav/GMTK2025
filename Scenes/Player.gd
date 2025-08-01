extends Node2D
class_name Player

@onready var movementMod: MovementModule = $MovementModule
@onready var gravityMod: GravityModule = $GravityModule
@onready var inputMod: InputModule = $InputModule
@onready var playerbody: CharacterBody2D = $PlayerBody
@onready var staticbody: CollisionShape2D = $PlayerBody/PlayerCollision
@onready var runparticles: CPUParticles2D = $PlayerBody/RunParticles

@export var gravity := 400
@export var speed := 40
@export var run_speed := 85
@export var jump_power := 200
@export var distance_interact := 40

var is_running := false

func _draw() -> void:
	draw_line(get_local_mouse_position(), staticbody.global_position, Color.BLACK, 1)

func _physics_process(delta: float) -> void:
	runparticles.emitting = false
	
	updatePos()
	gravityMod.handleGravity(gravity, delta)
	handleMovement()
	playerbody.move_and_slide()
	return

func updatePos():
	self.queue_redraw()

func handleMovement():
	if inputMod.getAxisX() > 0.0:
		if is_running:
			_run_particles(false)
			movementMod.move_right(run_speed)
		else:
			movementMod.move_right(speed)
	elif inputMod.getAxisX() < 0.0:
		if is_running:
			_run_particles(true)
			movementMod.move_left(run_speed)
		else:
			movementMod.move_left(speed)
	else:
		movementMod.idle_x()
	
	if inputMod.getAxisY() > 0.0:
		movementMod.jump(jump_power)

func _run_particles(flipped: bool) -> void:
	if not playerbody.is_on_floor(): return
	if flipped:
		runparticles.transform.scaled(Vector2(-1, runparticles.transform.get_scale().y))
		#runparticles.direction.x = 1.0
	else:
		runparticles.transform.scaled(Vector2(1, runparticles.transform.get_scale().y))
		#runparticles.direction.x = -1.0
	runparticles.emitting = true

func getPos() -> Vector2:
	return staticbody.global_position
