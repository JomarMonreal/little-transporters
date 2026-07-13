extends TransporterState

func enter() -> void:
	var transporter := entity as Transporter
	transporter.animation.play("finished")
	transporter.velocity = Vector2.ZERO
	transporter.sprite_group.scale.x = -1

	var gameplay = get_tree().get_first_node_in_group("gameplay") as Gameplay
	gameplay.record_finish_time()

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter

	if not transporter.is_on_floor():
		transporter.velocity += transporter.get_gravity() * transporter.movement.gravity_factor * delta
	transporter.move_and_slide()

	return TransporterState.State.Finished
