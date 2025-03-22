extends Node3D

var reset : bool = false

func _process(delta: float) -> void:
	if reset == true:
		$LoopTimer.start()
		reset = false
	
	if $LoopTimer.time_left > 5:
		$BOB.speed_scale = 1
	elif $LoopTimer.time_left <= 5 and $LoopTimer.time_left > 2:
		$BOB.speed_scale = lerpf($BOB.speed_scale, 3, 1)
	elif $LoopTimer.time_left <= 2 and $LoopTimer.time_left > 0.5:
		$BOB.speed_scale = lerpf($BOB.speed_scale, 5, 1)
	else:
		$BOB.speed_scale = lerpf($BOB.speed_scale, 7, 1)

	$stopwatch/Hand.play("hand")

func _on_loop_timer_timeout() -> void:
	reset = true
