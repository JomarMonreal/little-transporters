extends GameManagerState

@onready var gameplay: Gameplay = $Gameplay

func enter() -> void:
	gameplay.restart()
	gameplay.audio_listener.make_current()
	toggle_state_visibility(self, true) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> int:
	return GameManagerState.State.Level
