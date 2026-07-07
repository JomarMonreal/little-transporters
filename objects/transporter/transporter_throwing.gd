extends TransporterState

@export var throw_force: Vector2 = Vector2(600.0, -400.0)

func enter() -> void:
	var transporter := entity as Transporter
	transporter.animation.play("throw")

	var ragdoll := transporter.ragdoll_to_carry
	if ragdoll == null:
		return

	var facing := transporter.sprite_group.scale.x
	var throw_velocity := Vector2(throw_force.x * facing, throw_force.y)

	ragdoll.reparent(transporter.get_parent())
	ragdoll.throw(throw_velocity)
	ragdoll.stop_ignoring_collisions_with(transporter)

	transporter.ragdoll_to_carry = null


func physics_process(_delta: float) -> int:
	return TransporterState.State.Idle
