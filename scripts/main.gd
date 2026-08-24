extends Node2D

var levels = ["res://scenes/levels/level_0.tscn"]
var current_level = 0

var last_level : Node2D = null

var reset_position = Vector2(1000.0, 1000.0)

func _ready() -> void:
	_next_level()


func _next_level():
	$AnimationPlayer.play("circle")
	$Circle_trans_time.start()

func _on_circle_trans_time_timeout() -> void:
	if last_level:
		last_level.queue_free()
	
	$Character_1.global_position = reset_position
	$Character_2.global_position = reset_position
	
	var new_level = load(levels[0]).instantiate()
	new_level.global_position = Vector2.ZERO
	call_deferred("add_child", new_level)
	
	$Character_1.global_position = new_level.get_node("Character_1_pos").global_position
	$Character_2.global_position = new_level.get_node("Character_2_pos").global_position
	
	
	last_level = new_level
	current_level += 1
	$AnimationPlayer.play_backwards("circle")
	
	
