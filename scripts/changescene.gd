extends Area3D

var canChange = false 
@export var sceneToLoad : String
var scene
var mainscene = "res://scenes/isthismainmenu.tscn"

func _ready() -> void:
	scene = "res://scenes/Levels/"+sceneToLoad+".tscn"

func _process(delta: float) -> void:
	if canChange && Input.is_action_pressed("Interact"):
		print("changescene")


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		canChange = true


func _on_body_exited(body: Node3D) -> void:
	canChange = false
