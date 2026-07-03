extends BaseStateManager
class_name TransporterStateManager

func _ready() -> void:
	states = {
		TransporterState.State.Idle: $Idle,
		TransporterState.State.Walking: $Walking,
		TransporterState.State.Jumping: $Jumping,
		TransporterState.State.Dead: $Dead,
	}

	initial_state = TransporterState.State.Idle
