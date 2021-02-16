extends Control

onready var scene_tree: = get_tree()

# So we could acces these in the actual function but doing it up here makes
# it easier to open this file and know what sorts of things this script is handling.
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score_label: Label = get_node("Label")
onready var pause_overlay_title_label: Label = get_node("PauseOverlay/Title")

# Manage pause state of the game
var paused: = false setget set_paused

func _ready() -> void:
	# These hook up the singals coming from PlayerData to functions within
	# this script. So now everytime score is updated in PlayerData and a 
	# 'score_updated' signal is sent, this nodes `update_interface` fcn will be
	# called.
	# If you were accessing other classes before they are loaded, you could get
	# an error here, but because PlayerData is autoloaded you can be sure it is there.
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	
	# Ensure that the Player UI still shows but the pause overlay is not visible
	# Doing this here means that the PlayerUI can be hidden or shown during
	# level design without the programmer worrying about hiding/showing it.
	self.visible = true
	pause_overlay.visible = false
	update_interface()
	
func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_overlay_title_label.text = "~~~~ You died :X ~~~~"


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !PlayerData.is_dead:
		self.paused = !paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score_label.text = "Score: %s" % PlayerData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
