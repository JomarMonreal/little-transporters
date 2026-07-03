extends CharacterBody2D
class_name Transporter

@onready var states: TransporterStateManager = $StateManager
@onready var movement: PlayerSideScrollerMovement = $PlayerMovement

func _ready() -> void:
	states.init(self)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
