extends AudioStreamPlayer

const music = preload("res://audios/music3.mp3")
const cm = preload("res://audios/credit song.mp3")
var useGameMusic = true
var vol : int = 0
func _play_music(music : AudioStream, volume = 0):
	if stream == music:
		return
	stream = music
	play()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("UP"):
		vol += 1
	elif Input.is_action_just_pressed("DOWN"):
		vol -= 1
	volume_db = vol
	
func play_music_level():
	if useGameMusic:
		_play_music(music)
	else :
		_play_music(cm)
