extends MeshInstance3D

var stream = preload("res://audios/credit song.mp3")

func _ready() -> void:
	stream = load("res://audios/credit song.mp3")

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
		AudioPlayer.useGameMusic = false
	else:
		$"../Credits".visible = false
		AudioPlayer.useGameMusic = true
		
