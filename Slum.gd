extends "res://ShipPart.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_mouse_enter():
	get_node("AnimationPlayer").play("Appear")

func _on_Area2D_mouse_exit():
	get_node("AnimationPlayer").play_backwards("Appear")