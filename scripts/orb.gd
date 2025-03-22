extends Node3D

func _ready() -> void:
	print(get_owner().name)

func _process(delta: float) -> void:
	if get_owner().get_node("Character").hasRed == true:
		followw(delta)
	
func followw(d):
	position.x = lerpf(position.x, get_owner().get_node("Character").get_node("FollowTarget").global_position.x, .06)
	position.y = lerpf(position.y, get_owner().get_node("Character").get_node("FollowTarget").global_position.y, .06)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		body.hasRed = true
		print(body.hasRed)
 
