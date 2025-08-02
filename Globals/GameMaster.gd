extends Node

var level_count = 0
var player_retries = 0

var level_0 := "uid://dikc2krvceeil"
var level_1 := "uid://dyltwnfekx7mr"
var credits := "uid://dhkuud6bdi0xj"
var main_menu := "uid://dikc2krvceeil"

var loading_progress := []
var loading_scene: String
var is_loading := false
var current_scene: PackedScene

func connect_signals() -> void:
	SignalBus.exit_reached.connect(level_end)
	SignalBus.player_death.connect(player_death)
	
func initialize_game() -> void:
	level_count = 0
	player_retries = 0

func _init() -> void:
	initialize_game()
	connect_signals()

func _process(delta: float) -> void:
	if is_loading:
		ResourceLoader.load_threaded_get_status(loading_scene, loading_progress)
		if loading_progress[0] >= 1:
			is_loading = false
			if loading_scene != "uid://dhkuud6bdi0xj" && loading_scene != "uid://dikc2krvceeil":
				await get_tree().create_timer(3).timeout 
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(loading_scene))
			current_scene = ResourceLoader.load_threaded_get(loading_scene)
	
func level_end(object: Object) -> void:
	level_count = level_count + 1
	loadLevel(get_level_by_level_count(level_count))
	
func player_death() -> void:
	player_retries = player_retries + 1
	
func get_level_by_level_count(value: int) -> String:
	var packedscene = level_0
	match value:
		1: packedscene = level_1
		_: packedscene = level_0
	return packedscene

func loadLevel(level: String) -> void:
	loading_scene = level
	ResourceLoader.load_threaded_request(loading_scene)
	
	if loading_scene != "uid://dhkuud6bdi0xj" && loading_scene != "uid://dikc2krvceeil":
		get_tree().change_scene_to_packed(preload("uid://i6kuw60qattu"))
	is_loading = true

func getLoadingProgress() -> float:
	if is_loading:
		return loading_progress[0] * 100
	else:
		return -1

func isLoading() -> bool:
	return is_loading
