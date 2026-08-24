extends Node2D

@export var end_point_pos : Vector2
@onready var Icon = $Moving_block/Icon

var active = false

func _ready() -> void:
	pass

func _active():
	var tween = create_tween()
	
	if not active:
		tween.tween_property($Moving_block, "position", end_point_pos, 0.8).set_trans(Tween.TRANS_CUBIC)
		Icon.flip_v = false
		Icon.play("Anim")
		$Stop_anim.start()
	else:
		Icon.flip_v = true
		tween.tween_property($Moving_block, "position", Vector2.ZERO, 0.8).set_trans(Tween.TRANS_CUBIC)
		Icon.play("Anim")
		$Stop_anim.start()
	active = not active


func _on_stop_anim_timeout() -> void:
	Icon.play("Idle")
