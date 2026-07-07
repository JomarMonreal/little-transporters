extends TransporterState

func enter() -> void:
	var transporter := entity as Transporter
	transporter.animation.play("carry")
	transporter.ragdoll_to_carry = transporter.possible_ragdoll
	transporter.possible_ragdoll = null
	transporter.ragdoll_to_carry.ignore_collisions_with(transporter)

	transporter.ragdoll_to_carry.set_carrying(true)
	transporter.carry_timer.start()


func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	if not transporter.is_on_floor():
		transporter.velocity += transporter.get_gravity() * transporter.movement.gravity_factor * delta
	transporter.move_and_slide()
	return TransporterState.State.Carrying
