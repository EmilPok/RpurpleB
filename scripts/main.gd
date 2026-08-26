extends Node2D

var levels_path = "res://scenes/levels/level_"
var scene_file = ".tscn"

@export var Amount_of_levels : int

var last_level : Node2D = null
var reset_position = Vector2(1000.0, 1000.0)

var shot_bullets = []

func _ready() -> void:
	randomize()
	_reset_level()
	$Circle_trans/Black_screen.show()

func _reset_level():
	Engine.time_scale = 1.0
	for i in shot_bullets:
		if i:
			i.queue_free()
	shot_bullets.clear()
	
	$AnimationPlayer.play_backwards("circle")
	var level = levels_path + str(Global.selected_level) + scene_file
	
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

func _level_completed():
	Engine.time_scale = 1.0
	$Character_1.active = false
	$Character_2.active = false
	
	if Global.selected_level > Global.levels_completed:
		Global.levels_completed = Global.selected_level
	Global.finished = true
	
	$AnimationPlayer.play("End_transition")
	
	await $AnimationPlayer.animation_finished
	
	get_tree().call_deferred("change_scene_to_file", "res://scenes/UI/main_menu.tscn")

func _died():
	$AnimationPlayer.play("circle")
	await $AnimationPlayer.animation_finished
	_reset_level()
	
	
	
