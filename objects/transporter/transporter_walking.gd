extends TransporterState

@export var run_multiplier := 2.0

func enter() -> void:
	var transporter := entity as Transporter
	if transporter.ragdoll_to_carry != null:
		transporter.animation.play("carry_walk")
	else:
		transporter.animation.play("walk")

func exit() -> void:
	var transporter := entity as Transporter
	transporter.animation.speed_scale = 1.0

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	var running := Input.is_physical_key_pressed(KEY_SHIFT)
	
	transporter.animation.speed_scale = run_multiplier if running else 1.0
	transporter.movement.move(transporter, delta, run_multiplier if running else 1.0)

	if Input.is_action_just_pressed("interact"):
		if transporter.ragdoll_to_carry == null and transporter.possible_ragdoll:
			return TransporterState.State.Carrying
		elif transporter.ragdoll_to_carry != null:
			return TransporterState.State.Throwing
		

	if transporter.velocity.x < 0:
		transporter.sprite_group.scale.x = -1
	elif transporter.velocity.x > 0:
		transporter.sprite_group.scale.x = 1
	if transporter.velocity.x == 0:
		return TransporterState.State.Idle
		
	return TransporterState.State.Walking
