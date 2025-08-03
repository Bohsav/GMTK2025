extends ObjectBase

@onready var door := preload("res://Scenes/Objects/ExitObject.tscn")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite

@export var is_dark = false

func _ready() -> void:
	if is_dark:
		sprite.animation = "dark"
	else:
		sprite.animation = "day"
		
func on_interact():
	if PlayerInventory.has("key"):
		var d: Node2D = door.instantiate()
		d.position = self.position
		await get_tree().create_timer(1).timeout
		get_parent().add_child(d)
