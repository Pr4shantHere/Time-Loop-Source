extends Area3D

var canSwitch
@export var objToDrop : RigidBody3D

func _ready() -> void:
	$OFF.visible = true
	$ON.visible = false

func _process(delta: float) -> void:
	if canSwitch && Input.is_action_pressed("Interact"):
		Switch()
	if get_owner().reset == true:
		$OFF.visible = true
		$ON.visible = false
		objToDrop.gravity_scale = 0


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Character":
		canSwitch = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Character":
		canSwitch = false

func Switch():
	$ON.visible = true
	$OFF.visible = false
	objToDrop.gravity_scale = 5
