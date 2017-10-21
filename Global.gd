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