extends "res://src/Actors/Actor.gd"

# Enemies score value
export var score: = 100

# `_ready` is called on all nodes at start, deepest first
func _ready() -> void:
	# If you uncomment below, and set `Process Parent` and `Physics Process P` to `On`
	# on the `VisibiltyEnabler2D` node of enemy, then it will stop moving if it goes off screen.
	set_physics_process(false)
	_velocity.x = -move_speed.x 

# Event Callbacks
func _on_StompDetector_body_entered(body: Node) -> void:
	# Kill enemy when this function is called.
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	# Prevent enemy from doing damage to player while the enemy is being deleted
	get_node("CollisionShape2D").disabled = true
	print("Stomp detected")
	die()
	

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	# Move at constant speed and change direction when hits a wall
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	print("Killing enemy.")
	queue_free()
	PlayerData.score += score
