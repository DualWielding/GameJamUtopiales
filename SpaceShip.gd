extends Node2D

# Gauges
var population = 0
var fuel = 0
var oxygen = 0

# Resources
var max_security = 50
var max_food = 50
var max_scrap = 50

var security = 0
var food = 0
var scrap = 0

var current_crisis = []

var sectors_to_activate = ["Slum"]

signal update_gauge(name, current_value, max_value)
signal update_resource(name, current_value, max_value)

func _ready():
	update_food(15)
	update_security(15)
	update_scrap(15)
	update_population(50)
	update_fuel(50)
	update_oxygen(50)
	
	Global.ship = self
	get_node("AnimationPlayer").play("Float")

func end_day():
	for crisis in current_crisis:
		apply_crisis_effects(crisis)
	
		if crisis.has("consequences") and int(crisis.consequences[0].turn) == crisis.current_turn:
			start_crisis(Consequences.get(crisis.consequences[0].name))
			stop_crisis(crisis)

func start_day(day_number):
	# Start day gain
	update_security(2)
	update_food(2)
	update_scrap(2)
	
	for sector in sectors_to_activate:
		get_node(sector).activate()
		sectors_to_activate.remove(sectors_to_activate.find(sector))
	
	for crisis in current_crisis:
		if crisis.has("end") and crisis.end.turn == crisis.current_turn:
			stop_crisis(crisis)
	
	for part in get_tree().get_nodes_in_group("ship part"):
		part.start_day(day_number)
	
	notify_current_crisis()

# Crisis related

func notify_current_crisis():
	for c in current_crisis:
		Global.ui.pop_crisis(c)

func apply_crisis_effects(crisis):
	for effect in crisis.effects:
		update_gauge(effect.gauge, effect.apply)
		if get(effect.gauge) <= 0:
			end_game(crisis)
	crisis.current_turn += 1

#	 Add
func start_crisis(crisis):
	# This crisis will be live !
	var c = crisis
	c["current_turn"] = 0
	current_crisis.append(c)
	if !c.has("appear"): return
	for appear_effect in c.appear:
		if appear_effect.has("gauge"):
			update_gauge(appear_effect.gauge.name, appear_effect.gauge.apply)
			if get(appear_effect.gauge.name) <= 0:
				end_game(c)
		if appear_effect.has("resource"):
			update_resource(appear_effect.resource.name, appear_effect.resource.apply)
		if appear_effect.has("sector"):
			sectors_to_activate.append(appear_effect.sector)

# 	Remove
func stop_crisis(crisis):
	current_crisis.remove(current_crisis.find(crisis))

func has_resources_to_resolve(crisis):
	for resolution_requirement in crisis.resolution:
		if get(resolution_requirement.ressource) + int(resolution_requirement.apply) < 0:
			return false
	return true

func resolve_crisis(crisis):
	if has_resources_to_resolve(crisis):
		for resolution_requirement in crisis.resolution:
			update_resource(resolution_requirement.ressource, int(resolution_requirement.apply))
		stop_crisis(crisis)
	
	else:
		print("Not enough resource to resolve the crisis : ", crisis.name)
	Global.ui.update_popups()

# Update gauges

func update_gauge(name, value):
	if name == "population":
		update_population(value)
	elif name == "fuel":
		update_fuel(value)
	elif name == "oxygen":
		update_oxygen(value)

func update_population(value):
	population += int(value)
	signal_gauge("population", population)

func update_fuel(value):
	fuel += value
	signal_gauge("fuel", population)

func update_oxygen(value):
	oxygen += value
	signal_gauge("oxygen", population)

func signal_gauge(name, current_value):
	emit_signal("update_gauge", name, current_value, 100)


# Update resource

func update_resource(name, value):
	if name == "security":
		update_security(value)
	elif name == "scrap":
		update_scrap(value)
	elif name == "food":
		update_food(value)

func update_security(value):
	security += value
	signal_resource("security", security, max_security)

func update_scrap(value):
	scrap += value
	signal_resource("scrap", scrap, max_scrap)

func update_food(value):
	food += value
	signal_resource("food", food, max_food)

func signal_resource(name, current_value, max_value):
	emit_signal("update_resource", name, current_value, max_value)

func end_game():
	get_tree().quit()