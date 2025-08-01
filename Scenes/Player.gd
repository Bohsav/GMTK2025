extends Node2D
class_name Player

@onready var movementMod: MovementModule = $MovementModule
@onready var gravityMod: GravityModule = $GravityModule
@onready var inputMod: InputModule = $InputModule
@onready var playerbody: CharacterBody2D = $PlayerBody
@onready var staticbody: CollisionShape2D = $PlayerBody/PlayerCollision
@onready var runparticles: CPUParticles2D = $PlayerBody/RunParticles
@onready var sprites: AnimatedSprite2D = $PlayerBody/PlayerSprites
@onready var camera: CameraController = $PlayerBody/Camera2D

@export var gravity := 400
@export var speed := 40
@export var run_speed := 70
@export var jump_power := 200
@export var distance_interact := 40
@export var wake_up_time := 3
@export var tile_map_layer : TileMapLayer

@export var is_awake := false

var is_running := true

func _ready() -> void:
	camera.set_camera_limits(tile_map_layer.get_used_rect())
	sprites.play("wake_up")
	await get_tree().create_timer(wake_up_time).timeout 
	is_awake = true

func _physics_process(delta: float) -> void:
	if not is_awake: return
	runparticles.emitting = false

	updatePos()
	handleGravity(delta)
	handleMovement()

	playerbody.move_and_slide()
	return

func handleGravity(delta: float):
	gravityMod.handleGravity(gravity, delta)

func updatePos():
	self.queue_redraw()

func handleMovement():

	if playerbody.is_on_floor():
		if inputMod.getAxisX() > 0.0:
			if is_running:
				_run_particles(false)
				movementMod.move_right(run_speed)
				sprites.flip_h = true
				sprites.play("run")
			else:
				movementMod.move_right(speed)
		
		elif inputMod.getAxisX() < 0.0:
			if is_running:
				_run_particles(true)
				movementMod.move_left(run_speed)
				sprites.flip_h = false
				sprites.play("run")
			else:
				movementMod.move_left(speed)
		else:
			movementMod.idle_x()
			if playerbody.is_on_floor():
				sprites.play("idle")
		
		if inputMod.getAxisY() > 0.0:
			if movementMod.jump(jump_power):
				sprites.play("jump")
		
		
func _run_particles(flipped: bool) -> void:
	if not playerbody.is_on_floor(): return
	if flipped:
		runparticles.transform.scaled(Vector2(-1, runparticles.transform.get_scale().y))
	else:
		runparticles.transform.scaled(Vector2(1, runparticles.transform.get_scale().y))
	runparticles.emitting = true
	
func getPos() -> Vector2:
	return staticbody.global_position
