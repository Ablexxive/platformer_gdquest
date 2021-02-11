tool
# Tool keyword lets code in this script to run in the editor. Used to get this warning to display.
extends Area2D

# $NAME - is shortcut for get_noded("NAME")
onready var anim_player: AnimationPlayer = $AnimationPlayer

# Using a path to load later instead of a PackedScene here because
# PackedScean results in a circular load on start. (Level 1 loads Level 2 loads Level 1)
#export var next_scene: PackedScene
export var next_scene_path: String
export var test_int: = 10

func _on_body_entered(body: Node) -> void:
	teleport()


func _get_configuration_warning() -> String:
	#return "The `next_scene` property is empty!" if not next_scene else ""
	return "The `next_scene_path` property is empty!" if not next_scene_path else ""

func teleport() -> void:
	anim_player.play("fade_in")
	# yield waits for the node to send a signal
	yield(anim_player, "animation_finished")
	# SceneTree stores entire scene tree. `get_tree` gets current one.
	var next_scene = load(next_scene_path)
	get_tree().change_scene_to(next_scene)
