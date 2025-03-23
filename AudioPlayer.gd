extends AudioStreamPlayer

const music = preload("res://audios/music3.mp3")

func _play_music(music : AudioStream, volume = 0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
	
func play_music_level():
	_play_music(music)
