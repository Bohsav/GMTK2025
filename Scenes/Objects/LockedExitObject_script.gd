extends ObjectBase

@onready var door: Node2D = get_parent().get_node("UnlockedDoor")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite

@export var is_dark = false

func _ready() -> void:
	door.global_position = Vector2(-100, -100)
	if is_dark:
		sprite.animation = "dark"
	else:
		sprite.animation = "day"
		
func on_interact():
	if PlayerInventory.has("key"):
		PlayerInventory.clearInventory()
		door.visible = true
		
		await get_tree().create_timer(1).timeout
		door.global_position = self.position
		self.position = Vector2(-100, -100)
