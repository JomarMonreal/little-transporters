extends BaseStateManager
class_name GampeplayStateManager

func _ready() -> void:
	states = {
		GameplayState.State.Playing: $Playing,
	}

	initial_state = GameplayState.State.Playing
