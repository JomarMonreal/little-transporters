extends Node
class_name Gameplay

@export var transporter_scene: PackedScene
@export var inital_spawn: Node2D

@onready var states: GampeplayStateManager = $StateManager
@onready var camera: CameraFollow = $Camera2D
@onready var transporters_group: Node2D = $Transporters

var spawn_position: Vector2 = Vector2.ZERO

func connect_transporter(transporter: Transporter) -> void:
	transporter.dead.connect(_on_transporter_dead)

func spawn_transporter() -> void:
	var instance = transporter_scene.instantiate() as Transporter
	connect_transporter(instance)
	transporters_group.add_child(instance)
	instance.global_position = spawn_position
	camera.target = instance

func _on_transporter_dead() -> void:
	spawn_transporter()

func _ready() -> void:
	spawn_position = inital_spawn.global_position
	states.init(self)
	for transporter in transporters_group.get_children():
		connect_transporter(transporter)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
