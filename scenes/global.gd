extends Node3D

const music = preload("res://audios/music3.mp3")

func _play_music(music : AudioStream, volume = 0):
	pass#if $AudioStreamPlayer3D.stream == music:
		#return
	#
	#$AudioStreamPlayer3D.stream = music
	#$AudioStreamPlayer3D.volume_db = volume
	#$AudioStreamPlayer3D.play()
	
	
func play_music_level():
	_play_music(music)
