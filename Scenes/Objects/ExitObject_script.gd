extends ObjectBase

@onready var sprites: AnimatedSprite2D = $AnimatedSprite

@export var is_dark = false

func _ready() -> void:
	if is_dark:
		sprites.animation = "dark_door_open"
	else:
		sprites.animation = "day_door_open"
	
func on_interact():
	AudioMaster.playSound("DoorOpen")
	
	if is_dark:
		sprites.play("dark_door_open")
	else:
		sprites.play("day_door_open")
	
	
	await get_tree().create_timer(2).timeout
	SignalBus.exit_reached.emit(self)
