extends Node2D

@export var start_active = false

var active= false

var close_sign = preload("res://art/misc/Door/Close_sign.png")
var open_sign = preload("res://art/misc/Door/Opening_sign.png")

func _ready() -> void:
	if start_active:
		active = true
		$Sign.texture = open_sign
		$Collision/CollisionShape2D.position.y = -54.0
		$Sign.position.y = -48.0
		$Door.position.y = -42.0
		

func _active():
	if not active:
		$Anim.play("Open")
		$Sign.texture = open_sign
		active = true
	else:
		$Anim.play_backwards("Open")
		active = false

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if not active:
		$Sign.texture = close_sign
