extends Area3D

var canChange = false 
@export var sceneToLoad : String
var scene
var mainscene = "res://scenes/isthismainmenu.tscn"
var camera
var canReallyChange

func _ready() -> void:
	scene = "res://scenes/Levels/"+sceneToLoad+".tscn"
	camera = get_owner().get_node("Camera")

func _process(delta: float) -> void:
	if canChange && Input.is_action_pressed("Interact"):
		camera.get_node("AnimationPlayer").play("IN")
		camera.get_node("WAITBEFORESWITCHING").start()
		
	if sceneToLoad == "main":
		scene = mainscene


	if camera.canChange:
		get_tree().change_scene_to_file(scene)
		
	#print(canChange)


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		canChange = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Character":
		canChange = false
