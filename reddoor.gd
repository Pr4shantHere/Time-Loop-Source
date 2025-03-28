extends Area3D
var scene = "res://scenes/red1.tscn"

var camera
var canReallyChange
var canChange

var realscene = ""

@export var toMain : bool = false

func _ready() -> void:
		camera = get_owner().get_node("Camera")

func _process(delta: float) -> void:
	if canChange && Input.is_action_pressed("Interact"):
		camera.get_node("AnimationPlayer").play("IN")
		camera.get_node("WAITBEFORESWITCHING").start()
		Global.red = false

	if camera.canChange && realscene != "":
		get_tree().change_scene_to_file(realscene)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		canChange = true
		
		if toMain == true:
			realscene = "res://scenes/start.tscn"
		else:
			realscene = scene

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Character":
		canChange = false
		realscene = ""
