extends Control

onready var gauge = get_node("TextureProgress")
onready var recap = get_node("Recap")

var current_state = 0

func _ready():
	Global.ship.connect("update_gauge", self, "update")
	Global.ship.connect("add_crisis", self, "new_crisis")
	Global.ship.connect("remove_crisis", self, "crisis_solved")
	
	set_recap_text()
	get_node("Icon").set_texture(load(str("res://Sprites/", get_name().to_lower(),".png")))
	get_start_values()

func get_start_values():
	var current = Global.ship.get(get_name().to_lower())
	gauge.set_value(current)

func update(name, current_value, max_value):
	if name.capitalize() == get_name():
		gauge.set_value(current_value)

func set_recap_text():
	var text = ""
	if current_state > -1:
		text = "+"
	text = str(text, current_state)
	recap.set_text(text)

func new_crisis(crisis):
	if crisis.has("effects"):
		for effect in crisis.effects:
			if effect.has("gauge") and effect.gauge.capitalize() == get_name():
#				print("Crisis ", crisis.name, " added ", effect.apply, " to the gauge ", get_name())
				current_state += int(effect.apply)
				set_recap_text()

func crisis_solved(crisis):
#	print("triggered, ", crisis)
	if crisis.has("effects"):
		for effect in crisis.effects:
			if effect.has("gauge") and effect.gauge.capitalize() == get_name():
#				print("Crisis ", crisis.name, " removed ", effect.apply, " from the gauge ", get_name())
				current_state -= int(effect.apply)
				set_recap_text()