extends Node3D

var reset : bool = false

func _ready() -> void:
	AudioPlayer.play_music_level()

func _process(delta: float) -> void:
	if reset == true:
		$LoopTimer.start()
		reset = false
	
	if $LoopTimer.time_left > 5:
		$TimerModel.get_node("BOB").speed_scale = 1
	elif $LoopTimer.time_left <= 5 and $LoopTimer.time_left > 2:
		$TimerModel.get_node("BOB").speed_scale = lerpf($TimerModel.get_node("BOB").speed_scale, 3, 1)
	elif $LoopTimer.time_left <= 2 and $LoopTimer.time_left > 0.5:
		$TimerModel.get_node("BOB").speed_scale = lerpf($TimerModel.get_node("BOB").speed_scale, 5, 1)
	else:
		$TimerModel.get_node("BOB").speed_scale = lerpf($TimerModel.get_node("BOB").speed_scale, 7, 1)

	$TimerModel.get_node("stopwatch").get_node("Hand").play("hand")

func _on_loop_timer_timeout() -> void:
	reset = true
