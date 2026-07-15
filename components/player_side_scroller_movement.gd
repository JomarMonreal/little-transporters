extends Node
class_name PlayerSideScrollerMovement

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var jump_cut_multiplier = 0.5
@export var gravity_factor = 2
@export var jump_buffer_time = 0.15
@export var coyote_time = 0.15

@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var coyete_jump_timer: Timer = $CoyeteJumpTimer
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio

func _ready() -> void:
	jump_buffer_timer.wait_time = jump_buffer_time
	jump_buffer_timer.one_shot = true
	coyete_jump_timer.wait_time = coyote_time
	coyete_jump_timer.one_shot = true

func gravitate(player: CharacterBody2D, delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * gravity_factor * delta
	player.move_and_slide()

# Called when the node enters the scene tree for the first time.
func move(player: CharacterBody2D, delta: float, speed_multiplier: float = 1.0):
	var was_on_floor := player.is_on_floor()

	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * gravity_factor * delta

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
	elif Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= jump_cut_multiplier

	var jumped := false
	var can_jump := player.is_on_floor() or not coyete_jump_timer.is_stopped()
	if not jump_buffer_timer.is_stopped() and can_jump:
		player.velocity.y = jump_velocity
		jump_buffer_timer.stop()
		coyete_jump_timer.stop()
		jumped = true
		if jump_audio.stream:
			jump_audio.play()

	# Get the input direction and handle the movement/deceleration.
	var direction := 0.0
	if Input.is_action_pressed("ui_left") or Input.is_physical_key_pressed(KEY_A):
		direction -= 1.0
	if Input.is_action_pressed("ui_right") or Input.is_physical_key_pressed(KEY_D):
		direction += 1.0

	if direction:
		player.velocity.x = direction * speed * speed_multiplier
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed * speed_multiplier)

	player.move_and_slide()

	if was_on_floor and not player.is_on_floor() and not jumped:
		coyete_jump_timer.start()
