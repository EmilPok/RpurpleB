extends Node2D

var open = false

var close_sign = preload("res://art/misc/Door/Close_sign.png")
var open_sign = preload("res://art/misc/Door/Opening_sign.png")

func _active():
	if not open:
		$Anim.play("Open")
		$Sign.texture = open_sign
		open = true
	else:
		$Anim.play_backwards("Open")
		open = false

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if not open:
		$Sign.texture = close_sign
