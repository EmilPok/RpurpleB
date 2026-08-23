extends CharacterBody2D

var SPEED = 600.0

var single_jump = -800.0
var hold_jump = -15.0

var speed_falling = 2.0

var dash_velocity = 1000.0
var dash_vertical_velocity = 600.0
var during_dash = false
var can_dash = true
var wait_can_dash = false

var acceleration_walk = 15000.0
var acceleration_air = 1000.0

var active = false

var can_jump = true
var during_jump = false
var did_coyote = false

var faster_jump = false

func player_2():
	pass

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		if not can_jump:
			can_jump = true
		if wait_can_dash:
			can_dash = true
			wait_can_dash = false
		if did_coyote:
			did_coyote = false
	
	
	if not is_on_floor() and $Coyote_time.is_stopped() and not did_coyote:
		did_coyote = true
		$Coyote_time.start()

	if not is_on_floor() and not during_dash:
		if velocity.y >= 200.0:
			velocity += get_gravity() * delta * speed_falling
		else:
			velocity += get_gravity() * delta
	
	
	if not active:
		if not during_dash:
			_standing(delta)
		move_and_slide()
		return
	
	
	if Input.is_action_just_pressed("jump") and not is_on_floor():
		faster_jump = true
		$Faster_jump.start()
	
	if faster_jump and is_on_floor():
		_jump()
	
	if Input.is_action_just_pressed("jump") and can_jump and not during_dash:
		_jump()
	
	if Input.is_action_pressed("jump") and during_jump and velocity.y <= 0 and not during_dash:
		velocity.y += hold_jump
	else:
		during_jump = false
	
	var direction := Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("dash") and (direction or Input.is_action_pressed("up")) and can_dash:
		during_dash = true
		can_dash = false
		if direction:
			velocity.x = dash_velocity * direction
			velocity.y = 0.0
		else:
			velocity.x = 0
			velocity.y = -dash_vertical_velocity
		$Dash_dur.start()
		$Dash_cooldown.start()
	
	elif not during_dash:
	
		if direction:
			if abs(velocity.x) <= SPEED + (SPEED / 1.5):
				
				velocity.x = move_toward(velocity.x, SPEED * direction, acceleration_walk * delta)
			else:
				_standing(delta)
		else:
			_standing(delta)
	
	move_and_slide()

func _jump():
	during_jump = true
	velocity.y += single_jump
	can_jump = false

func _standing(delta):
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, acceleration_walk * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration_air * delta)


func _knockback(knock_value):
	knock_value *= 1.2
	velocity += knock_value


func _on_dash_dur_timeout() -> void:
	during_dash = false

func _on_dash_cooldown_timeout() -> void:
	wait_can_dash = true


func _on_coyote_time_timeout() -> void:
	can_jump = false

func _on_faster_jump_timeout() -> void:
	faster_jump = false
