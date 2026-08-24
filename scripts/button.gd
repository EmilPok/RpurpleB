extends Area2D

@export var object: Node2D

func _iam_button():
	object._active()
	$Sprite2D.frame = 1
	$Time_pressed.start()


func _on_time_pressed_timeout() -> void:
	$Sprite2D.frame = 0
