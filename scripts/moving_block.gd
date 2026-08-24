extends Node2D

@export var end_point_pos : Vector2

var active = false

func _ready() -> void:
	pass


func _active():
	var tween = create_tween()
	
	if not active:
		tween.tween_property($Moving_block, "position", end_point_pos, 0.8).set_trans(Tween.TRANS_CUBIC)
	else:
		tween.tween_property($Moving_block, "position", Vector2.ZERO, 0.8).set_trans(Tween.TRANS_CUBIC)
	active = not active
