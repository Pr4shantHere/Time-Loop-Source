extends Node3D

var char

var red = false
var blue = false
var diamond = false	
var orange = false

func _ready() -> void:
	char = get_tree().current_scene.get_node("Character")
	
	red = false
	blue = false
	diamond = false
	orange = false
	
func _process(delta: float) -> void:
	#await char.get_node("Respawn").timeout
	await get_tree().process_frame
	
	if get_tree().current_scene && get_tree().current_scene.name == "Roots":
		if red:
			char.get_node("Red Orb").visible = true
		else:
			char.get_node("Red Orb").visible = false
		if blue:
			char.get_node("Blue Orb").visible = true
		else:
			char.get_node("Blue Orb").visible = false
		if orange:
			char.get_node("Orange Orb").visible = true
		else:
			char.get_node("Orange Orb").visible = false
		if diamond:
			char.get_node("Diamond Orb").visible = true
		else:
			char.get_node("Diamond Orb").visible = false
