extends Node2D

@export var dialog_path = ""
@export var dialog_font : FontFile = FontFile.new()

@onready var audio = get_node("AudioStreamPlayer")

var text_speed: float = 0.05

var dialog: Array = []
var dialog_trigger = 0
var dialog_ongoing = false

var important = false
var phrase_num = 0
var finished = false

func _ready():
	self.visible = false
	SignalBus.play_dialog.connect(start_dialog)

func start_dialog(name: String) -> void:
	set_dialog(name)
	trigger_dialog()
	GameMaster.is_dialog = true

func reset_dialog():
	$Timer.set_wait_time(text_speed)
	$Text.add_theme_font_override("normal_font", dialog_font)
	var d = get_dialog()
	assert(d, "Dialog not found")
	dialog = d
	phrase_num = 0
	finished = false
	self.visible = true
	
func trigger_dialog():
	if dialog_ongoing: return
	dialog_trigger = 1
	
func _process(_delta):
	# $Indicator.visible = finished
	if dialog_trigger == 1 and !dialog_ongoing:
		dialog_trigger = 0
		dialog_ongoing = true
		reset_dialog()
		next_phrase()
	if Input.is_action_just_pressed("interact") && dialog_ongoing:
		if !finished and not important:
			$Text.visible_characters = len($Text.text)
			finished = true
			audio.playing = false
		elif finished:
			next_phrase()
	if dialog_trigger == 0 and !dialog_ongoing:
		GameMaster.is_dialog = false
		
func set_dialog(filename : String):
	dialog_path = "res://Dialog/" + filename + ".json"
	
func get_dialog() -> Array:
	var f: FileAccess = FileAccess.open(dialog_path, FileAccess.READ)
	assert(f.file_exists(dialog_path), "File path does not exist")
	
	var json = f.get_as_text()
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(json)
	var output: Dictionary = test_json_conv.get_data()
	
	return output.dialog
	
func next_phrase() -> void:
	if phrase_num >= len(dialog):
		self.visible = false
		dialog_ongoing = false
		return
	audio.playing = true
	finished = false
	important = dialog[phrase_num].important
	text_speed = dialog[phrase_num].speed
	$Text.text = dialog[phrase_num].text
	$Text.visible_characters = 0
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout
	
	audio.playing = false
	finished = true
	phrase_num += 1
	return
