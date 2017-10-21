extends Node

var consequences = {} setget get

func _ready():
	var file = File.new()
	if file.file_exists("res://Crisis/Consequences.json"):
		file.open("res://Crisis/Consequences.json", file.READ)
		var text = file.get_as_text()
		consequences.parse_json(text)
		file.close()
	else:
		print("Crisis/Consequences.json does not exist !")

func get(name):
	return consequences[name]