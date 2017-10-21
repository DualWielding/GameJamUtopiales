extends "res://ShipPart.gd"

func _on_Area2D_mouse_enter():
	mouse_in = true

func _on_Area2D_mouse_exit():
	mouse_in = false