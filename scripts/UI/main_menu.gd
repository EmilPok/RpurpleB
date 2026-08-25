extends Control

func _ready() -> void:
	
	var cables = [
		$LevelSelector/Level1/LevelConnector,
		$LevelSelector/Level2/LevelConnector,
		$LevelSelector/Level3/LevelConnector
	]
	var levels = [
		$LevelSelector/Level1,
		$LevelSelector/Level2,
		$LevelSelector/Level3
	]
	
	var last_cable = 1
	
	if Global.levels_completed <= Global.last_levels_completed:
		last_cable = 0

	for i in cables.size():
		if i < Global.levels_completed - last_cable:
			cables[i].set_connector()
			if i + 1 < levels.size():
				levels[i + 1].get_node("MostlyPurpleLevel").visible = true
	
	if Global.finished:
		$Transition_Background_2.show()
		
		$AnimationPlayer.play("level_selector_half")
		
		await $AnimationPlayer.animation_finished
		
		if Global.levels_completed > Global.last_levels_completed:
			Global.last_levels_completed = Global.levels_completed
			var i = Global.levels_completed - 1
			cables[i].connect_levels()
			await cables[i].get_node("AnimationPlayer").animation_finished
			if i + 1 < levels.size():
				levels[i + 1].get_node("MostlyPurpleLevel").visible = true
	
	Global.finished = false

func _on_play_pressed() -> void:
	$Transition_Animations.play("level_selector_on")

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	$Transition_Animations.play("credits_on")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	if $HBoxContainer/Credits_Smooth_Movement_Handl.visible:
		$Transition_Animations.play("credits_off")
	if $LevelSelector.visible:
		$Transition_Animations.play("level_selector_off")

func _start_transition(num):
	if Global.levels_completed < num - 1:
		return
	
	Global.selected_level = num
	
	$AnimationPlayer.play("circle")
	$Circle_trans_time.start()

func _on_circle_trans_time_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# LEVEL 1 LOAD #####
func _on_button_pressed() -> void:
	_start_transition(1)

# LEVEL 2 LOAD #####
func _on_button_2_pressed() -> void:
	_start_transition(2)

# LEVEL 3 LOAD #####
func _on_button_3_pressed() -> void:
	_start_transition(3)
