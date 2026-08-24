extends Area2D

@export var is_blue = true
@export var is_red = true

var blue_button = preload("res://art/misc/Buttons/button_blue.png")
var red_button = preload("res://art/misc/Buttons/button_red.png")

@export var object: Node2D

func _ready() -> void:
	if not (is_blue and is_red):
		if is_blue:
			$Sprite.texture = blue_button
			set_collision_layer_value(6, false)
			set_collision_mask_value(4, false)
		else:
			$Sprite.texture = red_button
			set_collision_mask_value(5, false)
	

func _iam_button():
	object._active()
	$Sprite.frame = 1
	$Time_pressed.start()

func _on_time_pressed_timeout() -> void:
	$Sprite.frame = 0


func _on_body_entered(_body: Node2D) -> void:
	_iam_button()
