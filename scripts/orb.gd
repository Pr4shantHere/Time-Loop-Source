extends Node3D

var pos_start
var timer
@export var isPushable : bool = false
@export var isResetable : bool = true


func _ready() -> void:
	print(get_owner().name)
	pos_start = position

func _process(delta: float) -> void:
	if get_owner().get_node("Character").hasOrb == true:
		followw(delta)
		
	if get_owner().reset == true && isResetable:
		position = pos_start
		get_owner().get_node("Character").hasOrb = false
	
func followw(d):
	position.x = lerpf(position.x, get_owner().get_node("Character").get_node("FollowTarget").global_position.x, .06)
	position.y = lerpf(position.y, get_owner().get_node("Character").get_node("FollowTarget").global_position.y, .06)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		body.hasOrb = true
 
