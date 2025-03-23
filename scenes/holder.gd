extends MeshInstance3D

var stream = load("res://audios/credit song.mp3")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Global.red:
		$Red2.visible = true
	if Global.blue:
		$Blue2.visible = true
	if Global.orange:
		$Orange2.visible = true
	if Global.diamond:
		$Diamond2.visible = true

	if Global.red && Global.blue && Global.orange && Global.diamond:
		$"../Credits".visible = true
		AudioPlayer.stream = stream
	else:
		$"../Credits".visible = false
		
