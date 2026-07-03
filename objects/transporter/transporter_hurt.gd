extends TransporterState

@export var knockback_force = 400.0
@export var duration = 0.15

var timer := 0.0

func enter() -> void:
	var transporter := entity as Transporter
	timer = duration
	transporter.velocity = transporter.knockback_direction * knockback_force

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter

	if not transporter.is_on_floor():
		transporter.velocity += transporter.get_gravity() * transporter.movement.gravity_factor * delta
	transporter.move_and_slide()

	timer -= delta
	if timer <= 0.0:
		transporter.velocity = Vector2.ZERO
		return TransporterState.State.Dead

	return TransporterState.State.Hurt
