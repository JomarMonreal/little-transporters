extends Node
class_name PlayerSideScrollerMovement

@export var speed = 300.0
@export var jump_velocity = -400.0
@export var gravity_factor = 2

# Called when the node enters the scene tree for the first time.
func move(player: CharacterBody2D, delta: float):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * gravity_factor * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

	player.move_and_slide()
