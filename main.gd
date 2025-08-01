extends Node2D

@export var start2:Label
@export var start:Label
@export var exit:Label
@export var exit2:Label
@export var credits:Label
@export var credits2:Label

func _ready() -> void:
	start2.visible = false
	exit2.visible = false
	credits2.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://level_1.tscn")


func _on_exitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("left_click"):
		get_tree().quit()

func _on_creditsbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("left_click"):
		get_tree().change_scene_to_file("res://credits.tscn")

func _on_area_2d_mouse_entered() -> void:
	start.visible = false
	start2.visible = true


func _on_area_2d_mouse_exited() -> void:
	start.visible = true
	start2.visible = false


func _on_exitbox_mouse_entered() -> void:
	exit.visible = false
	exit2.visible = true


func _on_exitbox_mouse_exited() -> void:
	exit.visible = true
	exit2.visible = false


func _on_creditsbox_mouse_entered() -> void:
	credits.visible = false
	credits2.visible = true


func _on_creditsbox_mouse_exited() -> void:
	credits.visible = true
	credits2.visible = false
