extends Node
class_name GameManager

@onready var states: GameManagerStateManager = $StateMachine
@onready var main_music: AudioStreamPlayer2D = $Chinoris
@onready var audio_listener: AudioListener2D = $AudioListener2D

func _ready() -> void:
	main_music.play()
	states.init(self)
	audio_listener.make_current()
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _on_main_menu_played() -> void:
	states.change_state(GameManagerState.State.Cutscene)
	main_music.stop()


func _on_gameplay_exiting() -> void:
	states.change_state(GameManagerState.State.MainMenu)
	audio_listener.make_current()
	main_music.play()


func _on_cutscene_finished() -> void:
	if Globals.current_cutscene == "black":
		states.change_state(GameManagerState.State.MainMenu)
		Globals.current_cutscene = "chapter1"
		audio_listener.make_current()
		main_music.play()
	else:
		states.change_state(GameManagerState.State.Level)
		main_music.stop()


func _on_gameplay_finished() -> void:
	Globals.current_cutscene = "black"
	states.change_state(GameManagerState.State.Cutscene)
	main_music.stop()
	pass # Replace with function body.
