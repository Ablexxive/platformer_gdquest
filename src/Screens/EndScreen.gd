extends Control

# or get_node("Label")
onready var label: Label = $Label

func _ready() -> void:
	label.text = label.text % [PlayerData.score, PlayerData.deaths]
