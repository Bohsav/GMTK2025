extends Node2D

@export var dialog_path = ""
@export var dialog_font : FontFile = FontFile.new()

@onready var audio = get_node("AudioStreamPlayer")
@onready var text_label: RichTextLabel = $Text
@onready var timer: Timer = $Timer
@onready var skiptimer: Timer = $SkipTimer

var dialog: Array = []
var dialog_trigger := 0
var dialog_skip_trigger := 0
var dialog_ongoing = false

var important = false
var phrase_num = 0
var finished = false

func _ready():
	skiptimer.wait_time = 0.3
	skiptimer.timeout.connect(func():
		dialog_skip_trigger = 0
	)
	self.visible = false
	SignalBus.play_dialog.connect(start_dialog)
	
func start_dialog(name: String) -> void:
	if not GameMaster.is_dialog:
		set_dialog(name)
		trigger_dialog()
		GameMaster.is_dialog = true
		
func reset_dialog():
	timer.set_wait_time(0.05)
	text_label.add_theme_font_override("normal_font", dialog_font)
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
	if dialog_trigger == 1 and !dialog_ongoing: # dialog start
		dialog_trigger = 0
		dialog_ongoing = true
		reset_dialog()
		next_phrase()
	if Input.is_action_just_pressed("interact") && dialog_ongoing:
		if !finished and not important and dialog_skip_trigger == 1:
			text_label.visible_characters = len(text_label.text)
			finished = true
			audio.playing = false
		elif finished:
			next_phrase()
		if dialog_skip_trigger == 0:
			skiptimer.start()
			dialog_skip_trigger = 1
		
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
	if phrase_num >= len(dialog): # end here if no more
		self.visible = false
		dialog_ongoing = false
		GameMaster.is_dialog = false
		return
	audio.playing = true
	finished = false
	important = dialog[phrase_num].important
	timer.set_wait_time(dialog[phrase_num].speed * 0.05)
	text_label.text = dialog[phrase_num].text
	text_label.visible_characters = 0
	while text_label.visible_characters < len(text_label.text):
		print(len(text_label.text))
		print(text_label.visible_characters)
		text_label.visible_characters += 1
		timer.start()
		await timer.timeout
	audio.playing = false
	finished = true
	phrase_num += 1
	return
