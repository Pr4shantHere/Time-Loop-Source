extends Node3D

var reset : bool = false

func _process(delta: float) -> void:
	if reset == true:
		$Timer.start()
		reset = false


func _on_timer_timeout() -> void:
	reset = true
	print(reset)
