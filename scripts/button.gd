extends Area2D

@export var is_blue = true
@export var is_red = true

var blue_button = preload("res://art/misc/Buttons/button_blue.png")
var red_button = preload("res://art/misc/Buttons/button_red.png")

@export var object: Node2D

var can_press = true

var touching_characters = []

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
	if not can_press:
		return
	
	object._active()
	$Sprite.frame = 1
	
	can_press = false
	
	if touching_characters.is_empty():
		$Time_pressed.start()

func _on_time_pressed_timeout() -> void:
	$Sprite.frame = 0
	can_press = true
func _on_body_exited(body: Node2D) -> void:
	touching_characters.remove_at(touching_characters.find(body))
	
	if touching_characters.is_empty():
		$Time_pressed.start()

func _on_body_entered(body: Node2D) -> void:
	touching_characters.append(body)
	_iam_button()
	
