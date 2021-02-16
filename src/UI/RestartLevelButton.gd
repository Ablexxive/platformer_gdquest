extends Button

func _on_button_up() -> void:
	PlayerData.score = 0 # TODO: maybe only reset for current level.
	PlayerData.respawn()
	get_tree().paused = false # unpause the game
	get_tree().reload_current_scene()
