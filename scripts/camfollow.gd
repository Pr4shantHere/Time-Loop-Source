extends Camera3D

func _process(delta: float) -> void:
	position.y = lerp(position.y, get_owner().get_node("Character").position.y + 4.877,0.12)
	position.x = lerp(position.x, get_owner().get_node("Character").position.x , 0.12)

	var posx
	var posy
	posx = get_owner().get_node("TimerModel").position.x
	posy = get_owner().get_node("TimerModel").position.y
	posx = lerp(posx, position.x , 0.12)
	posy = lerp(posy, position.y - 5, 0.12)


	get_owner().get_node("TimerModel").position.x = posx
	get_owner().get_node("TimerModel").position.y = posy
