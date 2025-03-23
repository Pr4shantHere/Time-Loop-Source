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
