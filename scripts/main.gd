extends Node2D

var levels_path = "res://scenes/levels/level_"
var scene_file = ".tscn"

@export var current_level : int
@export var levels_amount : int


var last_level : Node2D = null

var reset_position = Vector2(1000.0, 1000.0)

func _ready() -> void:
	randomize()
	
	#current_level -= 1
	current_level = Global.selected_level - 1
	_next_level()


func _next_level():
	current_level += 1
	$AnimationPlayer.play("circle")
	$Circle_trans_time.start()

func _on_circle_trans_time_timeout() -> void:
	if current_level == levels_amount:
		Global.levels_completed = max(Global.levels_completed, current_level)
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
	
	var level = levels_path + str(current_level) + scene_file
	
	if last_level:
		last_level.queue_free()
	
	$Character_1.global_position = reset_position
	$Character_2.global_position = reset_position
	
	var new_level = load(level).instantiate()
	new_level.global_position = Vector2.ZERO
	call_deferred("add_child", new_level)
	
	$Character_1.global_position = new_level.get_node("Character_1_pos").global_position
	$Character_2.global_position = new_level.get_node("Character_2_pos").global_position
	
	
	last_level = new_level
	$AnimationPlayer.play_backwards("circle")
	
	$Character_1._reset()
	$Character_1.Camera = new_level.get_node("Camera2D")
	$Character_1.Camera_orginal_pos = new_level.get_node("Camera2D").global_position
	$Change_Player._reset()

func _reset_level():
	$AnimationPlayer.play("circle")
	$Circle_trans_time.start()
