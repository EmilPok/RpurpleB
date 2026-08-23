extends Node2D

@export var player_1 : CharacterBody2D
@export var player_2 : CharacterBody2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch"):

		
		player_1.active = not player_1.active
		player_2.active = not player_2.active
		
		
