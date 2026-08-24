extends Sprite2D

var normal_texture = preload("res://art/misc/gun_crosshair.png")
var shoot_texture = preload("res://art/misc/shoot_crosshair.png")

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
		
		

func _shoot():
	$AnimationPlayer.play("Shoot")
	
