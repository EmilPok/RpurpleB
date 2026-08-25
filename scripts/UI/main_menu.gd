extends Control

func _on_play_pressed() -> void:
	$Transition_Animations.play("level_selector_on")

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	$Transition_Animations.play("credits_on")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	if $HBoxContainer/Credits_Smooth_Movement_Handl.visible == true:
		$Transition_Animations.play("credits_off")
	if $LevelSelector.visible == true:
		$Transition_Animations.play("level_selector_off")



# LEVEL 1 LOAD #####
func _on_button_pressed() -> void:
	Global.selected_level = 0
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# LEVEL 2 LOAD #####
func _on_button_2_pressed() -> void:
	Global.selected_level = 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
# LEVEL 3 LOAD #####
func _on_button_3_pressed() -> void:
	Global.selected_level = 2
	get_tree().change_scene_to_file("res://scenes/main.tscn")
