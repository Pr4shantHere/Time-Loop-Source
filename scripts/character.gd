extends RigidBody3D

@export var SPEED = 650
@export var JUMPSPEED = 925
@export var COYOTETIMER = 0.02

@export var LOOPTIMER = 15

@export var canReset : bool = true

var hasOrb : bool = false


var dir : int = 0
var canJump : bool
var jumpInputCheck : bool #for the jump buffering
var isGrounded : bool
var jumpCount : int
var canCoyoteJump : bool
var vel



func _ready() -> void:
	jumpCount = 0
	canCoyoteJump = false
	dontpush()
	isGrounded = true
	$CoyoteTimer.wait_time = COYOTETIMER

func _physics_process(delta: float) -> void:
	var inputaxis = Input.get_axis("Left","Right")
	
	if inputaxis > 0:
		dir = 1
		rotation.y = lerp(rotation.y, deg_to_rad(90), 0.3)
		if isGrounded:
			get_child(3).get_child(1).play("RUN") #gets the GIC Player then gets its Animation player
		else:
			get_child(3).get_child(1).play("JUMP")
			
	elif inputaxis < 0:
		dir = -1
		rotation.y = lerp(rotation.y, deg_to_rad(-90), 0.3)

		if isGrounded:
			get_child(3).get_child(1).play("RUN")
		else:
			get_child(3).get_child(1).play("JUMP")
			
	else:
		dir = 0
		rotation.y = lerp(rotation.y, deg_to_rad(0), 0.3)

		if isGrounded:
			get_child(3).get_child(1).play("IDLE")
		else:
			get_child(3).get_child(1).play("JUMP")
	
	linear_velocity.x = vel * dir * delta
	
	if canJump && isGrounded or canJump && canCoyoteJump:
		Jump(delta)
		
	if $"Ground Check".is_colliding():
		jumpCount = 0
		isGrounded = true
	else:
		isGrounded = false
		dontpush()

	if isGrounded:
		gravity_scale = 1
	elif linear_velocity.y < 0:
		gravity_scale = 8
	elif linear_velocity.y > 0:
		gravity_scale = 3
		jumpCount = 1
	
	if $JumpBufferingCheck.is_colliding() && round(linear_velocity.y) < 2:
		jumpInputCheck = true
	else:
		jumpInputCheck = false
		
	if $CollisionCheck.is_colliding() && dir != 0:
		if $CollisionCheck.get_collider() is not Area3D:
			push()
		
		if $CollisionCheck.get_collider() is RigidBody3D:
			$CollisionCheck.get_collider().mass = 10
			$CollisionCheck.get_collider().linear_velocity.y = 0
			
			if rotation.y == 90 && dir == 1:
				$CollisionCheck.get_collider().linear_velocity.x = linear_velocity.x
				
			elif  rotation.y == -90 && dir == -1:
				$CollisionCheck.get_collider().linear_velocity.x = linear_velocity.x	
			# resetting is done in the script for the crate itself
	
	else:
		dontpush()
	
	if round(linear_velocity).y < 0 && jumpCount == 0 && round(linear_velocity.y) > -10:
		canCoyoteJump = true
		$CoyoteTimer.start()
		
	get_owner().get_node("LoopTimer").wait_time = LOOPTIMER
	get_owner().get_node("TimerModel/stopwatch/Hand").speed_scale = 1 / float(LOOPTIMER)


	if $CollisionCheck.is_colliding():# && Input.is_action_pressed("Interact"):
		if $CollisionCheck.get_collider() == Area3D:
			print("scene change")

	get_owner().get_node("Blood").position = position
	get_owner().get_node("Blood").visible = false

func _input(event: InputEvent) -> void:
	if jumpInputCheck == true or canCoyoteJump == true:
		if event.is_action_pressed("Jump"):
			canJump = true 
			
	if event.is_action_pressed("Reset") && canReset:
		get_tree().reload_current_scene()

func Jump(delta):
	jumpCount = 1 
	canJump = false
	linear_velocity.y = JUMPSPEED * delta
	$AudioStreamPlayer.play( )


func push():
	# Hide the animated arms
	# Player Model -> RIG -> Skeleton3D -> the arms
	
	get_child(3).get_child(0).get_child(0).get_child(0).visible = false
	get_child(3).get_child(0).get_child(0).get_child(1).visible = false
	get_child(3).get_child(0).get_child(0).get_child(6).visible = false
	get_child(3).get_child(0).get_child(0).get_child(7).visible = false
	
	# Show the PUSH arms
	get_child(3).get_child(2).visible = true
	
	# Make the animation faster to show that work is done
	get_child(3).get_child(1).speed_scale = 7
	
	vel = 340


func dontpush():
	# Show the animated arms
	# Player Model -> RIG -> Skeleton3D -> the arms
	
	get_child(3).get_child(0).get_child(0).get_child(0).visible = true
	get_child(3).get_child(0).get_child(0).get_child(1).visible = true
	get_child(3).get_child(0).get_child(0).get_child(6).visible = true
	get_child(3).get_child(0).get_child(0).get_child(7).visible = true
	
	# Hide the PUSH arms
	get_child(3).get_child(2).visible = false
	
	get_child(3).get_child(1).speed_scale = 4.5

	vel = SPEED

func _on_coyote_timer_timeout() -> void:
	canCoyoteJump = false

var isDead = false

func kill():
	get_node("Blood").emitting = true
	get_node("Respawn").start()
	get_node("GIC Player").visible = false


func _on_respawn_timeout() -> void:
	get_tree().reload_current_scene()
