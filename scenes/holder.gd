extends MeshInstance3D


func _process(delta: float) -> void:
	if Global.red:
		$Red2.visible = true
	if Global.blue:
		$Blue2.visible = true
	if Global.orange:
		$Orange2.visible = true
	if Global.diamond:
		$Diamond2.visible = true
