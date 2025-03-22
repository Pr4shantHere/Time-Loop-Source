extends Node3D

var red : bool = false
var white : bool = false
var blue : bool = false 

func _ready() -> void:
	if !red:
		$Area3D/RED.visible = false
	if !white:
		$Area3D/WHITE.visible = false
	if !blue:
		$Area3D/BLUE.visible = false


func _process(delta: float) -> void:
	if red:
		$Area3D/RED.visible = true
	if white:
		$Area3D/WHITE.visible = true
	if blue:
		$Area3D/BLUE.visible = true
