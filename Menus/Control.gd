extends Control

func _on_Button_pressed():
	Global.reset()
	get_tree().change_scene("res://Game.tscn")