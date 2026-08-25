extends Control

func _on_play_pressed() -> void:
	pass

func _on_options_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	$Transition_Animations.play("credits_on")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_button_pressed() -> void:
	if $HBoxContainer/Credits_Smooth_Movement_Handl.visible == true:
		$Transition_Animations.play("credits_off")
