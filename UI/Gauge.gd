extends Control

onready var gauge = get_node("TextureProgress")

func _ready():
	Global.ship.connect("update_gauge", self, "update")
	get_node("Icon").set_texture(load(str("res://Sprites/", get_name().to_lower(),".png")))
	get_start_values()

func get_start_values():
	var current = Global.ship.get(get_name().to_lower())
	gauge.set_value(current)

func update(name, current_value, max_value):
	if name.capitalize() == get_name():
		gauge.set_value(current_value)