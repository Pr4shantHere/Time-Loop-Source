extends RigidBody3D

var pos_start
var timer

func _ready() -> void:
	pos_start = position

func _physics_process(delta: float) -> void:
	if get_owner().reset == true:
		position = pos_start
