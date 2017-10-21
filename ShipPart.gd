extends Node2D

var name
var activated = false
var on_crisis = false

var _crisis = {} # { turn: "crisis_name" }
var current_crisis = []
var mouse_in = false

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
	
	set_process(true)

func _process(delta):
	var sprite = get_node("Sprite")
	if mouse_in:
		if sprite.get_modulate().a < 1:
			sprite.set_modulate(Color(1.0, 1.0, 1.0, sprite.get_modulate().a + delta * 2))
	elif !mouse_in and !on_crisis:
		if sprite.get_modulate().a > 0:
			sprite.set_modulate(Color(1.0, 1.0, 1.0, sprite.get_modulate().a - delta))

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
		var cr = _crisis[str(day_number)]
		cr.sector = self
		current_crisis.append(cr)
		Global.ship.start_crisis(cr)