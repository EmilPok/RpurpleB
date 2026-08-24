extends Area2D

@export var is_red : bool

@export var other_button : Area2D

var active = false
@onready var main = get_tree().current_scene
var blue_button = preload("res://art/misc/Buttons/button_blue.png")

func _ready() -> void:
	if not is_red:
		$Sprite.texture = blue_button
		set_collision_mask_value(5, true)
	else:
		set_collision_mask_value(4, true)

func _on_body_entered(_body: Node2D) -> void:
	$Sprite.frame = 1
	if other_button.active:
		main._next_level()
	active = true

func _on_body_exited(_body: Node2D) -> void:
	$Sprite.frame = 0
	active = false
