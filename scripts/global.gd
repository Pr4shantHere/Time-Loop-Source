extends Node3D

var reset : bool = false

func _process(delta: float) -> void:
	if reset == true:
		$LoopTimer.start()
		reset = false


func _on_timer_timeout() -> void:
	reset = true


func _on_loop_timer_timeout() -> void:
	reset = true
