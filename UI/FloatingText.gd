extends Control

onready var ap = get_node("AnimationPlayer")

func set_text(text):
	get_node("Label").set_text(text)

func _ready():
	ap.connect("finished", self, "queue_free")
	ap.play("Float")
