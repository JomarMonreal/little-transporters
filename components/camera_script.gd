extends Camera2D
class_name CameraFollow

@export var target: Node2D
@export var cam_offset: Vector2 = Vector2.ZERO
@export var smooth_speed: float = 8.0

func _physics_process(delta: float) -> void:
	if not target:
		return

	var desired_position = target.global_position + cam_offset
	global_position = global_position.lerp(desired_position, clamp(delta * smooth_speed, 0.0, 1.0))
