extends Control

func _ready():
	get_node("Icon").set_texture(load(str("res://Sprites/", get_name().to_lower(),".png")))
	Global.ship.connect("update_resource", self, "update_values")
	get_start_values()

func get_start_values():
	var current = Global.ship.get(get_name().to_lower())
#	var maximum = Global.ship.get(str("max_", get_name().to_lower()))
	get_node("Label").set_text(str(current))

func update_values(name, current_value, max_value):
	if name.capitalize() == get_name():
		get_node("Label").set_text(str(current_value))