extends Control
class_name SuccessScreen

signal continued

@onready var time_label: Label = $VBoxContainer/TimeLabel
@onready var body_count_label: Label = $VBoxContainer/BodyCountLabel

var elapsed_time: float = 0.0
var body_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("integer_division")
	var minutes := int(elapsed_time) / 60
	var seconds := int(elapsed_time) % 60
	time_label.text = "Time -> %02d:%02d" % [minutes, seconds]
	body_count_label.text = "Body Count -> %02d" % body_count


func _on_continue_button_button_up() -> void:
	continued.emit()
	queue_free()
	pass # Replace with function body.
