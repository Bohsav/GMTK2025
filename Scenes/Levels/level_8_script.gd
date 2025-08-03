extends LevelRoom

var is_knocking := false
var is_finished := false
var rnd: RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	if not is_finished and not is_knocking:
		is_knocking = true
		var delay = rnd.randi_range(1, 5)
		AudioMaster.playSound("DoorKnocking")
		await get_tree().create_timer(delay).timeout
		is_knocking = false
