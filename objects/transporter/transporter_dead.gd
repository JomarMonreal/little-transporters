extends TransporterState

func enter() -> void:
	var transporter := entity as Transporter
	transporter.velocity = Vector2.ZERO
	transporter.collider.visible = false
	transporter.dead.emit()
	transporter.sprite_group.queue_free()
	var instance = transporter.ragdoll.instantiate() as Node2D
	instance.global_position = transporter.global_position
	get_tree().get_first_node_in_group("transporter_group").add_child(instance)
	transporter.queue_free()

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	transporter.movement.gravitate(transporter, delta)
	return TransporterState.State.Dead
