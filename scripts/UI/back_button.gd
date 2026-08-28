extends TextureButton
@onready var main = get_parent().get_parent()

func _on_texture_button_pressed() -> void:
	modulate = Color.WHITE
	main._back()
	
func _on_texture_button_button_down() -> void:
	modulate = Color(0.4, 0.4, 0.4, 1.0)
	
func _on_mouse_entered() -> void:
	modulate = Color(0.6, 0.6, 0.6, 1.0)


func _on_mouse_exited() -> void:
	modulate = Color.WHITE
