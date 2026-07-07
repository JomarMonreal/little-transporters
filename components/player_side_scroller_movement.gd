extends Node
class_name PlayerSideScrollerMovement

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var jump_cut_multiplier = 0.5
@export var gravity_factor = 2

func gravitate(player: CharacterBody2D, delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * gravity_factor * delta
	player.move_and_slide()

# Called when the node enters the scene tree for the first time.
func move(player: CharacterBody2D, delta: float, speed_multiplier: float = 1.0):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * gravity_factor * delta

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = jump_velocity
	elif Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y *= jump_cut_multiplier

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
