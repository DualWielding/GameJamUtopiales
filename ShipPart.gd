extends Node2D

var name
var activated = false

var _crisis = {} # { turn: "crisis_name" }

func _ready():
	add_to_group("ship part")
	var file = File.new()
	var path = str("res://Crisis/", get_name(),".json")
	if file.file_exists(path):
		file.open(path, file.READ)
		var text = file.get_as_text()
		_crisis.parse_json(text)
		file.close()
	# print something from the dictionnary for testing.
		print(get_name(), " : ", _crisis)
	else:
		print("Crisis/", get_name(), ".json does not exist !")

func activate():
	if activated:
		return
	
	activated = true
	if _crisis.has("-1"):
		Global.ship.start_crisis(_crisis["-1"])
	else:
		print(get_name(), " does not have a -1 crisis")

func start_day(day_number):
	if activated and _crisis.has(str(day_number)):
		Global.ship.start_crisis(_crisis[str(day_number)])