extends TransporterState

func enter() -> void:
	var transporter := entity as Transporter
	transporter.velocity = Vector2.ZERO
	transporter.dead.emit()

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	transporter.movement.gravitate(transporter, delta)
	return TransporterState.State.Dead
