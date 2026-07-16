extends Node

const NAMES_PATH = "res://assets/json/first-names.json"
var first_names: Array = []

var current_cutscene = "chapter1"

func _ready():
	#	open the file where the JSON is stored
	var file = FileAccess.open(NAMES_PATH, FileAccess.READ)	
	var json = JSON.new()
	
	#	retrieve the JSON and parse it
	var parse_result = json.parse(file.get_as_text())
	
	#	error handeling
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", file.get_as_text(), " at line ", json.get_error_line())
	else:
		#	Put the result into a Dictionary
		var json_data: Array = json.data
		
		#	make the result reachable in the rest of the code, and test it
		first_names = json_data

func get_random_first_name() -> String:
	return first_names.pick_random()
