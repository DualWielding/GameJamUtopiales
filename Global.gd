extends Node

var ship
var ui

var current_day = 0

func _ready():
	pass

func start():
	next_day()

func next_day():
	ship.activate_room()
	ship.end_day()
	current_day += 1
	ship.start_day(current_day)

func activate_popups(sector):
	for popup in get_tree().get_nodes_in_group("crisis popup"):
		if popup.get_crisis().sector == sector:
			popup.pop()