extends Camera3D

func _process(delta: float) -> void:
	position.y = lerp(position.y, get_owner().get_node("Character").position.y + 4.877,0.12)
	position.x = lerp(position.x, get_owner().get_node("Character").position.x , 0.12)
