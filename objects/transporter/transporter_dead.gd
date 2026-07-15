extends TransporterState

@onready var death_audio: AudioStreamPlayer = $Death
@onready var death_messages: Node2D = $DeathMessages

func enter() -> void:
	var transporter := entity as Transporter
	transporter.velocity = Vector2.ZERO
	transporter.collider.visible = false
	transporter.carry_timer.stop()
	transporter.dead.emit()
	transporter.sprite_group.queue_free()
	
	var gameplay = get_tree().get_first_node_in_group("gameplay") as Gameplay
	gameplay.transporters_died.append(transporter.name_label.text)

	if not transporter.no_ragdoll_on_death:
		var instance = transporter.ragdoll.instantiate() as Node2D
		get_tree().get_first_node_in_group("transporter_group").add_child(instance)
		instance.global_position = transporter.global_position
		instance.detach_limbs()

	var ragdoll := transporter.ragdoll_to_carry
	if ragdoll != null:
		if transporter.no_ragdoll_on_death:
			ragdoll.queue_free()
		else:
			ragdoll.reparent(transporter.get_parent())
			ragdoll.set_static(false)
	
	death_audio.play()
	await death_audio.finished
	
	var death_message = death_messages.get_children().pick_random() as AudioStreamPlayer
	death_message.play()
	await death_message.finished
	transporter.queue_free()

func physics_process(delta: float) -> int:
	var transporter := entity as Transporter
	transporter.movement.gravitate(transporter, delta)
	return TransporterState.State.Dead
