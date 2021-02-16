extends Actor

export var stomp_impulse: = 1300.0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	# Bounce on enemy
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	# Kill player
	die()


func _physics_process(delta: float) -> void:
	# used to make jump responsive to button hold time
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, move_speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)
	
func calculate_move_velocity(
	current_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	var new_velocity: = current_velocity
	new_velocity.x = speed.x * direction.x
	# get_p_p_d_t is the same delta as the one in `_physics_process`
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	# if jump is let go, make char start falling
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func calculate_stomp_velocity(current_velocity: Vector2, impulse: float) -> Vector2:
	var new_velocity: = current_velocity
	new_velocity.y = -impulse
	return new_velocity

func die() -> void:
	print("incrementing palyer deaths")
	PlayerData.deaths += 1
	queue_free()
