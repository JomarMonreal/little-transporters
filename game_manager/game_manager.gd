extends Node
class_name GameManager

@onready var states: GameManagerStateManager = $StateMachine

func _ready() -> void:
	states.init(self)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _on_main_menu_played() -> void:
	states.change_state(GameManagerState.State.Level)


func _on_gameplay_exiting() -> void:
	states.change_state(GameManagerState.State.MainMenu)
