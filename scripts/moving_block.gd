extends Node2D

var active = false

func _active():
	if not active:
		$Moving_block/AnimationPlayer.play("Move")
	else:
		$Moving_block/AnimationPlayer.play("Back_Move")
	active = not active
