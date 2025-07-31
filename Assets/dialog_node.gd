extends Control

@export var dialog_path : Resource
var dialog_arr : Array
var dialog_idx = 0

# TODO: figure out a way to delay the adding of each char, timeout does not seem
# to work correctly, instead processes instantly

# TODO: Add resiliancy to text format, if speed is not present, use default value
# if important is not there, do it is not important

# TODO: Add important text functionality to node

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var text = $Text
		text.text = ""
		if dialog_idx == dialog_arr.size():
			return
		for char in dialog_arr[dialog_idx]["text"]:
			text.text += char
			wait(int(dialog_arr[dialog_idx]["speed"]))
		dialog_idx = dialog_idx + 1


func _ready():
	var text = $Text
	var dialog_file = FileAccess.open(dialog_path.resource_path, FileAccess.READ)
	var dialog_string = dialog_file.get_as_text()
	dialog_file.close()
	
	var dialogs = JSON.parse_string(dialog_string)
	
	print(dialogs)
	
	# TODO: abstract logic from on click and this section to own function
	dialog_arr = dialogs["dialog"]
	text.text = dialog_arr[dialog_idx]["text"]
	dialog_idx = dialog_idx + 1
