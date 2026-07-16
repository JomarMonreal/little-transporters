extends GameManagerState

@onready var canvas: Control = $CanvasLayer/Control
@onready var timer: Timer = $Timer

@onready var label1: Label = $CanvasLayer/Control/VBoxContainer/Label
@onready var label2: Label = $CanvasLayer/Control/VBoxContainer/Label2

signal finished

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	if Globals.current_cutscene == "black":
		label1.text = "To be continued..."
		label2.text = "Releasing on Steam Soon"
		timer.wait_time = 8
	else:
		label1.text = "Chapter 1"
		label2.text = "Chinoris"
		timer.wait_time = 3
	canvas.visible = false
	Dialogic.start(Globals.current_cutscene)
	await Dialogic.timeline_ended
	canvas.visible = true
	timer.start()
	toggle_state_visibility(self, true) 
	


func _on_timer_timeout() -> void:
	finished.emit()
	timer.stop()
