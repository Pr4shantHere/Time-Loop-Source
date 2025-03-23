extends Node3D

var pos_start
var timer
@export var isPushable : bool = false
@export var isResetable : bool = true

@export var isRed : bool = true
@export var isBlue : bool = false
@export var isOrange : bool = false
@export var isDiamond : bool = false

@export var allowFollow : bool = true

var pos

func _ready() -> void:
	pos_start = position
	if isRed:
		$"Meshes for Anim/Area3D/MeshInstance3D".mesh = load("res://assets/Orbs/Red Orb.obj")
	elif isBlue:
		$"Meshes for Anim/Area3D/MeshInstance3D".mesh = load("res://assets/Orbs/Blue Orb.obj")
	elif isOrange:
		$"Meshes for Anim/Area3D/MeshInstance3D".mesh = load("res://assets/Orbs/Orange Orb.obj")
	elif isDiamond:
		$"Meshes for Anim/Area3D/MeshInstance3D".mesh = load("res://assets/Orbs/Diamond Orb.obj")

func _process(delta: float) -> void:
	if allowFollow:
		if get_owner().get_node("Character").hasOrb == true:
			followw(delta)
			
			if isRed:
				Global.red = true
			if isBlue:
				Global.blue = true
			if isOrange:
				Global.orange = true
			if isDiamond:
				Global.diamond = true

		
		if get_owner().reset == true && isResetable:
			position = pos_start
			get_owner().get_node("Character").hasOrb = false

	
func followw(d):
	position.x = lerpf(position.x, get_owner().get_node("Character").get_node("FollowTarget").global_position.x, .06)
	position.y = lerpf(position.y, get_owner().get_node("Character").get_node("FollowTarget").global_position.y, .06)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Character" && body.dir != 0 && allowFollow:
		body.hasOrb = true
		$AudioStreamPlayer.play()
