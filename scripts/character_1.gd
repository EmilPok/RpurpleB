extends CharacterBody2D

var SPEED = 90.0

var single_jump = -260.0
var hold_jump = -15.0

var speed_falling = 2.0

var acceleration_walk = 1200.0
var acceleration_air = 600.0

var can_jump = true
var during_jump = false
var did_coyote = false

var faster_jump = false

var active = true

@onready var Gun = $Rotation_point
@onready var Gun_sprite = $Rotation_point/Gun
@onready var Gun_pivot = $Rotation_point/Pivot
@onready var icon = $Icon

var bullet = preload("res://scenes/bullet.tscn")

var can_shoot = true

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if not can_jump:
			can_jump = true
		if did_coyote:
			did_coyote = false
	
	if not is_on_floor() and $Coyote_time.is_stopped() and not did_coyote:
		did_coyote = true
		$Coyote_time.start()

	if not is_on_floor():
		if velocity.y >= 200.0:
			velocity += get_gravity() * delta * speed_falling
		else:
			velocity += get_gravity() * delta
	
	if not active:
		_standing(delta)
		move_and_slide()
		return
	
	Gun.look_at(get_global_mouse_position())
	var mouse_left := get_global_mouse_position().x < global_position.x
	icon.flip_h = mouse_left
	Gun_sprite.flip_v = mouse_left 
	
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		can_shoot = false
		$Shoot_cooldown.start()
		
		var new_bullet = bullet.instantiate()
		new_bullet.rotation_offset = Gun.rotation
		new_bullet.global_position = Gun_pivot.global_position
		add_sibling(new_bullet)
		

	if Input.is_action_just_pressed("jump") and not is_on_floor():
		faster_jump = true
		$Faster_jump.start()
	
	if faster_jump and is_on_floor():
		_jump()
	
	if Input.is_action_just_pressed("jump") and can_jump:
		_jump()
	
	if Input.is_action_pressed("jump") and during_jump and velocity.y <= 0:
		velocity.y += hold_jump
	else:
		during_jump = false

	var direction := Input.get_axis("left", "right")
	if direction:
		if abs(velocity.x) <= SPEED + (SPEED / 1.5):
			velocity.x = move_toward(velocity.x, SPEED * direction, acceleration_walk * delta)
		else:
			_standing(delta)
	else:
		_standing(delta)
	
	
	
	move_and_slide()

func _standing(delta):
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, acceleration_walk * delta)
	else:
		if abs(velocity.x) <= SPEED + (SPEED / 1.5):
			velocity.x = move_toward(velocity.x, 0, acceleration_walk * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, acceleration_air * delta)

func _jump():
	during_jump = true
	velocity.y += single_jump
	can_jump = false

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true
	

func _on_coyote_time_timeout() -> void:
	can_jump = false


func _on_faster_jump_timeout() -> void:
	faster_jump = false
