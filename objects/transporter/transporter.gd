extends CharacterBody2D
class_name Transporter

@onready var states: TransporterStateManager = $StateManager
@onready var movement: PlayerSideScrollerMovement = $PlayerMovement

func get_hurt() -> void:
	# Check if a collision occurred during this frame
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		# Example check
		if collider is DangerObject:
			print("Hit a danger object!")

func _ready() -> void:
	states.init(self)
	
func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	get_hurt()
