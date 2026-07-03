extends Node
class_name Gameplay

@export var transporter_scene: PackedScene

@onready var states: GampeplayStateManager = $StateManager
@onready var camera: CameraFollow = $Camera2D
@onready var transporters_group: Node2D = $Transporters

func connect_transporter(transporter: Transporter) -> void:
	transporter.dead.connect(_on_transporter_dead)

func spawn_transporter() -> void:
	var instance = transporter_scene.instantiate() as Transporter
	connect_transporter(instance)
	transporters_group.add_child(instance)
	camera.target = instance

func _on_transporter_dead() -> void:
	spawn_transporter()

func _ready() -> void:
	states.init(self)
	for transporter in transporters_group.get_children():
		connect_transporter(transporter)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
