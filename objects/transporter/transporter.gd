extends CharacterBody2D
class_name Transporter

@onready var states: TransporterStateManager = $StateManager
@onready var movement: PlayerSideScrollerMovement = $PlayerMovement
@onready var animation: AnimationPlayer = $Sprites/AnimationPlayer
@onready var sprite_group: Node2D = $Sprites
@onready var collider: Node2D = $CollisionShape2D
@onready var carry_resting_target: Node2D = $Sprites/CarryRestingPosition
@onready var carry_timer: Timer =  $CarryTimer

@export var ragdoll: PackedScene

var knockback_direction: Vector2 = Vector2.ZERO
var possible_ragdoll: TransportRagdoll
var ragdoll_to_carry: TransportRagdoll


signal dead

func get_hurt() -> void:
	if states.current_state == states.states[TransporterState.State.Dead]:
		return

	# Check if a collision occurred during this frame
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider_layer = PhysicsServer2D.body_get_collision_layer(collision.get_collider_rid())

		if collider_layer & (1 << 8):
			knockback_direction = collision.get_normal()
			states.change_state(TransporterState.State.Hurt)
			

func _attach_ragdoll_to_resting_position() -> void:
	ragdoll_to_carry.set_static(true)
	ragdoll_to_carry.reparent(carry_resting_target)
	ragdoll_to_carry.position = Vector2.ZERO
	ragdoll_to_carry.rotation = 0.0


func _ready() -> void:
	states.init(self)

func _process(delta: float) -> void:
	states.process(delta)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	get_hurt()


func _on_carry_area_body_entered(body: Node2D) -> void:
	if body is not TransportRagdoll:
		return

	possible_ragdoll = body as TransportRagdoll


func _on_carry_area_body_exited(body: Node2D) -> void:
	if body == possible_ragdoll:
		possible_ragdoll = null


func _on_carry_timer_timeout() -> void:
	_attach_ragdoll_to_resting_position()
	states.change_state(TransporterState.State.Idle)
