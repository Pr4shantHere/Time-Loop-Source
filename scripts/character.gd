extends RigidBody3D

@export var SPEED = 300
@export var JUMPSPEED = 500
@export var COYOTETIMER = 0.3

var dir : int = 0
var canJump : bool
var jumpInputCheck : bool #for the jump buffering
var isGrounded : bool
var jumpCount : int
var canCoyoteJump : bool

func _ready() -> void:
	jumpCount = 0
	dontpush()
	$CoyoteTimer.wait_time = COYOTETIMER

func _physics_process(delta: float) -> void:
	var inputaxis = Input.get_axis("Left","Right")
	
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
	
	if canJump && isGrounded or canJump && canCoyoteJump:
		Jump(delta)
		
	if $"Ground Check".is_colliding():
		jumpCount = 0
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
		
	if $CollisionCheck.is_colliding() && dir != 0:
		push()
	else:
		dontpush()
	
	if round(linear_velocity).y < 0 && jumpCount == 0:
		canCoyoteJump = true
		$CoyoteTimer.start()
		

func _input(event: InputEvent) -> void:
	if jumpInputCheck == true or canCoyoteJump == true:
		if event.is_action_pressed("Jump"):
			canJump = true 


func Jump(delta):
	jumpCount = 1 
	canJump = false
	linear_velocity.y = JUMPSPEED * delta


func push():
	# Hide the animated arms
	# Player Model -> RIG -> Skeleton3D -> the arms
	
	get_child(3).get_child(0).get_child(0).get_child(0).visible = false
	get_child(3).get_child(0).get_child(0).get_child(1).visible = false
	get_child(3).get_child(0).get_child(0).get_child(6).visible = false
	get_child(3).get_child(0).get_child(0).get_child(7).visible = false
	
	# Show the PUSH arms
	get_child(3).get_child(2).visible = true


func dontpush():
	# Show the animated arms
	# Player Model -> RIG -> Skeleton3D -> the arms
	
	get_child(3).get_child(0).get_child(0).get_child(0).visible = true
	get_child(3).get_child(0).get_child(0).get_child(1).visible = true
	get_child(3).get_child(0).get_child(0).get_child(6).visible = true
	get_child(3).get_child(0).get_child(0).get_child(7).visible = true
	
	# Hide the PUSH arms
	get_child(3).get_child(2).visible = false


func _on_coyote_timer_timeout() -> void:
	canCoyoteJump = false
