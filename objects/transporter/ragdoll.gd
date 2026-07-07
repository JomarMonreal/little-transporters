extends RigidBody2D
class_name TransportRagdoll

@export var ragdoll_mass: float = 1.0

var limbs: Array[RigidBody2D] = []

func _ready() -> void:
	for child in get_children():
		if child is RigidBody2D:
			limbs.append(child)

	mass = ragdoll_mass
	for limb in limbs:
		limb.mass = ragdoll_mass

	for limb in limbs:
		limb.reparent(get_parent())
		limb.z_index = z_index - 1
		limb.modulate = limb.modulate.darkened(0.2)


func set_carrying(carrying: bool) -> void:
	var new_gravity_scale := 0.0 if carrying else 1.0
	gravity_scale = new_gravity_scale
	for limb in limbs:
		limb.gravity_scale = new_gravity_scale


func set_static(is_static: bool) -> void:
	freeze = is_static
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0


func throw(throw_velocity: Vector2) -> void:
	freeze = false
	linear_velocity = throw_velocity


func ignore_collisions_with(body: PhysicsBody2D) -> void:
	add_collision_exception_with(body)
	for limb in limbs:
		limb.add_collision_exception_with(body)


func stop_ignoring_collisions_with(body: PhysicsBody2D) -> void:
	remove_collision_exception_with(body)
	for limb in limbs:
		limb.remove_collision_exception_with(body)
