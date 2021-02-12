extends Node

# Script to manage state. Any other script in the project will be able to access
# this node.

# Allows scripts to react to changes in this script.
signal score_updated
signal player_died

# `setget fn1, fn2` fn1 - setter, fn2 - getter
var score: = 0 setget set_score
var deaths: = 0

func reset() -> void:
	score = 0
	deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")


func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
