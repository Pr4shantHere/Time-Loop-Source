extends Camera3D

var canChange
var showUndo = false

func _ready() -> void:
	$hideundo.start()

func _process(delta: float) -> void:
	position.y = lerp(position.y, get_owner().get_node("Character").position.y + 4.877,0.12)
	position.x = lerp(position.x, get_owner().get_node("Character").position.x , 0.12)

	var posx
	var posy
	posx = get_owner().get_node("TimerModel").position.x
	posy = get_owner().get_node("TimerModel").position.y
	posx = lerp(posx, position.x , 0.12)
	posy = lerp(posy, position.y - 5, 0.12)


	get_owner().get_node("TimerModel").position.x = posx
	get_owner().get_node("TimerModel").position.y = posy

	if !showUndo:
		$Undo.visible = false
		

func _on_waitbeforeswitching_timeout() -> void:
	canChange = true

func reset():
	$Undo.visible = true	
	$AnimationPlayer2.play("reset")
	
	await  $AnimationPlayer2.animation_finished
	$Undo.visible = false
	
func rollcredits():
	pass


func _on_hideundo_timeout() -> void:
	showUndo = true
