extends Control

func _ready():
	get_node("SamplePlayer").play("game_over")

func _on_Button_pressed():
	Global.reset()
	get_tree().change_scene("res://Menus/Menu.tscn")