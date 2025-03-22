extends RigidBody3D

var pos_start
var timer
@export var isPushable : bool = true
@export var isResetable : bool = true


func _ready() -> void:
	pos_start = position

func _physics_process(delta: float) -> void:
	if get_owner().reset == true && isResetable:
		position = pos_start
	
	if isPushable:
		if get_owner().get_node("Character").dir == 0:
			mass = 10000
			axis_lock_linear_y = false
			linear_velocity.x = 0
			
