extends TransporterState

func enter() -> void:
	var transporter := entity as Transporter
	if transporter.ragdoll_to_carry != null:
		transporter.animation.play("carry_idle")
	else:
		transporter.animation.play("idle")

	


func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	transporter.movement.move(transporter, delta)
	
	if Input.is_action_just_pressed("interact"):
		if transporter.ragdoll_to_carry == null and transporter.possible_ragdoll:
			return TransporterState.State.Carrying
		elif transporter.ragdoll_to_carry != null:
			return TransporterState.State.Throwing
			
	
	if transporter.velocity.x != 0:
		return TransporterState.State.Walking
	
	return TransporterState.State.Idle
