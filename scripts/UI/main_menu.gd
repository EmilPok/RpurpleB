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
	
	for i in cables.size():
		if i < Global.levels_completed - 1:
			cables[i].set_connector()
			if i + 1 < levels.size():
				levels[i + 1].get_node("MostlyPurpleLevel").visible = true
	
	if Global.finished:
		$Transition_Animations.play("level_selector_on")
		await $Transition_Animations.animation_finished
		
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

# LEVEL 1 LOAD #####
func _on_button_pressed() -> void:
	Global.selected_level = 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# LEVEL 2 LOAD #####
func _on_button_2_pressed() -> void:
	Global.selected_level = 2
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# LEVEL 3 LOAD #####
func _on_button_3_pressed() -> void:
	Global.selected_level = 3
	get_tree().change_scene_to_file("res://scenes/main.tscn")
