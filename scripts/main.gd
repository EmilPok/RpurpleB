extends Node2D

var levels_path = "res://scenes/levels/level_"
var scene_file = ".tscn"

@export var Amount_of_levels : int

var last_level : Node2D = null
var reset_position = Vector2(1000.0, 1000.0)

var shot_bullets = []

var playing_anim = false
var active_button = true

func _process(_delta: float) -> void:
	if playing_anim and Engine.time_scale != 1.0:
		Engine.time_scale = 1.0

func _ready() -> void:

	
	randomize()
	_reset_level()
	$Circle_trans/Black_screen.show()

func _reset_level():
	active_button = false
	$Character_1.active = false
	$Character_2.active = false

	if playing_anim:
		playing_anim = false
	
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
	
	
	$Character_1.global_position = new_level.get_node("Character_1_pos").global_position
	$Character_2.global_position = new_level.get_node("Character_2_pos").global_position
	
	call_deferred("add_child", new_level)
	
	last_level = new_level
	$AnimationPlayer.play_backwards("circle")
	
	$Character_1._reset()
	$Character_1.Camera = new_level.get_node("Camera2D")
	$Character_1.Camera_orginal_pos = new_level.get_node("Camera2D").global_position
	$Change_Player._reset()
	
	$Move_allow.start()
	

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
	active_button = false
	playing_anim = true
	$AnimationPlayer.play("circle")
	$Character_1.active = false
	$Character_2.active = false
	await $AnimationPlayer.animation_finished
	_reset_level()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		_died()

func _on_move_allow_timeout() -> void:
	$Character_1.active = true
	$Character_2.active = false
	active_button = true
