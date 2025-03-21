extends RigidBody3D

@export var SPEED = 300
@export var JUMPSPEED = 500

var dir : int = 0
var canJump : bool
var jumpInputCheck : bool #for the jump buffering
var isGrounded

func _ready() -> void:
	isGrounded = true
	
func _physics_process(delta: float) -> void:
	var inputaxis = Input.get_axis("Left","Right")
	var dir
	
	if inputaxis > 0:
		dir = 1
		rotation.y = deg_to_rad(90)
		if isGrounded:
			get_child(3).get_child(1).play("RUN") #gets the GIC Player then gets its Animation player
		else:
			get_child(3).get_child(1).play("JUMP")
			
	elif inputaxis < 0:
		dir = -1
		rotation.y = deg_to_rad(-90)
		if isGrounded:
			get_child(3).get_child(1).play("RUN")
		else:
			get_child(3).get_child(1).play("JUMP")
			
	else:
		dir = 0
		rotation.y = 0
		if isGrounded:
			get_child(3).get_child(1).play("IDLE")
		else:
			get_child(3).get_child(1).play("JUMP")
	
	linear_velocity.x = SPEED * dir * delta
	
	if canJump && isGrounded:
		Jump(delta)
		canJump = false
		
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
	
	if $JumpBufferingCheck.is_colliding():
		jumpInputCheck = true
	else:
		jumpInputCheck = false

func _input(event: InputEvent) -> void:
	if jumpInputCheck:
		if event.is_action_pressed("Jump"):
			canJump = true
	else:
		canJump = false 
			#if isGrounded:
				#canJump = true
			#else:
				#canJump = false 
		#if event.is_action_released("Jump"):
			#canJump = false

func Jump(delta):
	linear_velocity.y = JUMPSPEED * delta
	
