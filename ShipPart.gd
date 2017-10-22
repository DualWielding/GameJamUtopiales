extends Node2D

var name
var activated = false
var on_crisis = false

var _crisis = {} # { turn: "crisis_name" }
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
	else:
		print("Crisis/", get_name(), ".json does not exist !")
	
	set_process(true)
	set_process_input(true)

func reset():
	activated = false
	on_crisis = false
	
	_crisis = {} # { turn: "crisis_name" }
	mouse_in = false

func _process(delta):
	var sprite = get_node("Sprite")
	if mouse_in:
		if sprite.get_modulate().a < 1:
			sprite.set_modulate(Color(1.0, 1.0, 1.0, sprite.get_modulate().a + delta * 2))
	elif !mouse_in and !on_crisis:
		if sprite.get_modulate().a > 0:
			sprite.set_modulate(Color(1.0, 1.0, 1.0, sprite.get_modulate().a - delta))

func _input(event):
	if mouse_in\
	and event.type == InputEvent.MOUSE_BUTTON\
	and event.button_index == BUTTON_LEFT\
	and event.pressed:
		mouse_in = false
		Global.activate_popups(self)

func activate():
	if activated:
		return
	
	activated = true
	if _crisis.has("-1"):
		start_crisis(_crisis["-1"])

func start_crisis(crisis):
	get_node("Sprite").set_modulate(Color(1.0, 1.0, 1.0, 1.0))
	crisis.sector = self
	on_crisis = true
	get_node("Light2D").show()
	Global.ship.start_crisis(crisis)
	get_node("AnimationPlayer").play("Blink_light")

func stop_crisis(crisis):
	if Global.ship.get_sector_crisis_number(crisis.sector) == 0:
		on_crisis = false
		get_node("Light2D").hide()
		get_node("AnimationPlayer").stop_all()

func start_day(day_number):
	if activated and _crisis.has(str(day_number)):
		var cr = _crisis[str(day_number)]
		start_crisis(cr)