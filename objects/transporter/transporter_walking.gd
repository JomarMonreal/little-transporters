extends TransporterState

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	transporter.movement.move(transporter, delta)
	return TransporterState.State.Walking
