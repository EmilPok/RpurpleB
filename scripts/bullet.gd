extends Area2D

var SPEED = 1000.0
var rotation_offset = 0.0

func _ready() -> void:
	rotation = rotation_offset
	
	

func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(rotation_offset) * SPEED * delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player_2"):
		body._knockback(Vector2.RIGHT.rotated(rotation_offset) * SPEED)
	
	queue_free()
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("_iam_button"):
		area._iam_button()
	
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
