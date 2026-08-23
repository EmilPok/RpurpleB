extends Node2D

var active = false

func _active():
	if not active:
		$AnimationPlayer.play("Move")
	else:
		$AnimationPlayer.play("Back_Move")
	active = not active
