extends RigidBody3D

@export var SPEED = 300
@export var JUMPSPEED = 500

var dir : int = 0
var canJump : bool
var isGrounded

func _ready() -> void:
	isGrounded = true
	
func _physics_process(delta: float) -> void:
	var inputaxis = Input.get_axis("Left","Right")
	var dir
	
	if inputaxis > 0:
		dir = 1
		rotation.y = deg_to_rad(90)#lerpf(rotation.y, 90, 12)
	elif inputaxis < 0:
		dir = -1
		rotation.y = deg_to_rad(-90)#lerpf(rotation.y, -90, 12)
	else:
		dir = 0
		rotation.y = 0
	
	linear_velocity.x = SPEED * dir * delta
	
	if canJump && isGrounded:
		Jump(delta)
		
	if $"Ground Check".is_colliding():
		isGrounded = true
	else:
		isGrounded = false

	if isGrounded:
		gravity_scale = 1
	elif linear_velocity.y < 0:
		gravity_scale = lerpf(2,4,1.5)
	elif linear_velocity.y > 0:
		gravity_scale = 3
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Jump"):
		if isGrounded:
			canJump = true
		else:
			canJump = false 
	if event.is_action_released("Jump"):
		canJump = false

func Jump(delta):
	linear_velocity.y = JUMPSPEED * delta
	
