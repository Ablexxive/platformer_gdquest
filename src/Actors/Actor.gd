# Shared script between player and enemies for movement.
extends KinematicBody2D
# 'class_name' allows it to be used in Player.gd
class_name Actor

# export makes gravity configurable in "Player" inspector
export var gravity: = 4000.0
export var move_speed: = Vector2(300.0, 1400.0)

var FLOOR_NORMAL: = Vector2.UP

var _velocity: Vector2 = Vector2.ZERO

#func _physics_process(delta: float) -> void:
	# Gravity acting on Actors
	#_velocity.y += gravity * delta
