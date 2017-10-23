extends Panel

var current_crisis = {}

func add_crisis(crisis):
	current_crisis[crisis.id] = crisis

func _ready():
	pass