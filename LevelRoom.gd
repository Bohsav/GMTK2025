extends Node2D
class_name LevelRoom

@onready var fadeblack: ColorRect = $UI/FadeBlack
@onready var sequence: AnimationPlayer = $SequencePlayer
@onready var nightmare_mask: Sprite2D = $UI/BackBufferCopy/Mask
@onready var ui: Node2D = $UI
@onready var camera = get_viewport().get_camera_2d()
@onready var player: Player = $Player

@export var nightmare_time: float = 5
@export var player_running: bool = false

var n_time: float = 0
var nightmare_run = false

func _ready() -> void:
	n_time = nightmare_time * 60
	nightmare_mask.scale = Vector2(15, 15)
	player.is_running = player_running

func _physics_process(delta: float) -> void:
	if nightmare_run:
		n_time = n_time - 1
		var percent = 1 - (n_time / (nightmare_time * 60))
		var scale = lerp(15, 1, clampf(percent, 0, 1.0))
		nightmare_mask.scale = Vector2(scale, scale)

func _process(delta: float) -> void:
	ui.global_position = camera.get_screen_center_position()

func start_nightmares() -> void:
	nightmare_run = true
