extends ObjectBase

@onready var sprites: AnimatedSprite2D = $AnimatedSprite
@onready var blackscreen: ColorRect
var ending: bool = false

func _ready() -> void:
	blackscreen = get_parent().get_node("ColorRect")
	blackscreen.visible = false

func _process(delta: float) -> void:
	if not GameMaster.is_dialog and ending:
		await get_tree().create_timer(3).timeout
		GameMaster.reset_game()

func on_interact() -> void:
	get_parent().is_finished = true
	AudioMaster.playSound("DoorOpen")
	sprites.play("day_door_open")
	await get_tree().create_timer(2).timeout
	
	blackscreen.visible = true
	SignalBus.play_dialog.emit("level_8.ending_0")
	ending = true
