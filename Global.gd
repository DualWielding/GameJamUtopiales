extends Node

var ship
var ui

var current_day = 0

func reset():
	current_day = 0

func _ready():
	pass

func start():
	next_day()

func next_day():
	ship.activate_room()
	ship.end_day()
	current_day += 1
	ui.next_day()
	if current_day == 12:
		you_won()
	else:
		ship.start_day(current_day)

func you_won():
	get_tree().change_scene("res://Menus/Control.tscn")

func activate_popups(sector):
	for popup in get_tree().get_nodes_in_group("crisis popup"):
		if popup.get_crisis().sector == sector:
			popup.pop()

func activate_crisis_popup(crisis):
	for popup in get_tree().get_nodes_in_group("crisis popup"):
		if popup.get_crisis().id == crisis.id:
			popup.pop()

func translate(w):
	var word = w.to_lower()
	if word == "food":
		return "nourriture"
	if word == "fuel":
		return "carburant"
	if word == "oxygen":
		return "oxygène"
	if word == "security":
		return "unité d'intervention"
	if word == "scrap":
		return "pièces détachées"
	return word