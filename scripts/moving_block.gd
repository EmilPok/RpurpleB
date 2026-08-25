extends Node2D

@export var end_point_pos : Vector2
@export var flipped = false
@onready var Icon = $Moving_block/Icon

var active = false


func _ready() -> void:
	if flipped:
		Icon.flip_v = false
		$Moving_block/Collision.position.y -= 1.0

func _active():
	var tween = create_tween()
	
	if not active:
		tween.tween_property($Moving_block, "position", end_point_pos, 0.8).set_trans(Tween.TRANS_CUBIC)
		Icon.flip_v = not Icon.flip_v 
		Icon.play("Anim")
		$Stop_anim.start()
	else:
		Icon.flip_v = not Icon.flip_v 
		tween.tween_property($Moving_block, "position", Vector2.ZERO, 0.8).set_trans(Tween.TRANS_CUBIC)
		Icon.play("Anim")
		$Stop_anim.start()
		
	if Icon.flip_v == true:
		$Moving_block/Collision.position.y += 1.0
	else:
		$Moving_block/Collision.position.y -= 1.0
	
	active = not active


func _on_stop_anim_timeout() -> void:
	Icon.play("Idle")
