extends Path2D

@export var speed = 2.0
@export var speed_scale = 1.0
@export var facing_right = true
@export var start_at_end = false

@onready var path: PathFollow2D = $PathFollow2D
@onready var animation = $AnimationPlayer
@onready var sprite: Node2D = $AnimatableBody2D/Sprite

var previous_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_position = path.global_position

	if start_at_end:
		animation.play_backwards("default")
	else:
		animation.play("default")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var delta_x := path.global_position.x - previous_position.x
	if delta_x > 0.0 and not facing_right:
		facing_right = true
		sprite.scale.x = -sprite.scale.x
	elif delta_x < 0.0 and facing_right:
		facing_right = false
		sprite.scale.x = -sprite.scale.x

	previous_position = path.global_position
