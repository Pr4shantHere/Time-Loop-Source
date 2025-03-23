extends AudioStreamPlayer

const music = preload("res://audios/music3.mp3")
const cm = preload("res://audios/credit song.mp3")
var useGameMusic = true

func _play_music(music : AudioStream, volume = 0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	
	
func play_music_level():
	if useGameMusic:
		_play_music(music)
	else :
		_play_music(cm)
