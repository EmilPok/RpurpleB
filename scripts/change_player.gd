extends Node2D

@export var player_1 : CharacterBody2D
@export var player_2 : CharacterBody2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch"):
		player_1.active = not player_1.active
		player_2.active = not player_2.active
		
		var now_active = player_1
		
		if player_1.active:
			now_active = player_1
		else:
			now_active = player_2
		now_active.get_node("AnimationPlayer").seek(0.0)
		now_active.get_node("AnimationPlayer").play("now_me")
		
