tool
extends Button

export(String, FILE) var next_scene_path: = ""


func _on_button_up() -> void:
	#get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")
	# TODO create a restart method to reset score and unpause
	#PlayerData.score = 0
	#PlayerData.deaths = 0
	PlayerData.reset()
	get_tree().paused = false
	get_tree().change_scene(next_scene_path)

func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
