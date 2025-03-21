extends RigidBody3D

var pos_start

func _ready() -> void:
	pos_start = position

func _on_timer_timeout() -> void:
	position = pos_start
