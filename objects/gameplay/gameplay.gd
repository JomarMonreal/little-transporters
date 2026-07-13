extends Node
class_name Gameplay

@export var transporter_scene: PackedScene
@export var success_screen: PackedScene
@export var inital_spawn: Node2D
@export var final_object: Node2D

@onready var states: GampeplayStateManager = $StateManager
@onready var camera: CameraFollow = $Camera2D
@onready var transporters_group: Node2D = $Transporters
@onready var ruler: Node2D = $Ruler
@onready var pause_overlay: ColorRect = $CanvasLayer/Control/Overlay
@onready var control_ui: Control = $CanvasLayer/Control

var transporters_died: Array[String] = []
var spawn_position: Vector2 = Vector2.ZERO
var initial_ruler_transform: Transform2D
var paused = false
var start_time_msec: int = 0
var end_time_msec: int = 0

signal exiting

func pause(enabled: bool) -> void:
	pause_overlay.visible = enabled
	paused = enabled
	

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

func restart() -> void:
	spawn_position = inital_spawn.global_position
	ruler.transform = initial_ruler_transform
	transporters_died.clear()
	start_time_msec = Time.get_ticks_msec()
	for child in transporters_group.get_children():
		child.queue_free()
	spawn_transporter()
	pause(false)

func record_finish_time() -> void:
	end_time_msec = Time.get_ticks_msec()

func _ready() -> void:
	spawn_position = inital_spawn.global_position
	initial_ruler_transform = ruler.transform
	start_time_msec = Time.get_ticks_msec()

	states.init(self)
	for transporter in transporters_group.get_children():
		connect_transporter(transporter)
	
func _process(delta: float) -> void:
	states.process(delta)
	if Input.is_action_just_pressed("ui_cancel"):
		pause(not paused)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)


func _on_texture_button_button_up() -> void:
	pause(true)


func _on_button_button_up() -> void:
	pause(false)
	


func _on_button_3_button_up() -> void:
	restart()


func _on_character_body_2d_finished() -> void:
	camera.target = final_object


func _on_button_2_button_up() -> void:
	exiting.emit()
	pass # Replace with function body.


func _on_fade_overlay_continued() -> void:
	exiting.emit()


func _on_pen_finished() -> void:
	var instance = success_screen.instantiate() as SuccessScreen
	instance.continued.connect(_on_fade_overlay_continued)
	instance.elapsed_time = (end_time_msec - start_time_msec) / 1000.0
	instance.body_count = transporters_died.size()
	control_ui.add_child(instance)
